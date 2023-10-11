//
//  NSArray+SBExetension.h
//  Masonry
//
//  Created by 安康 on 2019/9/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (SBExtension)

/**
 *  @brief 数组越界保护，只在release环境下有效
 *
 *  @param index 数组索引
 *
 *  @return 查找数组中的元素
 */
- (id)sb_objectAtIndex:(NSUInteger)index;


#pragma mark 数组处理

/*!
 *  @brief 查找数组中是否有满足条件的元素
 *  如：[@[@1, @2, @3] some:^BOOL(NSNumber *ele) {
 *          return ele.intValue > 2;
 *      }] => yes
 *
 *  @param condition 过滤条件的回调 block，block 内实现判断条件，数组中有一个满足条件，即返回 yes
 *
 *  @return 结果 Bool
 */
- (BOOL)sb_some:(BOOL (^)(id element))condition;


/*!
 *  @brief 与 some 类似，判断数组中的所有元素是不是满足条件
 *
 *  @param condition 过滤条件的回调 block，block 内实现判断条件，数组中所有元素满足条件，即返回 yes
 *
 *  @return 结果 Bool
 */
- (BOOL)sb_every:(BOOL (^)(id element))condition;


/*!
 *  @brief 根据回调中的逻辑，返回一个新的数组
 *  如：[@[@1, @2, @3] map:^id(NSNumber *ele) {
 *          return [NSString stringWithFormat@"%@", ele];
 *      }] => @[@"1", @"2", @"3"]
 *
 *  @param condition 回调中可以对数组中的每个元素做操作，产生一个新的对象
 *
 *  @return 结果 数组
 */
- (instancetype)sb_map:(id (^)(id element))condition;


/*!
 *  @brief 对数组中的对象进行过滤，并返回一个数组
 *         如果原数组是可变的，返回原数组，内容更新；
 *         如果原数组是不可变，返回一个新的数组
 *  如：[@[@1, @2, @3] filter:^BOOL(NSNumber *ele) {
 *          return ele.intValue != 2;
 *      }] => @[@"1", @"3"]
 *
 *  @param condition 过滤条件
 *
 *  @return 结果 数组
 */
- (instancetype)sb_filter:(BOOL (^)(id element))condition;


/*!
 *  @brief 根据数组中的元素创建一个对象，类似于聚合效果
 *  如：NSNumber *initO = @4;
 *     [@[@1, @2, @3] filter:^id(NSNumber *reduceObj, NSNumber *ele) {
 *         return @(reduceObj.intValue + ele.intValue);
 *     } initial:initO] => @10
 *
 *  @param condition 对每个元素所做的操作，回调中返回聚合对象和数组中的元素
 *  @param initialObj 返回对象的初始值
 *
 *  @return 结果 对象
 */
- (id)sb_reduce:(id (^)(id reduceObj, id element))condition initial:(id)initialObj;

@end



@interface NSMutableArray (SBExetension)

- (void)sb_addObject:(id)anObject;

/**
 *  @brief 数组越界保护，只在release环境下有效 替换对应index下对象
 
 @param index 对象索引
 @param anObject 新对象
 */
- (void)sb_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;


/**
 *  @brief 数组越界保护，只在release环境下有效 删除对应index下的对象
 
 @param objectIndex 对象索引
 */
- (void)sb_removeObjectAtIndex:(NSUInteger)objectIndex;


/**
 *  @brief 数组越界保护，只在release环境下有效 删除对应range下的对象
 
 @param range 移除范围
 */
- (void)sb_removeObjectsInRange:(NSRange)range;


/**
 交换对象位置
 
 @param fromIndex 原始位置
 @param toIndex 新位置
 */
- (void)sb_moveObjectFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

@end

NS_ASSUME_NONNULL_END
