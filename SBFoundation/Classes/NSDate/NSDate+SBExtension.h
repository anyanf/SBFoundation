//
//  NSDate+SBExtension.h
//  Masonry
//
//  Created by 安康 on 2019/9/7.
//



NS_ASSUME_NONNULL_BEGIN

#pragma mark - 时间相关的定义，秒、分、时、天、年

// 秒
extern const int SB_TIME_SECOND_K;
// 分
extern const int SB_TIME_MINUTE_K;
// 时
extern const int SB_TIME_HOUR_K;
// 天
extern const int SB_TIME_DAY_K;
// 年
extern const int SB_TIME_YEAR_K;

typedef NS_ENUM (NSUInteger, SB_DateUnit) {
    // 年
    SB_DateUnit_Year = 0,
    // 月
    SB_DateUnit_Month,
    // 日
    SB_DateUnit_Day,
    // 时
    SB_DateUnit_Hour,
    // 分
    SB_DateUnit_Minute
};


@interface NSDate (SBExtension)

/** 距离当前的时间间隔描述 */
- (NSString *)sb_timeIntervalDescription;

/** 格式化date */
- (NSString *)sb_timeIntervalWithFormatter:(NSString *)formatter;

/** system标准时间日期描述 */
- (NSString *)sb_formattedSystemTime;

/** 文件传输标准时间日期描述 */
- (NSString *)sb_formattedFileTime;

/** 标准时间日期描述 */
- (NSString *)sb_formattedTime;

+ (NSDate *)sb_dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;

/** 时间日期转换 */
+ (NSDate *)sb_dateFromStringOrNumber:(id)dateString;

/** 时间日期转换 */
+ (NSDate *)sb_dateFromStringOrNumber:(id)dateString withFormater:(NSString *)fmt;

/**
 * 获取传入NSDate的年、月、日、时、分
 *
 * @param  dateUnit    想要获取的时间类型 年、月、日、时、分
 * @return 传入NSDate的年、月、日、时、分
 */
- (NSInteger)sb_getDateWithDateUnit:(SB_DateUnit)dateUnit;

/**
 * 对比新旧两个时间，判断时候已经过了旧的时间那一天 （可能一天，两天，三天...）
 *
 * @param  oldDate    旧时间
 * @return YES过了旧时间那天，NO没过
 */
- (BOOL)sb_isPassOldDate:(NSDate *)oldDate;


#pragma mark - 相对于当前时间的时间

+ (NSDate *)sb_dateWithDaysFromNow:(NSInteger)days;

+ (NSDate *)sb_dateWithDaysBeforeNow:(NSInteger)days;

+ (NSDate *)sb_dateTomorrow;

+ (NSDate *)sb_dateYesterday;

+ (NSDate *)sb_dateWithHoursFromNow:(NSInteger)dHours;

+ (NSDate *)sb_dateWithHoursBeforeNow:(NSInteger)dHours;

+ (NSDate *)sb_dateWithMinutesFromNow:(NSInteger)dMinutes;

+ (NSDate *)sb_dateWithMinutesBeforeNow:(NSInteger)dMinutes;


#pragma mark - 对比时间

- (BOOL)sb_isEqualToDateIgnoringTime:(NSDate *)aDate;

- (BOOL)sb_isToday;

- (BOOL)sb_isTomorrow;

- (BOOL)sb_isYesterday;

// This hard codes the assumption that a week is 7 days
- (BOOL)sb_isSameWeekAsDate:(NSDate *)aDate;

- (BOOL)sb_isThisWeek;

- (BOOL)sb_isNextWeek;

- (BOOL)sb_isLastWeek;

- (BOOL)sb_isSameMonthAsDate:(NSDate *)aDate;

- (BOOL)sb_isThisMonth;

- (BOOL)sb_isSameYearAsDate:(NSDate *)aDate;

- (BOOL)sb_isThisYear;

- (BOOL)sb_isNextYear;

- (BOOL)sb_isLastYear;

- (BOOL)sb_isEarlierThanDate:(NSDate *)aDate;

- (BOOL)sb_isLaterThanDate:(NSDate *)aDate;

- (BOOL)sb_isInFuture;

- (BOOL)sb_isInPast;

/** 是周末 */
- (BOOL)sb_isTypicallyWeekend;

/** 是工作日 */
- (BOOL)sb_isTypicallyWorkday;


#pragma mark - 调整时间

- (NSDate *)sb_dateByAddingDays:(NSInteger)dDays;

- (NSDate *)sb_dateBySubtractingDays:(NSInteger)dDays;

- (NSDate *)sb_dateByAddingHours:(NSInteger)dHours;

- (NSDate *)sb_dateBySubtractingHours:(NSInteger)dHours;

- (NSDate *)sb_dateByAddingMinutes:(NSInteger)dMinutes;

- (NSDate *)sb_dateBySubtractingMinutes:(NSInteger)dMinutes;

- (NSDate *)sb_dateAtStartOfDay;

- (NSDateComponents *)sb_componentsWithOffsetFromDate:(NSDate *)aDate;


#pragma mark - 获取具体时间差

- (NSInteger)sb_secondsAfterDate:(NSDate *)aDate;

- (NSInteger)sb_minutesAfterDate:(NSDate *)aDate;

- (NSInteger)sb_minutesBeforeDate:(NSDate *)aDate;

- (NSInteger)sb_hoursAfterDate:(NSDate *)aDate;

- (NSInteger)sb_hoursBeforeDate:(NSDate *)aDate;

- (NSInteger)sb_daysAfterDate:(NSDate *)aDate;

- (NSInteger)sb_daysBeforeDate:(NSDate *)aDate;

- (NSInteger)sb_distanceInDaysToDate:(NSDate *)anotherDate;


#pragma mark - 分解日期
@property (nonatomic, readonly) NSInteger sb_nearestHour;
@property (nonatomic, readonly) NSInteger sb_hour;
@property (nonatomic, readonly) NSInteger sb_minute;
@property (nonatomic, readonly) NSInteger sb_seconds;
@property (nonatomic, readonly) NSInteger sb_day;
@property (nonatomic, readonly) NSInteger sb_month;
@property (nonatomic, readonly) NSInteger sb_week;
@property (nonatomic, readonly) NSInteger sb_weekday;
@property (nonatomic, readonly) NSInteger sb_nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (nonatomic, readonly) NSInteger sb_year;

@end

NS_ASSUME_NONNULL_END
