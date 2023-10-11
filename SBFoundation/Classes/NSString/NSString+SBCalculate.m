//
//  NSString+SBCalculate.m
//  Masonry
//
//  Created by 安康 on 2019/9/5.
//

#import "NSString+SBCalculate.h"

#import "SBStringMacro.h"

@implementation NSString (SBCalculate)

/*
 返回的字符串去除了小数点后面的0  如果计算结果为0  返回 @“0”
 */

// 加法运算 self + strAddValue
- (NSString *)sb_addNumberWithString:(NSString *)addValueStr {

    if (!SB_STR_IS_VALID_K(addValueStr)) {
        return self;
    }
    
    NSDecimalNumber *dnumberStrFirstValue = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *dnumberStrSectondValue = [NSDecimalNumber decimalNumberWithString:addValueStr];
    NSDecimalNumber *dnumberProduct = [dnumberStrFirstValue decimalNumberByAdding:dnumberStrSectondValue];
    return [dnumberProduct stringValue];
}

- (NSString *)sb_addNumberWithDouble:(double)addValueDouble {
    NSString *str = [[NSNumber numberWithDouble:addValueDouble] stringValue];
    return [self sb_addNumberWithString:str];
    
}

+ (NSString *)sb_addNumberWithValueDouble:(double)valueDouble
                           addValueDouble:(double)addValueDouble {
    NSString *strFir = [[NSNumber numberWithDouble:valueDouble] stringValue];
    NSString *strSec = [[NSNumber numberWithDouble:addValueDouble] stringValue];
    return [strFir sb_addNumberWithString:strSec];
}

// 减法运算 self - strSectondValue
- (NSString *)sb_subtractNumberWithString:(NSString *)subtractValueStr {
    if (!SB_STR_IS_VALID_K(subtractValueStr)) {
        return self;
    }
    
    NSDecimalNumber *dnumberStrFirstValue = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *dnumberStrSectondValue = [NSDecimalNumber decimalNumberWithString:subtractValueStr];
    NSDecimalNumber *dnumberProduct = [dnumberStrFirstValue decimalNumberBySubtracting:dnumberStrSectondValue];
    return [dnumberProduct stringValue];
}

- (NSString *)subtractNumberWithDouble:(double)subtractValueDouble {
    NSString *str = [[NSNumber numberWithDouble:subtractValueDouble] stringValue];
    return [self sb_subtractNumberWithString:str];
    
}

+ (NSString *)sb_subtractNumberWithValueDouble:(double)valueDouble
                           subtractValueDouble:(double)subtractValueDouble {
    NSString *strFir = [[NSNumber numberWithDouble:valueDouble] stringValue];
    NSString *strSec = [[NSNumber numberWithDouble:subtractValueDouble] stringValue];
    return [strFir sb_subtractNumberWithString:strSec];
}

// 乘法运算 self * strMutiplyValue
- (NSString *)sb_mutiplyNumberWithString:(NSString *)mutiplyValueStr {
    if (!SB_STR_IS_VALID_K(mutiplyValueStr)) {
        return self;
    }
    
    NSDecimalNumber *dnumberStrFirstValue = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *dnumberStrSectondValue = [NSDecimalNumber decimalNumberWithString:mutiplyValueStr];
    NSDecimalNumber *dnumberProduct = [dnumberStrFirstValue decimalNumberByMultiplyingBy:dnumberStrSectondValue];
    return [dnumberProduct stringValue];
}

- (NSString *)sb_mutiplyNumberWithDouble:(double)mutiplyValueDouble {
    NSString *str = [[NSNumber numberWithDouble:mutiplyValueDouble] stringValue];
    
    return [self sb_mutiplyNumberWithString:str];
    
}

+ (NSString *)sb_mutiplyNumberWithValueDouble:(double)valueDouble
                        mutiplyValueDouble:(double)mutiplyValueDouble {
    NSString *strFir = [[NSNumber numberWithDouble:valueDouble] stringValue];
    NSString *strSec = [[NSNumber numberWithDouble:mutiplyValueDouble] stringValue];
    
    return [strFir sb_mutiplyNumberWithString:strSec];
}

// 除法运算 self / strDividValue
- (NSString *)sb_dividNumberWithString:(NSString *)dividValueStr {
    if (!SB_STR_IS_VALID_K(dividValueStr)) {
        return self;
    }
    
    NSDecimalNumber *dnumberStrFirstValue = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *dnumberStrSectondValue = [NSDecimalNumber decimalNumberWithString:dividValueStr];
    if ([[dnumberStrSectondValue stringValue] isEqualToString:@"0"]) {
        return self;
    }
    
    NSDecimalNumber *dnumberProduct = [dnumberStrFirstValue decimalNumberByDividingBy:dnumberStrSectondValue];
    return [dnumberProduct stringValue];
}

- (NSString *)sb_dividNumberWithDouble:(double)dividValueDouble {
    NSString *str = [[NSNumber numberWithDouble:dividValueDouble] stringValue];
    return [self sb_dividNumberWithString:str];
}

+ (NSString *)sb_dividNumberWithDouble:(double)valueDouble
                   dividValueDouble:(double)dividValueDouble {
    NSString *strFir = [[NSNumber numberWithDouble:valueDouble] stringValue];
    NSString *strSec = [[NSNumber numberWithDouble:dividValueDouble] stringValue];
    return [strFir sb_dividNumberWithString:strSec];
}

+ (NSString *)sb_notRounding:(float)number afterPoint:(int)position {
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                                                                                      scale:position
                                                                                           raiseOnExactness:NO
                                                                                            raiseOnOverflow:NO
                                                                                           raiseOnUnderflow:NO
                                                                                        raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:number];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];

    return [NSString stringWithFormat:@"%@",roundedOunces];
}

@end
