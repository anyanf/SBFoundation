//
//  NSNotificationCenter+SBExtension.m
//  Masonry
//
//  Created by 安康 on 2019/9/6.
//

#import "NSNotificationCenter+SBExtension.h"

#import <pthread.h>


@implementation NSNotificationCenter (SBExtension)

- (void)sb_postNotificationOnMainThread:(NSNotification *)notification {
    if(pthread_main_np())
        return[self postNotification:notification];
    [self sb_postNotificationOnMainThread:notification waitUntileDone:NO];
}

- (void)sb_postNotificationOnMainThread:(NSNotification *)notification
                        waitUntileDone:(BOOL)wait {
    if(pthread_main_np())
        return [self postNotification:notification];
    [self performSelectorOnMainThread:@selector(sb_postNotification:) withObject:notification waitUntilDone:wait];
}

- (void)sb_postNotificationOnMainThreadWithName:(NSString *)name
                                        object:(id)object {
    if(pthread_main_np())
        return [self postNotificationName:name
                                   object:object];
    [self sb_postNotificationOnMainThreadWithName:name object:object userInfo:@{} waitUntileDone:NO];
}

- (void)sb_postNotificationOnMainThreadWithName:(NSString *)name
                                        object:(id)object
                                      userInfo:(NSDictionary *)userInfo {
    if(pthread_main_np())
        return [self postNotificationName:name object:object userInfo:userInfo];
    [self sb_postNotificationOnMainThreadWithName:name object:object userInfo:userInfo waitUntileDone:NO];
}

- (void)sb_postNotificationOnMainThreadWithName:(NSString *)name
                                        object:(id)object
                                      userInfo:(NSDictionary *)userInfo
                                waitUntileDone:(BOOL)wait {
    if(pthread_main_np())
        return [self postNotificationName:name object:object userInfo:userInfo];
    NSMutableDictionary *info =[[NSMutableDictionary allocWithZone:nil] initWithCapacity:3];
    if(name) {
        [info setObject:name forKey:@"name"];
    }
    if(object) {
        [info setObject:object forKey:@"object"];
    }
    if(userInfo) {
        [info setObject:userInfo forKey:@"userInfo"];
    }
    
    [self performSelectorOnMainThread:@selector(sb_postNotificationName:) withObject:info waitUntilDone:wait];
    
}

- (void)sb_postNotification:(NSNotification *)notification {
    [self postNotification:notification];
}

- (void)sb_postNotificationName:(NSDictionary *)info {
    NSString *name =[info objectForKey:@"name"];
    id object =[info objectForKey:@"object"];
    NSDictionary *dict =[info objectForKey:@"userInfo"];
    [self postNotificationName:name object:object userInfo:dict];
}

@end
