//
//  NSDate+SBExtension.m
//  Masonry
//
//  Created by 安康 on 2019/9/7.
//

#import "NSDate+SBExtension.h"

#import "NSDateFormatter+SBExtension.h"


const int SB_TIME_SECOND_K  =  1.0;
const int SB_TIME_MINUTE_K  =  60*SB_TIME_SECOND_K;
const int SB_TIME_HOUR_K    =  60*SB_TIME_MINUTE_K;
const int SB_TIME_DAY_K     =  24*SB_TIME_HOUR_K;
const int SB_TIME_WEEK_K    =  7*SB_TIME_DAY_K;
const int SB_TIME_MON_K     =  30*SB_TIME_DAY_K;
const int SB_TIME_YEAR_K    =  365*SB_TIME_DAY_K;


static const NSUInteger kDateComponents = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal;

@implementation NSDate (SBExtension)


// 距离当前的时间间隔描述
- (NSString *)sb_timeIntervalDescription {
    NSTimeInterval timeInterval = -[self timeIntervalSinceNow];
    if (timeInterval < 60) {
        return @"1分钟内";
    } else if (timeInterval < SB_TIME_HOUR_K) {
        return [NSString stringWithFormat:@"%.f分钟前", timeInterval / 60];
    } else if (timeInterval < SB_TIME_DAY_K) {
        return [NSString stringWithFormat:@"%.f小时前", timeInterval / 3600];
    } else if (timeInterval < SB_TIME_MON_K) {//30天内
        return [NSString stringWithFormat:@"%.f天前", timeInterval / 86400];
    } else if (timeInterval < SB_TIME_YEAR_K) {//30天至1年内
        NSDateFormatter *dateFormatter = [NSDateFormatter sb_dateFormatterWithFormat:@"M月d日"];
        return [dateFormatter stringFromDate:self];
    } else {
        return [NSString stringWithFormat:@"%.f年前", timeInterval / 31536000];
    }
}


- (NSString *)sb_timeIntervalWithFormatter:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [NSDateFormatter sb_dateFormatterWithFormat:formatter];
    return [dateFormatter stringFromDate:self];
}



// system标准时间日期描述
- (NSString *)sb_formattedSystemTime {
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString * dateNow = [formatter stringFromDate:[NSDate date]];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:[[dateNow substringWithRange:NSMakeRange(6,2)] intValue]];
    [components setMonth:[[dateNow substringWithRange:NSMakeRange(4,2)] intValue]];
    [components setYear:[[dateNow substringWithRange:NSMakeRange(0,4)] intValue]];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [gregorian dateFromComponents:components]; //今天 0点时间
    
    NSInteger hour = [self sb_hoursAfterDate:date];
    NSDateFormatter *dateFormatter = nil;
    NSString *ret = @"";
    
    //hasAMPM==TURE为12小时制，否则为24小时制
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;
    if (!hasAMPM) { //24小时制
        if (hour <= 24 && hour >= 0) {
            dateFormatter = [NSDateFormatter sb_dateFormatterWithFormat:@"HH:mm"];
            //        当天，小显示具体时间，17:21
            //            （2）当年隔天，显示月日+时间， 6月15日 09:15
            //            （3）跨年的消息，显示年月日 +时间 ， 2017年5月1日 16:00
            
        }else if (hour < 0 && hour >= -24 * 365) {
            dateFormatter = [NSDateFormatter sb_dateFormatterWithFormat:@"M月dd日 HH:mm"];
        }else {
            dateFormatter = [NSDateFormatter sb_dateFormatterWithFormat:@"yyyy年M月dd日 HH:mm"];
        }
    }else {
        if (hour <= 24 && hour >= 0) {
            dateFormatter = [NSDateFormatter sb_dateFormatterWithFormat:@"HH:mm"];
            //        当天，小显示具体时间，17:21
            //            （2）当年隔天，显示月日+时间， 6月15日 09:15
            //            （3）跨年的消息，显示年月日 +时间 ， 2017年5月1日 16:00
            
        }else if (hour < 0 && hour >= -24 * 365) {
            dateFormatter = [NSDateFormatter sb_dateFormatterWithFormat:@"M月dd日 HH:mm"];
        }else {
            dateFormatter = [NSDateFormatter sb_dateFormatterWithFormat:@"yyyy年M月dd日 HH:mm"];
        }
    }
    ret = [dateFormatter stringFromDate:self];
    return ret;
    
}


