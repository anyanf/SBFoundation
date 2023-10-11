//
//  NSNotificationCenter+SBExtension.h
//  Masonry
//
//  Created by 安康 on 2019/9/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 尽量在一个线程中处理通知相关的操作
// 在多线程应用中，Notification在哪个线程中post，就在哪个线程中被转发，而不一定是在注册观察者的那个线程中
// 所以响应Notification中如果有更改UI的操作，必须保证post 在主线程。可以调用NSNotificationCenter+SBExtension中方法。

@interface NSNotificationCenter (SBExtension)

/**
 Posts a given notification to the receiver on main thread.
 If current thread is main thread, the notification is posted synchronously;
 otherwise, is posted asynchronously.
 
 @param notification  The notification to post.
 An exception is raised if notification is nil.
 */
- (void)sb_postNotificationOnMainThread:(NSNotification *)notification;

/**
 Posts a given notification to the receiver on main thread.
 
 @param notification The notification to post.
 An exception is raised if notification is nil.
 
 @param wait         A Boolean that specifies whether the current thread blocks
 until after the specified notification is posted on the
 receiver on the main thread. Specify YES to block this
 thread; otherwise, specify NO to have this method return
 immediately.
 */
- (void)sb_postNotificationOnMainThread:(NSNotification *)notification
                         waitUntileDone:(BOOL)wait;

/**
 Creates a notification with a given name and sender and posts it to the
 receiver on main thread. If current thread is main thread, the notification
 is posted synchronously; otherwise, is posted asynchronously.
 
 @param name    The name of the notification.
 
 @param object  The object posting the notification.
 */
- (void)sb_postNotificationOnMainThreadWithName:(NSString *)name
                                         object:(id)object;

/**
 Creates a notification with a given name and sender and posts it to the
 receiver on main thread. If current thread is main thread, the notification
 is posted synchronously; otherwise, is posted asynchronously.
 
 @param name      The name of the notification.
 
 @param object    The object posting the notification.
 
 @param userInfo  Information about the the notification. May be nil.
 */
- (void)sb_postNotificationOnMainThreadWithName:(NSString *)name
                                         object:(id)object
                                       userInfo:(NSDictionary *)userInfo;

/**
 Creates a notification with a given name and sender and posts it to the
 receiver on main thread.
 
 @param name     The name of the notification.
 
 @param object   The object posting the notification.
 
 @param userInfo Information about the the notification. May be nil.
 
 @param wait     A Boolean that specifies whether the current thread blocks
 until after the specified notification is posted on the
 receiver on the main thread. Specify YES to block this
 thread; otherwise, specify NO to have this method return
 immediately.
 */
- (void)sb_postNotificationOnMainThreadWithName:(NSString *)name
                                         object:(id)object
                                       userInfo:(NSDictionary *)userInfo
                                 waitUntileDone:(BOOL)wait;


@end

NS_ASSUME_NONNULL_END
