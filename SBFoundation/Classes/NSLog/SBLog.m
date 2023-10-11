//
//  SBLog.m
//  Masonry
//
//  Created by 安康 on 2019/9/10.
//

#import "SBLog.h"



#ifdef  DEBUG

#define InternalLog(format, ...) do { \
fprintf(stderr,"%s\n", [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]); \
} while (0);

#else

#define InternalLog(...)      do { } while (0);

#endif

@implementation SBLog

+ (void)printLogWithFile:(NSString *)fileName
                    line:(NSInteger)lineNum
                userInfo:(NSString *)userInfo
                 comInfo:(NSString *)comInfo
                showInfo:(id)showInfo {
    if (!showInfo) {
        fprintf(stderr,"%s\n", [[NSString stringWithFormat:@"%@ <%@ : %tu> %@", userInfo, fileName, lineNum, comInfo] UTF8String]);
    } else {
        fprintf(stderr,"%s\n", [[NSString stringWithFormat:@"%@ <%@ : %tu> %@  %@", userInfo, fileName, lineNum, comInfo, showInfo] UTF8String]);
    }
}


@end