// 文件传输标准时间日期描述
- (NSString *)sb_formattedFileTime {
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString * dateNow = [formatter stringFromDate:[NSDate date]];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:[[dateNow substringWithRange:NSMakeRange(6,2)] intValue]];
    [components setMonth:[[dateNow substringWithRange:NSMakeRange(4,2)] intValue]];
    [components setYear:[[dateNow substringWithRange:NSMakeRange(0,4)] intValue]];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [gregorian dateFromComponents:components]; //今天 0点时间
    
    NSInteger hour = [self sb_hoursAfterDate:date];
    NSDateFormatter *dateFormatter = nil;
    NSString *ret = @"";
    
    //hasAMPM==TURE为12小时制，否则为24小时制
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;
    if (!hasAMPM) { //24小时制
        if (hour <= 24 && hour >= 0) {
            dateFormatter = [NSDateFormatter sb_dateFormatterWithFormat:@"HH:mm"];
            //        当天，小显示具体时间，17:21
            //            （2）当年隔天，显示月日+时间， 6月15日 09:15
            //            （3）跨年的消息，显示年月日 +时间 ， 2017年5月1日 16:00
            
        }else {
            dateFormatter = [NSDateFormatter sb_dateFormatterWithFormat:@"yyyy/M/dd"];
        }
    }else {
        if (hour <= 24 && hour >= 0) {
            dateFormatter = [NSDateFormatter sb_dateFormatterWithFormat:@"HH:mm"];
            //        当天，小显示具体时间，17:21
            //            （2）当年隔天，显示月日+时间， 6月15日 09:15
            //            （3）跨年的消息，显示年月日 +时间 ， 2017年5月1日 16:00
            
        }else {
            dateFormatter = [NSDateFormatter sb_dateFormatterWithFormat:@"yyyy/M/dd"];
        }
    }
    ret = [dateFormatter stringFromDate:self];
    return ret;
    
}

// 标准时间日期描述
- (NSString *)sb_formattedTime {
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString * dateNow = [formatter stringFromDate:[NSDate date]];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:[[dateNow substringWithRange:NSMakeRange(6,2)] intValue]];
    [components setMonth:[[dateNow substringWithRange:NSMakeRange(4,2)] intValue]];
    [components setYear:[[dateNow substringWithRange:NSMakeRange(0,4)] intValue]];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [gregorian dateFromComponents:components]; //今天 0点时间
    
    NSInteger hour = [self sb_hoursAfterDate:date];
    NSDateFormatter *dateFormatter = nil;
    NSString *ret = @"";
    
    //hasAMPM==TURE为12小时制，否则为24小时制
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;
    
    if (!hasAMPM) { //24小时制
        if (hour <= 24 && hour > 0) {
            dateFormatter = [NSDateFormatter sb_dateFormatterWithFormat:@"HH:mm"];
            //        }else if (hour < 0 && hour >= -24) {
            //            超出24小时，显示月，日，格式:4/28
            //            超出一年，显示年月日，格式:15/2/24
        }else if (hour <= 0 && hour >= -24 * 365) {
            dateFormatter = [NSDateFormatter sb_dateFormatterWithFormat:@"M/dd"];
        }else {
            dateFormatter = [NSDateFormatter sb_dateFormatterWithFormat:@"yyyy-MM-dd"];
        }
    }else {
        if (hour >= 0 && hour <= 6) {
            dateFormatter = [NSDateFormatter sb_dateFormatterWithFormat:@"凌晨hh:mm"];
        }else if (hour > 6 && hour <=11 ) {
            dateFormatter = [NSDateFormatter sb_dateFormatterWithFormat:@"上午hh:mm"];
        }else if (hour > 11 && hour <= 17) {
            dateFormatter = [NSDateFormatter sb_dateFormatterWithFormat:@"下午hh:mm"];
        }else if (hour > 17 && hour <= 24) {
            dateFormatter = [NSDateFormatter sb_dateFormatterWithFormat:@"晚上hh:mm"];
        }else if (hour < 0 && hour >= -24){
            dateFormatter = [NSDateFormatter sb_dateFormatterWithFormat:@"M/dd"];
        }else  {
            dateFormatter = [NSDateFormatter sb_dateFormatterWithFormat:@"M/dd"];
        }
        
    }
    
    ret = [dateFormatter stringFromDate:self];
    return ret;
}



+ (NSDate *)sb_dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond {
    NSDate *ret = nil;
    double timeInterval = timeIntervalInMilliSecond;
    // judge if the argument is in secconds(for former data structure).
    if(timeIntervalInMilliSecond > 140000000000) {
        timeInterval = timeIntervalInMilliSecond / 1000;
    }
    ret = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    return ret;
}

