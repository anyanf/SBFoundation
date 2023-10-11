//
//  NSString+SBDate.h
//  Masonry
//
//  Created by 安康 on 2019/9/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



typedef NS_ENUM(NSUInteger, SB_TimeShowMode) {
    // 倒计时不显示天,以99小时为界限，大于99显示99
    SB_TimeShowMode_NoDay = 0,
    // 倒计时显示天和小时数      eg: 1天20时20分20秒
    SB_TimeShowMode_Day,
    // 天大于0时，倒计时显示天和小时数，小于等于0时，显示小时数
    SB_TimeShowMode_AvailableDay,
    // 倒计时显示天             eg: 1天
    // 大于一天的情况不显示小时数，如果小于一天，显示小时数
    SB_TimeShowMode_DayOnly
};


@interface NSString (SBDate)


/**
 * 返回对应格式的时间
 *
 * @param  timetype 时间格式
 * @return 返回对应格式的时间
 */
- (NSString *)sb_getTimeType:(NSString *)timetype;


/**
 * 返回对应新格式的时间
 *
 * @param  timetype    新时间格式
 * @param  orgionalType 旧时间格式
 * @return 返回对应新格式的时间
 */
- (NSString *)sb_getTimeType:(NSString *)timetype originalType:(NSString *)orgionalType;


/**
 * 对比两个时间段相隔的时间段，以秒为单位（时间为String格式，"2014-10-16 13:01:14"）
 *
 * @param  oldTime    旧时间
 * @return 相隔的时间段，以秒为单位
 */
- (NSTimeInterval)sb_timeIntervalThanOldTime:(NSString *)oldTime;


/**
 * 对比两个时间段相隔的时间段，以秒为单位（时间为String格式，"2014-10-16 13:01:14"）
 *
 * @param  oldTime    旧时间
 * @param  timeout    超时时间段
 * @return YES 已经超时，NO 没有超时
 */
- (BOOL)sb_isTimeoutThanOldTime:(NSString *)oldTime timeout:(NSTimeInterval)timeout;


/**
 * 把传入的NSTimeInterval(秒)根据SB_TimeShowMode转化为 格式为dd:HH:mm:ss/HH:mm:ss
 *
 * @param  timeinv    传入的秒
 * @param  timeShowMode    时间展示类型
 * @return 返回相应的时间格式
 */
+ (NSString *)sb_dateFromTimeinv:(NSTimeInterval)timeinv timeShowMode:(SB_TimeShowMode)timeShowMode;


/**
 *  将时间信息根据格式进行信息拆分eg:(33:02:50:00)则天:33,小时:2,分:50,秒:0
 *
 *  @param fmtStr  时间格式(必须和拆分时间的格式一样,如果是时间戳可不传)
 *  @return 存放了时间详细信息的字典
 */
- (NSDictionary *)sb_getTimeInfWithTimeFmt:(NSString *)fmtStr;


/**
 *  将描述的时间转换成时间戳(秒)eg:(01:01:01)->3661
 *
 *  @param fmtStr  strTime的时间格式(必须和strTime时间的格式一样,如果是时间戳可不传)
 *  @return 返回的时间戳(秒)
 */
- (NSTimeInterval)sb_getTimeIntervalWithTimeFmt:(NSString *)fmtStr;


#pragma mark - 格式化时间戳

+ (NSString *)sb_formattedTimeFromTimeInterval:(double)time;

+ (NSString *)sb_formattedTimeFileTimeInterval:(double)time;

+ (NSString *)sb_formattedSystemTimeFromTimeInterval:(double)time;



@end

NS_ASSUME_NONNULL_END
