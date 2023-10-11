//
//  NSString+SBExtension.m
//  Masonry
//
//  Created by 安康 on 2019/9/3.
//

#import "NSString+SBExtension.h"

#import "SBStringMacro.h"

#import "NSString+SBURLEncode.h"

@implementation NSString (SBExtension)

// 判断字符串是否包含指定字符串
- (BOOL)sb_isContainString:(NSString*)str {
    NSRange range = [self rangeOfString:str];
    return (range.location != NSNotFound);
}

// 从String类型转换为URL类型
- (NSURL *)sb_changeToURL {
    // 对URL转码，处理URL中有汉字的情况，并转换成URL
    return [NSURL URLWithString:[self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

// 返回远程推送取到的token的字符串格式，
+ (NSString *)sb_tokenToString:(NSData *)dataToken {
    NSString *strToken = dataToken.description;
    
    strToken = [strToken stringByReplacingOccurrencesOfString:@"<" withString:@""];
    strToken = [strToken stringByReplacingOccurrencesOfString:@">" withString:@""];
    strToken = [strToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return strToken;
}

// 去除String里面前后空格
- (NSString *)sb_spaceTrim {
    // 将所有空格替换为空字符
    NSString *resultStr = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // 加入nil保护
    return SB_STR_PROTECT_K(resultStr);
}

// 去除String里面所有空格
- (NSString *)sb_spaceTrimAll {
    // 将所有空格替换为空字符
    NSString *resultStr = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // 加入nil保护
    return SB_STR_PROTECT_K(resultStr);
}

// 过滤字符串中所有的非中文字符
- (NSString *)sb_filterSpecialCharNotChinese {
    
    NSString * resultStr = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    resultStr = [resultStr stringByReplacingOccurrencesOfString:@"null" withString:@""];
    
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    resultStr = [resultStr stringByTrimmingCharactersInSet:whitespace];
    return SB_STR_PROTECT_K(resultStr);
}

// 过滤手机号中特殊字符
- (NSString *)sb_filterSpecialCharPhoneNum {
    
    NSString *phoneStr = [self mutableCopy];
    
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@"(" withString:@""];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@")" withString:@""];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@"." withString:@""];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    phoneStr = [phoneStr stringByTrimmingCharactersInSet:whitespace];
    
    // 如果以86开头，且传过来的手机号长度为13，取86后面的字符串
    if ([self hasPrefix:@"86"] && self.length == 13) {
        phoneStr = [self substringFromIndex:1];
    }
    
    return SB_STR_PROTECT_K(phoneStr);
}

// 去掉HTML中< & >内所有的内容，不过如果文本也包含 <> 也会被移除
- (NSString *)sb_transHTMLString {
    NSString *string = [self mutableCopy];
    
    // 去掉HTML中< & >内所有的内容，不过如果文本也包含 <> 也会被移除
    NSRange range;
    while ((range = [string rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound) {
        string = [string stringByReplacingCharactersInRange:range withString:@""];
    }
    return SB_STR_PROTECT_K(string);
}

// 去掉HTML中\n
- (NSString *)sb_transHTMLStringNewLineCharacter {
    NSString *string = [self mutableCopy];
    
    NSRange range;
    while ((range = [string rangeOfString:@"\n" options:NSRegularExpressionSearch]).location != NSNotFound){
        string = [string stringByReplacingCharactersInRange:range withString:@""];
    }
    return SB_STR_PROTECT_K(string);
}

// 给手机号加密，将中间的数字设置为*号（158****8888）
- (NSString *)sb_encryptPhoneNum {
    NSInteger length = [self length];
    // 此处没有安装11位手机号判断，这样的话当是固定电话时，也能用，呵呵。。。
    // 固定电话，目前最少7位数字
    if (length >= 7) {
        NSString *tempString =  [self stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        return tempString;
    }

    // 如果不正确，原路返回
    return self;
}

// 字符串截取前半部分
- (NSString *)sb_runcateStringPrefixBybits:(int)bitsInt {
    NSUInteger length = self.length;
    NSUInteger index = 0;
    if (bitsInt > 0) {
        if (bitsInt<=length) {
            index = bitsInt;
        } else {
            index = length;
        }
    }
    NSString *subStr = [self substringToIndex:index];
    
    return SB_STR_PROTECT_K(subStr);
}

// 字符串截取后半部分
- (NSString *)sb_truncateStringSuffixBybits:(int)bitsInt {
    NSUInteger length = self.length;
    NSUInteger index = 0;
    if (length >= bitsInt) {
        if ((length - bitsInt) >= length) {
            index = length;
        } else {
            index = length - bitsInt;
        }
    }
    NSString *subStr = [self substringFromIndex:index];
    return SB_STR_PROTECT_K(subStr);
}

/// 去掉HTML中得特殊字符
- (NSString *)sb_deleteHTMLSpecialCharacter {
    
    NSString *str = [self mutableCopy];
    
    while ([str sb_isContainString:@"&quot"] ||   // "
           [str sb_isContainString:@"&amp"] ||    // &
           [str sb_isContainString:@"&lt"] ||     // <
           [str sb_isContainString:@"&gt"] ||     // >
           [str sb_isContainString:@"&nbsp"]) {   // 不断开空格(non-breaking space)
        
        NSString * replaceStr;
        if ([str sb_isContainString:@"&quot"]) {
            replaceStr = @"&quot";
        }
        else if ([str sb_isContainString:@"&amp"]) {
            replaceStr = @"&amp";
        }
        else if ([str sb_isContainString:@"&lt"]) {
            replaceStr = @"&lt";
        }
        else if ([str sb_isContainString:@"&gt"]) {
            replaceStr = @"&gt";
        }
        else if ([str sb_isContainString:@"&nbsp;"]) { // &nbsp; 要求直接转义为空格 。。。。
            replaceStr = @"&nbsp;";
            return [str stringByReplacingOccurrencesOfString:replaceStr withString:@" "];
        }
        
        str = [str stringByReplacingOccurrencesOfString:replaceStr withString:@""];
    }
    
    return SB_STR_PROTECT_K(str);
}


// 获取url
- (NSArray *)sb_getUrlFromStr {

    NSString *str = [self mutableCopy];
    
    NSMutableArray *mutAry = [NSMutableArray array];
    NSString *regulaStr = @"((http|ftp|https)://)(([a-zA-Z0-9\\._-]+\\.[a-zA-Z]{2,6})|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}))(:[0-9]{1,4})*(/[a-zA-Z0-9\\&%_\\./-~-]*)?|(([a-zA-Z0-9\\._-]+\\.[a-zA-Z]{2,6})|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}))(:[0-9]{1,4})*(/[a-zA-Z0-9\\&%_\\./-~-]*)?";
    
    NSError *error = NULL;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:str
                                                options:0
                                                  range:NSMakeRange(0,
                                                                    [str length])];
    
    for (NSTextCheckingResult *match in arrayOfAllMatches)
    {
        NSValue *value = [NSValue valueWithRange:match.range];
        [mutAry addObject:value];
    }
    
    return mutAry;
}

// 判断完整版本号的大版本号（比如：1.23的大版本号是1）
- (NSString *)sb_mainVersionCheck {
    
    NSString *strFullVersion = [self mutableCopy];
    
    // 从字符.中分隔成n个元素的数组
    NSArray *array = [strFullVersion componentsSeparatedByString:@"."];
    
    return SB_STR_PROTECT_K(array[0]);
}

// 对比版本号大小 适用的格式是：1.2.2>1.2.1、1.2 > 1.1.9 、1.2 = 1.2.0 。。。也就是适用于xx.xx.xx.xx.....的纯数字版本格式
+ (NSInteger)compareVersion:(NSString *)version1 toVersion:(NSString *)version2
{
    NSArray *list1 = [version1 componentsSeparatedByString:@"."];
    NSArray *list2 = [version2 componentsSeparatedByString:@"."];
    for (int i = 0; i < list1.count || i < list2.count; i++)
    {
        NSInteger a = 0, b = 0;
        if (i < list1.count) {
            a = [list1[i] integerValue];
        }
        if (i < list2.count) {
            b = [list2[i] integerValue];
        }
        if (a > b) {
            return 1; // version1大于version2
        } else if (a < b) {
            return -1; // version1小于version2
        }
    }
    return 0; //version1等于version2
    
}

// 获取字符串中的所有手机号码
- (NSArray *)sb_regularMobileNumber {
    NSMutableArray * mobileMutAry = [NSMutableArray array];
    
    NSString * searchRegular = @"1[3|4|5|7|8][0-9]\\d{8}";
    NSRegularExpression * regex = [[NSRegularExpression alloc] initWithPattern:searchRegular
                                                                       options:NSRegularExpressionCaseInsensitive
                                                                         error:nil];
    NSArray * matchs = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    for (NSTextCheckingResult * match in matchs) {
        NSString * matchStr = [self substringWithRange:match.range];
        [mobileMutAry addObject:matchStr];
    }
    return mobileMutAry;
}

// 获取字符串中的所有电话号码
- (NSArray *)sb_regularPhoneNumber {
    NSMutableArray * phoneMutAry = [NSMutableArray array];

    // 不带区号的电话
    NSString * searchRegular = @"\\d{7,8}";
    NSRegularExpression * regex = [[NSRegularExpression alloc] initWithPattern:searchRegular
                                                                       options:NSRegularExpressionCaseInsensitive
                                                                         error:nil];
    NSArray * matchs = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];

    
    // 带区号的电话
    searchRegular = @"(\\d{3,4}-)\\d{7,8}";
    regex = [[NSRegularExpression alloc] initWithPattern:searchRegular
                                                 options:NSRegularExpressionCaseInsensitive
                                                   error:nil];
    matchs = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    for (NSTextCheckingResult * match in matchs) {
        NSString * matchStr = [self substringWithRange:match.range];
        [phoneMutAry addObject:matchStr];
    }
    
    // 要求 只要是数字就可以 最少4位  最大15位
    searchRegular = @"\\d{5,15}";
    regex = [[NSRegularExpression alloc] initWithPattern:searchRegular
                                                 options:NSRegularExpressionCaseInsensitive
                                                   error:nil];
    matchs = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    for (NSTextCheckingResult * match in matchs) {
        NSString * matchStr = [self substringWithRange:match.range];
        [phoneMutAry addObject:matchStr];
    }
    
    return phoneMutAry;
}


// 把格式化的JSON格式的字符串转换成字典
- (id)sb_JSONValue {

    NSString *jsonString = [self mutableCopy];
    
    /// 避免包含制表符等出现的json解析失败，先进行过滤
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id json = [NSJSONSerialization JSONObjectWithData:jsonData
                                              options:NSJSONReadingMutableContainers
                                                error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return json;
}

// 把字典或者数组转成json字符串
+ (NSString *)sb_JSONStringWithObj:(id)object {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&parseError];
    if(parseError) {
        NSLog(@"json解析失败：%@",parseError);
        return nil;
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

// 向url字符串中拼接参数,NSDictionary 中的 key 是参数名，vaule 是参数值
- (NSString *)sb_appendParamsToEnd:(NSDictionary *)params {
    NSURL *url = [NSURL URLWithString:self];
    if (url) {
        
        NSString *paramsStr = [NSString sb_getURLParamsStringFromDictionary:params needEncode:NO];
        BOOL containQuery = url.query.length > 0;
        paramsStr = SB_STR_FORMAT_K(@"%@%@", containQuery ? @"&" : @"?", paramsStr);
        
        return [self stringByAppendingString:paramsStr];
    }
    return @"";
}


// 字典转换成url参数字符串,只对value encode
+ (NSString *)sb_getURLParamsStringFromDictionary:(NSDictionary *)params needEncode:(BOOL)isNeedEncode {
    
    NSMutableArray *marr = [NSMutableArray array];
    for (NSString *key in params.allKeys) {
        NSString *valueStr = SB_STR_PROTECT_K(params[key]);
        
        if (isNeedEncode) {
            valueStr = [valueStr sb_urlSafeEncode];
        }
        
        [marr addObject:[NSString stringWithFormat:@"%@=%@", key, valueStr]];
    }
    NSString *paramsStr = [marr componentsJoinedByString:@"&"];
    return paramsStr;
}



// 计算字符串长度 汉字算2个字符
- (NSUInteger)sb_lengthOfCharacter {
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < self.length; i++) {
        unichar uc = [self characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return asciiLength;
}

// 计算中英混合长度
- (NSInteger)sb_mixLength {
    NSInteger strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];

    for (int i=0; i < [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            p++;
            strlength++;
        } else {
            p++;
        }
    }
    return strlength;
}



@end
