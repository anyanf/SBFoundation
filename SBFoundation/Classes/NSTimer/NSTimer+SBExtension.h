//
//  NSTimer+SBExtension.h
//  Masonry
//
//  Created by 安康 on 2019/9/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (SBExtension)

/**
 定时器弱引用，防止循环引用
 
 @param inTimeInterval 时间间隔
 @param inBlock 事件处理
 @param inRepeats 是否循环
 @return 定时器 NSTimer
 */
+ (id)sb_scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(void))inBlock repeats:(BOOL)inRepeats;

/**
 定时器弱引用，防止循环引用
 
 @param inTimeInterval 时间间隔
 @param inBlock 事件处理
 @param inRepeats 是否循环
 @return 定时器 NSTimer
 */
+ (id)sb_timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(void))inBlock repeats:(BOOL)inRepeats;


@end

NS_ASSUME_NONNULL_END
