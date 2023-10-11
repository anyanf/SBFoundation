//
//  NSString+SBDate.m
//  Masonry
//
//  Created by 安康 on 2019/9/3.
//

#import "NSString+SBDate.h"

#import "SBStringMacro.h"

#import "NSString+SBExtension.h"

#import "NSDate+SBExtension.h"

#import "NSDateFormatter+SBExtension.h"



@implementation NSString (SBDate)


- (NSString *)sb_getTimeType:(NSString *)timetype {
    NSArray *array = [self componentsSeparatedByString:@":"];
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    
    if(array.count>1) {
        [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }else {
        [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    
    NSDate *inputDate = [inputFormatter dateFromString:self];
    [inputFormatter setDateFormat:timetype];
    return [inputFormatter stringFromDate:inputDate];
}


- (NSString *)sb_getTimeType:(NSString *)timetype originalType:(NSString *)orgionalType {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:orgionalType];
    NSDate* inputDate = [inputFormatter dateFromString:self];
    [inputFormatter setDateFormat:timetype];
    return [inputFormatter stringFromDate:inputDate];
}


#pragma mark - 对比两个时间段相隔的时间段，以秒为单位（时间为String格式，"2014-10-16 13:01:14"）

- (NSTimeInterval)sb_timeIntervalThanOldTime:(NSString *)oldTime {
    NSDateFormatter *dateFormatter = [NSDateFormatter sb_defaultDateFormatter];
    
    NSDate *curDate = [dateFormatter dateFromString:self];
    NSDate *oldDate = [dateFormatter dateFromString:oldTime];
    
    // 计算两个时间相差的秒数
    NSTimeInterval timeInterval = [curDate timeIntervalSinceDate:oldDate];
    return timeInterval;
}


#pragma mark - 对比两个时间段相隔的时间段是否超过指定时间，以秒为单位（时间为String格式，"2014-10-16 13:01:14"）

- (BOOL)sb_isTimeoutThanOldTime:(NSString *)oldTime timeout:(NSTimeInterval)timeout {
    // 计算两个时间相差的秒数
    NSTimeInterval timeInterval = [self sb_timeIntervalThanOldTime:oldTime];;
    
    // 首先当前日期必须大于之前旧日期
    if (timeInterval > 0) {
        if (timeInterval > timeout) {
            return YES;
        }
    }
    
    return NO;
}


#pragma mark - 把传入的NSTimeInterval(秒)根据SB_TimeShowMode转化为 格式为dd:HH:mm:ss/HH:mm:ss

+ (NSString *)sb_dateFromTimeinv:(NSTimeInterval)timeinv timeShowMode:(SB_TimeShowMode)timeShowMode {
    if (timeinv < 0) {
        timeinv = 0;
    }
    
    NSInteger timeInt = timeinv;
    // 获取 天 信息
    NSInteger dayInt = timeInt / SB_TIME_DAY_K;
    
    // 获取 小时 信息
    NSInteger hourInt = (timeInt % SB_TIME_DAY_K) / SB_TIME_HOUR_K;
    
    // 获取 分 信息
    NSInteger minInt = ((timeInt % SB_TIME_DAY_K) % SB_TIME_HOUR_K) / SB_TIME_MINUTE_K;
    
    // 获取 秒 信息
    NSInteger secInt = ((timeInt % SB_TIME_DAY_K) % SB_TIME_HOUR_K) % SB_TIME_MINUTE_K;
    
    switch (timeShowMode) {
            
        case SB_TimeShowMode_Day: {
            // 显示天数
            return SB_STR_FORMAT_K(@"%02ld天%02ld时%02ld分%02ld秒",
                                   (long)dayInt,
                                   (long)hourInt,
                                   (long)minInt,
                                   (long)secInt);
        }
            
        case SB_TimeShowMode_DayOnly: {
            if(dayInt <= 0) {
                return SB_STR_FORMAT_K(@"%02ld:%02ld:%02ld",
                                       (long)hourInt,
                                       (long)minInt,
                                       (long)secInt);
            }
            return SB_STR_FORMAT_K(@"%@天",@(dayInt));
        }
            
        case SB_TimeShowMode_AvailableDay: {
            if(dayInt <= 0) {
                return SB_STR_FORMAT_K(@"%02ld时%02ld分%02ld秒",
                                       (long)hourInt,
                                       (long)minInt,
                                       (long)secInt);
            }
            return SB_STR_FORMAT_K(@"%02ld天%02ld时%02ld分%02ld秒",
                                   (long)dayInt,
                                   (long)hourInt,
                                   (long)minInt,
                                   (long)secInt);
        }
            
        default: {
            // 不显示天数
            NSInteger intHours = dayInt * 24 + hourInt;
            intHours = ((hourInt > 99) ? (99) : (hourInt));
            return SB_STR_FORMAT_K(@"%02ld:%02ld:%02ld",
                                   (long)hourInt,
                                   (long)minInt,
                                   (long)secInt);
        };
    }
}


#pragma mark - 将时间信息根据格式进行信息拆分eg:(33:02:50:00)->天:33,小时:2,分:50,秒:0

- (NSDictionary *)sb_getTimeInfWithTimeFmt:(NSString *)fmtStr {
    
    NSString *timeStr = [self mutableCopy];
    
    NSMutableDictionary *timeMutDic = [NSMutableDictionary dictionary];
    
    if (fmtStr) {
        if ([fmtStr sb_isContainString:@"ss"]) {
            NSRange rangeSS = [fmtStr rangeOfString:@"ss"];
            [timeMutDic setValue:[timeStr substringWithRange:rangeSS] forKey:@"ss"];
        }
        
        if ([fmtStr sb_isContainString:@"mm"]) {
            NSRange rangeSS = [fmtStr rangeOfString:@"mm"];
            [timeMutDic setValue:[timeStr substringWithRange:rangeSS] forKey:@"mm"];
        }
        
        if ([fmtStr sb_isContainString:@"HH"]) {
            NSRange rangeSS = [fmtStr rangeOfString:@"HH"];
            [timeMutDic setValue:[timeStr substringWithRange:rangeSS] forKey:@"HH"];
        }
        
        if ([fmtStr sb_isContainString:@"dd"]) {
            NSRange rangeSS = [fmtStr rangeOfString:@"dd"];
            [timeMutDic setValue:[timeStr substringWithRange:rangeSS] forKey:@"dd"];
        }
    } else {
        NSInteger timeInt = [timeStr doubleValue];
        
        if (timeInt < 0) {
            timeInt = 0;
        }
        /// 获取 天 信息
        NSInteger dayInt = timeInt / (60 * 60 * 24);
        [timeMutDic setValue:@(dayInt) forKey:@"dd"];
        
        /// 获取 小时 信息
        NSInteger hourInt = (timeInt % (60 * 60 * 24)) / (60 * 60);
        [timeMutDic setValue:@(hourInt) forKey:@"HH"];
        
        /// 获取 分 信息
        NSInteger minInt = ((timeInt % (60 * 60 * 24)) % (60 * 60)) / 60;
        [timeMutDic setValue:@(minInt) forKey:@"mm"];
        
        /// 获取 秒 信息
        NSInteger secInt = ((timeInt % (60 * 60 * 24)) % (60 * 60)) % 60;
        [timeMutDic setValue:@(secInt) forKey:@"ss"];
    }
    
    return [NSDictionary dictionaryWithDictionary:timeMutDic];
}


#pragma mark - 将描述的时间转换成时间戳(秒)

- (NSTimeInterval)sb_getTimeIntervalWithTimeFmt:(NSString *)fmtStr {
    
    NSString *timeStr = [self mutableCopy];

    NSDictionary *timeInfDic = [timeStr sb_getTimeInfWithTimeFmt:fmtStr];
    
    NSTimeInterval timeinv = [timeInfDic[@"ss"] doubleValue]
    + [timeInfDic[@"mm"] doubleValue]*SB_TIME_MINUTE_K
    + [timeInfDic[@"HH"] doubleValue]*SB_TIME_HOUR_K
    + [timeInfDic[@"dd"] doubleValue]*SB_TIME_DAY_K;
    return timeinv;
}


#pragma mark - 格式化时间戳

+ (NSString *)sb_formattedTimeFromTimeInterval:(double)time {
    return [[NSDate sb_dateWithTimeIntervalInMilliSecondSince1970:time] sb_formattedTime];
}

+ (NSString *)sb_formattedTimeFileTimeInterval:(double)time {
    return [[NSDate sb_dateWithTimeIntervalInMilliSecondSince1970:time] sb_formattedFileTime];
}

+ (NSString *)sb_formattedSystemTimeFromTimeInterval:(double)time {
    return [[NSDate sb_dateWithTimeIntervalInMilliSecondSince1970:time] sb_formattedSystemTime];
}



@end
