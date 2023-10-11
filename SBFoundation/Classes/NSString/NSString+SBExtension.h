//
//  NSString+SBExtension.h
//  Masonry
//
//  Created by 安康 on 2019/9/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (SBExtension)

/** 判断字符串是否包含指定字符串 */
- (BOOL)sb_isContainString:(NSString*)str;


/** 从String类型转换为URL类型 */
- (NSURL *)sb_changeToURL;

/**
 * 返回远程推送取到的token的字符串格式
 *
 * @param  dataToken    token
 * @return token字符串
 */
+ (NSString *)sb_tokenToString:(NSData *)dataToken;


/** 去除String里面前后空格 */
- (NSString *)sb_spaceTrim;


/** 去除String里面所有空格 */
- (NSString *)sb_spaceTrimAll;


/** 过滤字符串中所有的非中文字符 */
- (NSString *)sb_filterSpecialCharNotChinese;


/** 过滤手机号中特殊字符 */
- (NSString *)sb_filterSpecialCharPhoneNum;


/** 去掉HTML中< & >内所有的内容，不过如果文本也包含 <> 也会被移除 */
- (NSString *)sb_transHTMLString;


/** 去掉HTML中\n */
- (NSString *)sb_transHTMLStringNewLineCharacter;


/** 给手机号加密，将中间的数字设置为*号（158****8888） */
- (NSString *)sb_encryptPhoneNum;


/**
 * 字符串截取前半部分
 *
 * @param  bitsInt    截取位置
 * @return 截取后字符串
 */
- (NSString *)sb_runcateStringPrefixBybits:(int)bitsInt;


/**
 * 字符串截取后半部分
 *
 * @param  bitsInt    截取位置
 * @return 截取后字符串
 */
- (NSString *)sb_truncateStringSuffixBybits:(int)bitsInt;


/** 去掉HTML中得特殊字符 */
- (NSString *)sb_deleteHTMLSpecialCharacter;


/** 获取url */
- (NSArray *)sb_getUrlFromStr;


/** 判断完整版本号的大版本号（比如：1.23的大版本号是1） */
- (NSString *)sb_mainVersionCheck;

/** 对比版本号大小 适用的格式是：1.2.2>1.2.1、1.2 > 1.1.9 、1.2 = 1.2.0 。。。也就是适用于xx.xx.xx.xx.....的纯数字版本格式 */
+ (NSInteger)compareVersion:(NSString *)version1 toVersion:(NSString *)version2;


/** 获取字符串中的所有手机号码 */
- (NSArray *)sb_regularMobileNumber;


/** 获取字符串中的所有电话号码 */
- (NSArray *)sb_regularPhoneNumber;


/** 把格式化的JSON格式的字符串转换成字典 */
- (id)sb_JSONValue;

/** 把字典或者数组转成json字符串 */
+ (NSString *)sb_JSONStringWithObj:(id)object;


/**
 * 向url字符串中拼接参数,NSDictionary 中的 key 是参数名，vaule 是参数值
 *
 * @param  params    参数字典
 * @return 拼接后字符串
 */
- (NSString *)sb_appendParamsToEnd:(NSDictionary *)params;


/**
 * 字典转换成url参数字符串,只对value encode
 *
 * @param  params    参数字典
 * @param  isNeedEncode    是否需要编码
 * @return 拼接后字符串
 */
+ (NSString *)sb_getURLParamsStringFromDictionary:(NSDictionary *)params needEncode:(BOOL)isNeedEncode;


/** 计算字符串长度 汉字算2个字符 */
- (NSUInteger)sb_lengthOfCharacter;

/** 计算中英混合长度 */
- (NSInteger)sb_mixLength;


@end

NS_ASSUME_NONNULL_END
