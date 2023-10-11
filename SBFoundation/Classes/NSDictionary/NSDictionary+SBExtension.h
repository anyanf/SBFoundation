//
//  NSDictionary+SBExtension.h
//  Masonry
//
//  Created by 安康 on 2019/9/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (SBExtension)

/**
 返回key所对应的值，确保为NSString类型
 
 @param key 健
 @return 返回key所对应的值，确保为NSString类型
 */
- (NSString *)sb_stringForkey:(NSString *)key;


/**
 返回key所对应的值，确保为NSNumber类型
 
 @param key 健
 @return 返回key所对应的值，确保为NSNumber类型
 */
- (NSNumber *)sb_numberForkey:(NSString *)key;


/**
 返回key所对应的值，确保为BOOL类型
 
 @param key 健
 @return 返回key所对应的值，确保为BOOL类型
 */
- (BOOL)sb_boolForKey:(NSString *)key;


/**
 返回key所对应的值，做非null判断
 
 @param key 健
 @return 返回key所对应的值，做非null判断
 */
- (id)sb_objectForKey:(id)key;


@end

@interface NSMutableDictionary (SBExtension)

/**
 重写setObject:forKey，设置值为nil时，不做任何处理
 
 @param value 值
 @param key 健
 */
- (void)sb_setObject:(id)value forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
