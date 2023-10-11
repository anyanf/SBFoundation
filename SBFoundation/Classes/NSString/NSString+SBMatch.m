//
//  NSString+SBRegexp.m
//  Masonry
//
//  Created by 安康 on 2019/9/5.
//

#import "NSString+SBMatch.h"

#import "SBStringMacro.h"

@implementation NSString (SBMatch)

#pragma mark - ************************* 通用的校验方法，判断字符串是否符合传入的正则表达式 ****************

- (BOOL)sb_regexCheck:(NSString *)regexStr {
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexStr];
    
    return [pred evaluateWithObject:self];
}

#pragma mark - ******************************** 校验公共方法  *******************************


#pragma mark - 检验移动手机号码

- (BOOL)sb_checkMobileNumber {
    // 只做最简单的校验，首位是否为1，是否为11个数字
    return [self sb_regexCheck:@"(1)[0-9]{10}$"];
}


#pragma mark - 检验身份证号码

- (BOOL)sb_checkIdentityCard {
    // 老身份证15位，新身份证18位（最后一位可能是X）
    return [self sb_regexCheck:@"^(\\d{14}|\\d{17})(\\d|[xX])$"];
}

#pragma mark - 校验是否只有汉字

- (BOOL)sb_checkChineseCharacter {
    return [self sb_regexCheck:@"^[\u4e00-\u9fa5]*$"];
}


#pragma mark - 校验是否只有数字

- (BOOL)sb_checkOnlyNum {
    return [self sb_regexCheck:@"^[0-9]{0,}$"];
}

#pragma mark - 校验是否只有数字,带小数点

