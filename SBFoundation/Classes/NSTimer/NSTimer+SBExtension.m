//
//  NSTimer+SBExtension.m
//  Masonry
//
//  Created by 安康 on 2019/9/6.
//

#import "NSTimer+SBExtension.h"

@implementation NSTimer (SBExtension)


+ (id)sb_scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(void))inBlock repeats:(BOOL)inRepeats {
    void (^block)(void) = [inBlock copy];
    id ret = [self scheduledTimerWithTimeInterval:inTimeInterval target:self selector:@selector(sb_executeSimpleBlock:) userInfo:block repeats:inRepeats];
    return ret;
}

+ (id)sb_timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(void))inBlock repeats:(BOOL)inRepeats {
    void (^block)(void) = [inBlock copy];
    id ret = [self timerWithTimeInterval:inTimeInterval target:self selector:@selector(sb_executeSimpleBlock:) userInfo:block repeats:inRepeats];
    return ret;
}

+ (void)sb_executeSimpleBlock:(NSTimer *)timer {
    void (^block)(void) = timer.userInfo;
    if(block)
    {
        block();
    }
}


@end
