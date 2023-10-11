//
//  NSDictionary+SBExtension.m
//  Masonry
//
//  Created by 安康 on 2019/9/5.
//

#import "NSDictionary+SBExtension.h"

#import "SBStringMacro.h"

@implementation NSDictionary (SBExtension)



- (NSString *)sb_stringForkey:(NSString *)key {
    id result = self[key];
    if ([result isKindOfClass:[NSString class]]) {
        return result;
    } else if ([result isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)result stringValue];
    }
    return @"";
}

- (NSNumber *)sb_numberForkey:(NSString *)key {
    id result = self[key];
    if ([result isKindOfClass:[NSString class]]) {
        result = @([(NSString *)result doubleValue]);
    }
    if ([result isKindOfClass:[NSNumber class]]) {
        return result;
    }
    return nil;
}

- (BOOL)sb_boolForKey:(NSString *)key {
    id result = self[key];
    BOOL ret = NO;
    if ([result isKindOfClass:[NSNumber class]]) {
        ret = ![(NSNumber *)result isEqualToNumber:@0];
    } else if ([result isKindOfClass:[NSString class]]) {
        if ([(NSString *)result length] > 1) {
            // Yes yes YES true 都是 true
            ret = [(NSString *)result boolValue];
        } else {
            ret = !([(NSString *)result intValue] == 0);
        }
    }
    
    return ret;
}

- (id)sb_objectForKey:(id)key {
    if ([self sb_isNull:[self objectForKey:key]]) {
        return nil;
    }
    return [self objectForKey:key];
}


- (BOOL)sb_isNull:(id)value {
    if(([NSNull null] == (NSNull *)value) || ([value isKindOfClass:[NSString class]] && [value length] == 0))
    {
        return YES;
    }
    
    return NO;
}



@end


#pragma mark - ********************************* NSMutableDictionary *******************************

@implementation NSMutableDictionary (SBExtension)


// 重写setObject:forKey，设置值为nil时，不做任何处理
- (void)sb_setObject:(id)value forKey:(NSString *)key {
    if (value) {
        [self setObject:value forKey:key];
    } else {
#ifdef DEBUG
        // 测试模式下，不做任何处理，就是让系统Crash，便于跟踪
        [self setObject:value forKey:key];
#else
        // 正式模式下，不做设置处理
#endif
    }
}

@end