- (BOOL)sb_checkOnlyFloatNum {
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

#pragma mark - 校验是否只有字母

- (BOOL)sb_CheckOnlyLetter {
    return [self sb_regexCheck:@"^[a-zA-Z]{0,}$"];
}


#pragma mark -  校验是否为汉字字母

- (BOOL)sb_isChineseAndEnglish {
    NSString* regex = @"^[A-Za-z\u4e00-\u9fa5]*$";
    return [[self uppercaseString] sb_regexCheck:regex];
}

- (BOOL)sb_isTelNumber {
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    return [self sb_regexCheck:MOBILE] | [self sb_regexCheck:CM] | [self sb_regexCheck:CU] | [self sb_regexCheck:CT] | [self sb_regexCheck:PHS];
}
- (BOOL)sb_isTelPhoneNumber {
    NSString * regex = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    return [self sb_regexCheck:regex];
}

- (BOOL)sb_isEmailAddress {
    NSString* regex = @"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*";
    return [self sb_regexCheck:regex];
}

- (BOOL)sb_isIDCardNumber {
    NSString* regex = @"(^\\d{15}$)|(^\\d{17}([0-9]|X)$)";//@"\\d{15}|\\d{18}";
    return [self sb_regexCheck:regex];
}

#pragma mark - 校验是否只有数字和字母

- (BOOL)sb_checkOnlyNumAndLetter {
    return [self sb_regexCheck:@"^[a-zA-Z0-9]{0,}$"];
}

#pragma mark - 校验是否为字母、数字、下划线

- (BOOL)sb_checkOnlyNumAndLetterAnd_ {
    return [self sb_regexCheck:@"^[a-zA-Z0-9_]{0,}$"];
}

#pragma mark - 检验姓名

- (BOOL)sb_checkName {
    
    // 姓名，至少两个字符
    if (self.length < 2)
    {
        return NO;
    }
    
    // 新疆姓名单独处理，这个中间点不好找啊！
    if ([[self substringToIndex:1] isEqualToString:@"•"]
        || [[self substringToIndex:1] isEqualToString:@"·"]
        || [[self substringFromIndex:self.length-1] isEqualToString:@"•"]
        || [[self substringFromIndex:self.length-1] isEqualToString:@"·"]) {
        return NO;
    }
    
    /// 姓名包含汉字、字母
    return [self sb_regexCheck:@"^[a-zA-Z\u4e00-\u9fa5•·]+$"];
}

#pragma mark - 校验邮箱

// 校验邮箱
- (BOOL)sb_checkEmail {
    if ([self sb_regexCheck:@"\\b([a-zA-Z0-9%_.+\\-]{1,}+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"] &&
        (self.length > 4)) {
        return YES;
    }
    return NO;
}

#pragma mark - 校验URL

- (BOOL)sb_checkURL {
    return ([self hasPrefix:@"http:"] || [self hasPrefix:@"https:"] || [self hasPrefix:@"file:"]);
}

#pragma mark - 校验图片URL

- (BOOL)sb_checkImageURL {
    if (![self sb_checkURL]) { // 不是URL,直接返回NO
        return NO;
    }
    // 对URL转码，处理URL中有汉字的情况
    NSString *strCode = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // 获取img的URL
    NSURL *urlImg = [NSURL URLWithString:strCode];
    
    // 根据urlImg的path是否为空来判断是否为图片地址
    return SB_STR_IS_VALID_K([urlImg path]);
}

#pragma mark - 检查银行卡格式是否正确

- (BOOL)sb_checkBankNumber {
    return [self sb_regexCheck:@"[0-9]{19}"];
}

#pragma mark - 是否是无效自负，包括空字符串，空格

+ (BOOL)sb_isBlankString:(NSString *)string {
    if (!SB_STR_IS_VALID_K(string)) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

#pragma mark - 判断字符串中是否全为空格

- (BOOL)sb_checkAllWhitespace {
    // 将空格替换为空字符
    NSString *strResult = [self stringByReplacingOccurrencesOfString:@" "
                                                          withString:@""];
    
    // 删除完空格后是否为空来判断字符串中是否全为空格
    return !SB_STR_IS_VALID_K(strResult);
}

#pragma mark - 判断字符串中是否全是换行符

- (BOOL)sb_checkAllReturnLine {
    /// 将空格替换为空字符
    NSString *strResult = [self stringByReplacingOccurrencesOfString:@"\n"
                                                          withString:@""];
    
    /// 删除完空格后是否为空来判断字符串中是否全为空格
    return !SB_STR_IS_VALID_K(strResult);
}

/** 车牌号验证 MODIFIED BY HELENSONG */
- (BOOL)sb_checkCarNo {
    return [self sb_regexCheck:@"^[A-Za-z]{1}[A-Za-z_0-9]{5}$"];
}

- (BOOL)sb_isStringContainsEmoji {
    
    NSString *candidate = [self mutableCopy];
    
    __block BOOL returnValue = NO;
    [candidate enumerateSubstringsInRange:NSMakeRange(0, [candidate length])
                                  options:NSStringEnumerationByComposedCharacterSequences
                               usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                   const unichar high = [substring characterAtIndex: 0];
                                   
                                   // Surrogate pair (U+1D000-1F9FF)
                                   if (0xD800 <= high && high <= 0xDBFF) {
                                       const unichar low = [substring characterAtIndex: 1];
                                       const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
                                       
                                       if (0x1D000 <= codepoint && codepoint <= 0x1F9FF){
                                           returnValue = YES;
                                       }
                                       
                                       // Not surrogate pair (U+2100-27BF)
                                   } else {
                                       if (0x2100 <= high && high <= 0x27BF){
                                           returnValue = YES;
                                       }
                                   }
                               }];
    return returnValue;
}

- (BOOL)sb_isAvailablePhoneNumber {
    return [self sb_regexCheck:@"(1)[0-9]{10}$"];
}

- (BOOL)sb_isValidWithMinLenth:(NSInteger)minLenth
                      maxLenth:(NSInteger)maxLenth
                containChinese:(BOOL)containChinese
           firstCannotBeDigtal:(BOOL)firstCannotBeDigtal {
    //  [\u4e00-\u9fa5A-Za-z0-9_]{4,20}
    NSString *hanzi = containChinese ? @"\u4e00-\u9fa5" : @"";
    NSString *first = firstCannotBeDigtal ? @"^[a-zA-Z_]" : @"";
    
    NSString *regex = [NSString stringWithFormat:@"%@[%@A-Za-z0-9_]{%d,%d}", first, hanzi, (int)(minLenth-1), (int)(maxLenth-1)];
    return [self sb_regexCheck:regex];
}

- (BOOL)sb_isValidWithMinLenth:(NSInteger)minLenth
                      maxLenth:(NSInteger)maxLenth
                containChinese:(BOOL)containChinese
                 containDigtal:(BOOL)containDigtal
                 containLetter:(BOOL)containLetter
         containOtherCharacter:(NSString *)containOtherCharacter
           firstCannotBeDigtal:(BOOL)firstCannotBeDigtal {
    NSString *hanzi = containChinese ? @"\u4e00-\u9fa5" : @"";
    NSString *first = firstCannotBeDigtal ? @"^[a-zA-Z_]" : @"";
    NSString *lengthRegex = [NSString stringWithFormat:@"(?=^.{%@,%@}$)", @(minLenth), @(maxLenth)];
    NSString *digtalRegex = containDigtal ? @"(?=(.*\\d.*){1})" : @"";
    NSString *letterRegex = containLetter ? @"(?=(.*[a-zA-Z].*){1})" : @"";
    NSString *characterRegex = [NSString stringWithFormat:@"(?:%@[%@A-Za-z0-9%@]+)", first, hanzi, containOtherCharacter ? containOtherCharacter : @""];
    NSString *regex = [NSString stringWithFormat:@"%@%@%@%@", lengthRegex, digtalRegex, letterRegex, characterRegex];
    return [self sb_regexCheck:regex];
}


#pragma mark - 校验登录用户名

// 校验登录用户名
- (BOOL)sb_CheckLoginUserName {
    // 校验字数长度
    if ((self.length < 6) || (self.length > 20)) {
        return NO;
    }
    
    // 用户名包含字母、数字、下划线
    if([self sb_checkOnlyNumAndLetterAnd_]) {
        return YES;
    }
    
    return NO;
}

#pragma mark - 校验登录密码

// 校验登录密码
- (BOOL)sb_checkLoginPassWordWithLoginUserName:(NSString *)strUserName {
    // 校验字数长度
    if ((self.length < 6) || (self.length > 20)) {
        return NO;
    }
    
    // 密码不能与账户名相同 ？？？这个与业余有关联，是否需要放在这里
    if ([self isEqualToString:strUserName]) {
        return NO;
    }
    
    // 密码不能为纯数字 ？？？这个与业余有关联，是否需要放在这里
    if ([self sb_checkOnlyNum]) {
        return NO;
    }
    
    // 密码包含字母、数字、...
    if ([self sb_regexCheck:@"^[a-zA-Z0-9_;',./\\[\\]\\\\]{0,}$"]) {
        return YES;
    }
    
    return YES;
}

#pragma mark - 校验是否昵称

// 校验是否昵称
- (BOOL)sb_checkNickname {
    /// 字母、数字、下划线、中划线、汉字
    return [self sb_regexCheck:@"^[a-zA-Z0-9\u4e00-\u9fa5_-]*$"];
}

#pragma mark - 校验组织机构代码（在填写订单页面填写发票信息时用到）

// 校验组织机构代码（在填写订单页面填写发票信息时用到）
- (BOOL)sb_checkOrganizationCode {
    return [self sb_regexCheck:@"^[a-zA-Z0-9]{8}-[a-zA-Z0-9]{1}$"];
}


- (BOOL)isAccordWithPassWord {
    
    NSString *password = [self mutableCopy];
    
    // 數字條件
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]"
                                                                                           options:NSRegularExpressionCaseInsensitive
                                                                                             error:nil];
    
    // 符合數字條件的有幾個字元
    NSInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:password
                                                                      options:NSMatchingReportProgress
                                                                        range:NSMakeRange(0, password.length)];
    
    // 英文字條件
    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]"
                                                                                              options:NSRegularExpressionCaseInsensitive
                                                                                                error:nil];
    
    // 符合英文字條件的有幾個字元
    NSInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:password
                                                                            options:NSMatchingReportProgress
                                                                              range:NSMakeRange(0, password.length)];
    
    if (tNumMatchCount == password.length) {
        // 全部符合數字，表示沒有英文
        return NO;
    } else if (tLetterMatchCount == password.length) {
        // 全不符合英文，表示沒有數字
        return NO;
    } else if (tNumMatchCount + tLetterMatchCount == password.length) {
        // 符合英文和符合數字條件的相加等於密碼長度
        return YES;
    } else if (password.length == password.length- tLetterMatchCount - tNumMatchCount) {
        // 纯特殊字符
        return NO;
    } else {
        return YES;
    }
    return YES;
}

@end
