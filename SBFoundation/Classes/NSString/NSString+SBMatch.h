//
//  NSString+SBRegexp.h
//  Masonry
//
//  Created by 安康 on 2019/9/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (SBMatch)


#pragma mark - ************************* 通用的校验方法，判断字符串是否符合传入的正则表达式 ****************

- (BOOL)sb_regexCheck:(NSString *)regexStr;

#pragma mark - ******************************** 校验公共方法  *******************************


/** 检验移动手机号码 */
- (BOOL)sb_checkMobileNumber;


/** 检验身份证号码 */
- (BOOL)sb_checkIdentityCard;


/** 校验是否只有汉字 */
- (BOOL)sb_checkChineseCharacter;


/** 校验是否只有数字 */
- (BOOL)sb_checkOnlyNum;

/** 校验是否只有数字,带小数点 */
- (BOOL)sb_checkOnlyFloatNum;

/** 校验是否只有字母 */
- (BOOL)sb_CheckOnlyLetter;


/** 校验是否为汉字字母 */
- (BOOL)sb_isChineseAndEnglish;


/** 严格校验手机号码、座机号 */
- (BOOL)sb_isTelNumber;


/** 严格校验手机号码 */
- (BOOL)sb_isTelPhoneNumber;


/** 判断是否为有效邮箱 */
- (BOOL)sb_isEmailAddress;


/** 是否为有效身份证号码 */
- (BOOL)sb_isIDCardNumber;


/** 校验是否只有数字和字母 */
- (BOOL)sb_checkOnlyNumAndLetter;


/** 校验是否为字母、数字、下划线 */
- (BOOL)sb_checkOnlyNumAndLetterAnd_ ;


/** 检验姓名 */
- (BOOL)sb_checkName;


/** 校验邮箱 */
- (BOOL)sb_checkEmail;


/** 校验URL */
- (BOOL)sb_checkURL;


/** 校验图片URL */
- (BOOL)sb_checkImageURL;


/** 检查银行卡格式是否正确 */
- (BOOL)sb_checkBankNumber;


/** 是否是无效自负，包括空字符串，空格 */
+ (BOOL)sb_isBlankString:(NSString *)string;


/** 判断字符串中是否全为空格 */
- (BOOL)sb_checkAllWhitespace;


/** 判断字符串中是否全是换行符 */
- (BOOL)sb_checkAllReturnLine;


/** 车牌号验证 MODIFIED BY HELENSONG */
- (BOOL)sb_checkCarNo;


/** 输入中是否含有emoji表情  */
- (BOOL)sb_isStringContainsEmoji;


/** 是否有效手机号，只校验数字及位数 */
- (BOOL)sb_isAvailablePhoneNumber;


/**
 @brief     是否符合最小长度、最长长度，是否包含中文,首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)sb_isValidWithMinLenth:(NSInteger)minLenth
                      maxLenth:(NSInteger)maxLenth
                containChinese:(BOOL)containChinese
           firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,数字，字母，其他字符，首字母是否可以为数字，新增
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     containDigtal   包含数字
 @param     containLetter   包含字母
 @param     containOtherCharacter   其他字符
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)sb_isValidWithMinLenth:(NSInteger)minLenth
                      maxLenth:(NSInteger)maxLenth
                containChinese:(BOOL)containChinese
                 containDigtal:(BOOL)containDigtal
                 containLetter:(BOOL)containLetter
         containOtherCharacter:(NSString *)containOtherCharacter
           firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;



/** 校验登录用户名 */
- (BOOL)sb_CheckLoginUserName;


// 校验登录密码
- (BOOL)sb_checkLoginPassWordWithLoginUserName:(NSString *)strUserName;


/** 校验是否昵称 */
- (BOOL)sb_checkNickname;


/** 校验组织机构代码（在填写订单页面填写发票信息时用到） */
- (BOOL)sb_checkOrganizationCode;


/** 是否符合密码设置要求，包含两种字符以上 */
- (BOOL)isAccordWithPassWord;


@end

NS_ASSUME_NONNULL_END
