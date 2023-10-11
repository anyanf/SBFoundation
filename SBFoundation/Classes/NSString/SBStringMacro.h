//
//  SBStrinSBacro.h
//
//
//  Created by ankang on 2019/8/24.
//

#ifndef SBStrinSBacro_h
#define SBStrinSBacro_h

// 是否为NSString类型（单独处理NSMutableString）
#define SB_STR_CLASS_K(str) [str isKindOfClass:[NSString class]]
#define SB_MUT_STR_CLASS_K(mutStr) [mutStr isKindOfClass:[NSMutableString class]]

// 是否有效，不为空，且是NSString类型，且count值大于0（单独处理NSMutableString）
#define SB_STR_IS_VALID_K(str) ((str) && (SB_STR_CLASS_K(str)) && ([str length] > 0))
#define SB_MUT_STR_IS_VALID_K(mutStr) ((mutStr) && (SB_MUT_STR_CLASS_K(mstr)) && ([mutStr length] > 0))

// 格式化字符串
#define SB_STR_FORMAT_K(...) [NSString stringWithFormat:__VA_ARGS__]

// nil保护，当为nil时，返回@""，避免一些Crash
#define SB_STR_PROTECT_K(str) ((str) && (![str isKindOfClass:[NSNull class]]) ? (str) : (@""))

#endif /* SBStrinSBacro_h */