// 时间日期转换
+ (NSDate *)sb_dateFromStringOrNumber:(id)dateString {
    return [self sb_dateFromStringOrNumber:[NSDateFormatter sb_defaultDateFormatter]];
}

/** 时间日期转换 */
+ (NSDate *)sb_dateFromStringOrNumber:(id)dateString withFormater:(NSString *)fmt {
    if ([dateString isKindOfClass:[NSNumber class]]) {
        dateString = [dateString stringValue];
    }
    
    if (![dateString isKindOfClass:[NSString class]]) {
        return [NSDate date];
    }
    
    NSDate *date = [[NSDateFormatter sb_dateFormatterWithFormat:fmt] dateFromString:dateString];
    
    if (date) {
        return date;
    }
    
    if ([dateString length] > 10) {
        dateString = [dateString substringToIndex:10];
    }
    
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:[dateString doubleValue]];
    
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //    NSDate *endDate = [dateFormatter dateFromString:string];
    //    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:endDate];
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    //    NSDate *newDate= [dateFormatter dateFromString:dateString];
    
    return newDate;
}

#pragma mark 获取传入时间是年、月、日、时、分

- (NSInteger)sb_getDateWithDateUnit:(SB_DateUnit)dateUnit {
    NSDate *todayDate = self;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger flagsInt = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitWeekOfMonth;
    NSDateComponents *dateComponent = [calendar components:flagsInt fromDate:todayDate];
    
    NSInteger dateInt;
    
    switch (dateUnit)
    {
            // 年
        case SB_DateUnit_Year:
            
            dateInt = [dateComponent year];
            
            break;
            
            // 月
        case SB_DateUnit_Month:
            
            dateInt = [dateComponent month];
            
            break;
            
            // 日
        case SB_DateUnit_Day:
            
            dateInt = [dateComponent day];
            
            break;
            
            // 时
        case SB_DateUnit_Hour:
            
            dateInt = [dateComponent hour];
            
            break;
            
            // 分
        case SB_DateUnit_Minute:
            
            dateInt = [dateComponent minute];
            
            break;
            
        default:
            break;
    }
    
    return dateInt;
}

#pragma mark 判断是否是新的一天

- (BOOL)sb_isPassOldDate:(NSDate *)oldDate {
    if ([self sb_getDateWithDateUnit:SB_DateUnit_Day] > [oldDate sb_getDateWithDateUnit:SB_DateUnit_Day]) {
        return YES;
    } else {
        return NO;
    }
}


#pragma mark Relative Dates

+ (NSDate *)sb_dateWithDaysFromNow:(NSInteger)days {
    // Thanks, Jim Morrison
    return [[NSDate date] sb_dateByAddingDays:days];
}

+ (NSDate *)sb_dateWithDaysBeforeNow:(NSInteger)days {
    // Thanks, Jim Morrison
    return [[NSDate date] sb_dateBySubtractingDays:days];
}

+ (NSDate *)sb_dateTomorrow {
    return [NSDate sb_dateWithDaysFromNow:1];
}

+ (NSDate *)sb_dateYesterday {
    return [NSDate sb_dateWithDaysBeforeNow:1];
}

+ (NSDate *)sb_dateWithHoursFromNow:(NSInteger)dHours {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + SB_TIME_HOUR_K * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)sb_dateWithHoursBeforeNow:(NSInteger)dHours {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - SB_TIME_HOUR_K * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)sb_dateWithMinutesFromNow:(NSInteger)dMinutes {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + SB_TIME_MINUTE_K * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)sb_dateWithMinutesBeforeNow:(NSInteger)dMinutes {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - SB_TIME_MINUTE_K * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark Comparing Dates

- (BOOL)sb_isEqualToDateIgnoringTime:(NSDate *)aDate {
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:kDateComponents fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

- (BOOL)sb_isToday {
    return [self sb_isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL)sb_isTomorrow {
    return [self sb_isEqualToDateIgnoringTime:[NSDate sb_dateTomorrow]];
}

- (BOOL)sb_isYesterday {
    return [self sb_isEqualToDateIgnoringTime:[NSDate sb_dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL)sb_isSameWeekAsDate:(NSDate *)aDate {
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:kDateComponents fromDate:aDate];
    
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (components1.weekOfYear != components2.weekOfYear) return NO;
    
    // Must have a time interval under 1 week. Thanks @aclark
    return (fabs([self timeIntervalSinceDate:aDate]) < SB_TIME_WEEK_K);
}

- (BOOL)sb_isThisWeek {
    return [self sb_isSameWeekAsDate:[NSDate date]];
}

- (BOOL)sb_isNextWeek {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + SB_TIME_WEEK_K;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self sb_isSameWeekAsDate:newDate];
}

- (BOOL)sb_isLastWeek {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - SB_TIME_WEEK_K;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self sb_isSameWeekAsDate:newDate];
}

// Thanks, mspasov
- (BOOL)sb_isSameMonthAsDate:(NSDate *)aDate {
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL)sb_isThisMonth {
    return [self sb_isSameMonthAsDate:[NSDate date]];
}

- (BOOL)sb_isSameYearAsDate:(NSDate *)aDate {
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:aDate];
    return (components1.year == components2.year);
}

- (BOOL)sb_isThisYear {
    // Thanks, baspellis
    return [self sb_isSameYearAsDate:[NSDate date]];
}

- (BOOL)sb_isNextYear {
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year + 1));
}

