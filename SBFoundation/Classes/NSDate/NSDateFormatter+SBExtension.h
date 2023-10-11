//
//  NSDateFormatter+SBExtension.h
//  Masonry
//
//  Created by 安康 on 2019/9/7.
//



NS_ASSUME_NONNULL_BEGIN

@interface NSDateFormatter (SBExtension)

+ (id)sb_dateFormatterWithFormat:(NSString *)dateFormat;

+ (id)sb_defaultDateFormatter;/*yyyy-MM-dd HH:mm:ss*/

@end

NS_ASSUME_NONNULL_END
