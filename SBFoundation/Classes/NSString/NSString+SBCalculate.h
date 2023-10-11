//
//  NSString+SBCalculate.h
//  Masonry
//
//  Created by 安康 on 2019/9/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (SBCalculate)

/*
 返回的字符串去除了小数点后面的0  如果计算结果为0  返回 @“0”
 */


#pragma mark - 加法运算

- (NSString *)sb_addNumberWithString:(NSString *)addValueStr;

- (NSString *)sb_addNumberWithDouble:(double)addValueDouble;

+ (NSString *)sb_addNumberWithValueDouble:(double)valueDouble
                           addValueDouble:(double)addValueDouble;


#pragma mark - 减法运算

- (NSString *)sb_subtractNumberWithString:(NSString *)subtractValueStr;

- (NSString *)subtractNumberWithDouble:(double)subtractValueDouble;

+ (NSString *)sb_subtractNumberWithValueDouble:(double)valueDouble
                           subtractValueDouble:(double)subtractValueDouble;


#pragma mark - 乘法运算

- (NSString *)sb_mutiplyNumberWithString:(NSString *)mutiplyValueStr;

- (NSString *)sb_mutiplyNumberWithDouble:(double)mutiplyValueDouble;

+ (NSString *)sb_mutiplyNumberWithValueDouble:(double)valueDouble
                           mutiplyValueDouble:(double)mutiplyValueDouble;


#pragma mark - 除法运算

- (NSString *)sb_dividNumberWithString:(NSString *)dividValueStr;

- (NSString *)sb_dividNumberWithDouble:(double)dividValueDouble;

+ (NSString *)sb_dividNumberWithDouble:(double)valueDouble
                      dividValueDouble:(double)dividValueDouble;

#pragma mark - 保留小数指定位数

+ (NSString *)sb_notRounding:(float)number afterPoint:(int)position;


@end

NS_ASSUME_NONNULL_END
