//
//  SBLog.h
//  Masonry
//
//  Created by 安康 on 2019/9/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - ********************************** 测试环境下才显示Log *********************************

#ifdef  DEBUG

#define NSLog(format, ...) do { \
fprintf(stderr, ".... NSLog(🛠) .... <%s : %d> %s %s\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __func__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]); \
} while (0);

#else

#define NSLog(...)      do { } while (0);

#endif

#pragma mark - ************************************* 基础打印信息 ************************************

#pragma mark 打印LOG使用，能打印LOG所在的文件，函数名等细节

#define SB_FUNC_NAME_K [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding]

#pragma mark 调用公共方法打印LOG printLogWithFile:nil line:nil UserInfo:nil comInfo:nil showInfo:nil

#define SB_LOG_PRINT(userInfoStr, ...) [SBLog printLogWithFile:[[NSString stringWithUTF8String:__FILE__] lastPathComponent] \
                                                          line:__LINE__ \
                                                      userInfo:userInfoStr \
                                                       comInfo:SB_FUNC_NAME_K \
                                                      showInfo:[NSString stringWithFormat:__VA_ARGS__]];


#define LOG_USERINFO_AK @"🍎🍎🍎🍎AnKang🍎🍎🍎🍎"   // 安康LOG
#define LOG_USERINFO_XHD @"☀️☀️☀️☀️XieHaiDuo☀️☀️☀️☀️"   // 安康LOG

#ifdef LOG_USERINFO_AK
#define LOG_AK SB_LOG_PRINT(LOG_USERINFO_AK, @"");
#define LOG_AK_(...) SB_LOG_PRINT(LOG_USERINFO_AK, __VA_ARGS__);
#else
#define LOG_AK {};
#define LOG_AK_(...) {};
#endif

#ifdef LOG_USERINFO_XHD
#define LOG_XHD SB_LOG_PRINT(LOG_USERINFO_XHD, @"");
#define LOG_XHD_(...) SB_LOG_PRINT(LOG_USERINFO_XHD, __VA_ARGS__);
#else
#define LOG_XHD {};
#define LOG_XHD_(...) {};
#endif



@interface SBLog : NSObject


+ (void)printLogWithFile:(NSString *)fileName
                    line:(NSInteger)lineNum
                userInfo:(NSString *)userInfo
                 comInfo:(NSString *)comInfo
                showInfo:(id)showInfo;

@end

NS_ASSUME_NONNULL_END
