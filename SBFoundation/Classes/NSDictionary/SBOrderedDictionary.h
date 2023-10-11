//
//  SBOrderedDictionary.h
//  SBFoundation
//
//  Created by 安康 on 2019/10/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/** 有序字典 */
@interface SBOrderedDictionary<KeyType, ObjectType> : NSObject<NSCopying>


/** 添加键值对 */
- (void)setObject:(nonnull id)anObject forKey:(nonnull id<NSCopying>)aKey;

/** 通过key获取值 */
- (id)objectForKey:(nonnull id<NSCopying>)aKey;

/** 移除给定key键值对 */
- (void)removeObjectForKey:(id)aKey;

/** 移除全部键值对 */
- (void)removeAllObjects;

/** 移除给定的keyArray键值对 */
- (void)removeObjectsForKeys:(NSArray<id> *)keyArray;

/** 获取给定index的对象 */
- (id)objectAtIndex:(NSUInteger)index;


/** 移除最后一个键值对 */
- (void)removeLastObject;

/** 移除给定index的键值对 */
- (void)removeObjectAtIndex:(NSUInteger)index;

/** 替换给定index的值 */
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

/** 移除给定indexes的键值对 */
- (void)removeObjectsAtIndexes:(NSIndexSet *)indexes;

/** 替换给定indexes的值 */
- (void)replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray<id> *)objects;

/** 返回所有的key */
- (NSArray *)allKeys;

/** 返回迭代器 */
- (NSEnumerator *)keyEnumerator;



@end

NS_ASSUME_NONNULL_END
