//
//  NSString+SBURLEncode.h
//  Masonry
//
//  Created by 安康 on 2019/9/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (SBURLEncode)

/** 获取字符串url */
- (NSURL *)sb_url;

/** url编码 */
- (NSString *)sb_urlEncode;

/** url解码 */
- (NSString *)sb_urlDecode;

/** 查询是否已Encode,暂不考虑已被encode两次以上的情况 */
- (BOOL)sb_checkEncode;

/** 安全Encode，避免二次Encode */
- (NSString *)sb_urlSafeEncode;

@end

NS_ASSUME_NONNULL_END
