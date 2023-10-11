//
//  NSDateFormatter+SBExtension.m
//  Masonry
//
//  Created by 安康 on 2019/9/7.
//

#import "NSDateFormatter+SBExtension.h"

@implementation NSDateFormatter (SBExtension)

+ (id)sb_dateFormatterWithFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[self alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

+ (id)sb_defaultDateFormatter
{
    return [self sb_dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}


@end