- (BOOL)sb_isLastYear {
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year - 1));
}

- (BOOL)sb_isEarlierThanDate:(NSDate *)aDate {
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL)sb_isLaterThanDate:(NSDate *)aDate {
    return ([self compare:aDate] == NSOrderedDescending);
}

// Thanks, markrickert
- (BOOL)sb_isInFuture {
    return ([self sb_isLaterThanDate:[NSDate date]]);
}

// Thanks, markrickert
- (BOOL)sb_isInPast {
    return ([self sb_isEarlierThanDate:[NSDate date]]);
}


#pragma mark Roles
- (BOOL)sb_isTypicallyWeekend {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}

- (BOOL)sb_isTypicallyWorkday {
    return ![self sb_isTypicallyWeekend];
}

#pragma mark Adjusting Dates

- (NSDate *)sb_dateByAddingDays:(NSInteger)dDays {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + SB_TIME_DAY_K * dDays;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)sb_dateBySubtractingDays:(NSInteger)dDays {
    return [self sb_dateByAddingDays:(dDays * -1)];
}

- (NSDate *)sb_dateByAddingHours:(NSInteger)dHours {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + SB_TIME_HOUR_K * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)sb_dateBySubtractingHours:(NSInteger)dHours {
    return [self sb_dateByAddingHours:(dHours * -1)];
}

- (NSDate *)sb_dateByAddingMinutes:(NSInteger)dMinutes {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + SB_TIME_MINUTE_K * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)sb_dateBySubtractingMinutes:(NSInteger)dMinutes {
    return [self sb_dateByAddingMinutes:(dMinutes * -1)];
}

- (NSDate *)sb_dateAtStartOfDay {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (NSDateComponents *)sb_componentsWithOffsetFromDate:(NSDate *)aDate {
    NSDateComponents *dTime = [[NSCalendar currentCalendar] components:kDateComponents fromDate:aDate toDate:self options:0];
    return dTime;
}

#pragma mark Retrieving Intervals
- (NSInteger)sb_secondsAfterDate:(NSDate *)aDate {
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) ti;
}


- (NSInteger)sb_minutesAfterDate:(NSDate *)aDate {
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / SB_TIME_MINUTE_K);
}

- (NSInteger)sb_minutesBeforeDate:(NSDate *)aDate {
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / SB_TIME_MINUTE_K);
}

- (NSInteger)sb_hoursAfterDate:(NSDate *)aDate {
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / SB_TIME_HOUR_K);
}

- (NSInteger)sb_hoursBeforeDate:(NSDate *)aDate {
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / SB_TIME_HOUR_K);
}

- (NSInteger)sb_daysAfterDate:(NSDate *)aDate {
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / SB_TIME_DAY_K);
}

- (NSInteger)sb_daysBeforeDate:(NSDate *)aDate {
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / SB_TIME_DAY_K);
}

// Thanks, dmitrydims
// I have not yet thoroughly tested this
- (NSInteger)sb_distanceInDaysToDate:(NSDate *)anotherDate {
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    return components.day;
}

#pragma mark Decomposing Dates

- (NSInteger)sb_nearestHour {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + SB_TIME_MINUTE_K * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:newDate];
    return components.hour;
}

- (NSInteger)sb_hour {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    return components.hour;
}

- (NSInteger)sb_minute {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    return components.minute;
}

- (NSInteger)sb_seconds {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    return components.second;
}

- (NSInteger)sb_day {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    return components.day;
}

- (NSInteger)sb_month {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    return components.month;
}

- (NSInteger)sb_week {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    return components.weekOfYear;
}

- (NSInteger)sb_weekday {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    return components.weekday;
}

// e.g. 2nd Tuesday of the month is 2
- (NSInteger)sb_nthWeekday {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    return components.weekdayOrdinal;
}

- (NSInteger)sb_year {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    return components.year;
}



@end
