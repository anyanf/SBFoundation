//
//  NSString+SBURLEncode.m
//  Masonry
//
//  Created by 安康 on 2019/9/4.
//

#import "NSString+SBURLEncode.h"


@implementation NSString (SBURLEncode)

- (NSURL *)sb_url {
    
    NSString *urlStr = self;
    
    if (![urlStr hasPrefix:@"http"]) {
        urlStr = [@"http://" stringByAppendingString:urlStr];
    }
    
    return [NSURL URLWithString:[urlStr stringByReplacingOccurrencesOfString:@" "
                                                                  withString:@""]];
}

- (NSString *)sb_urlEncode {
    if ([self isKindOfClass:[NSNull class]]) {
        return @"";
    }
    
    NSString *result =
    (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                          (CFStringRef)self,
                                                                          NULL,
                                                                          CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                          kCFStringEncodingUTF8));
#if !__has_feature(objc_arc)
    [result autorelease];
#endif
    return result;
    
}

- (NSString *)sb_urlDecode {
    NSString *result =(NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding
                                                    (kCFAllocatorDefault,
                                                     (CFStringRef)self,
                                                     CFSTR(""),
                                                     kCFStringEncodingUTF8));
#if !__has_feature(objc_arc)
    [result autorelease];
#endif
    return result;
    
}

- (BOOL)sb_checkEncode {
    if (self.length == 0) {
        return NO;
    }
    
    NSString *newUrl = [self sb_urlDecode];
    if ([newUrl isEqualToString:self]) {
        return NO;
    }else {
        return YES;
    }
}

- (NSString *)sb_urlSafeEncode {
    if (self.length == 0) {
        return self;
    }
    
    BOOL hasEncode = [self sb_checkEncode];
    if (hasEncode) {
        return self;
    }else {
        return [self sb_urlEncode];
    }
}

@end
