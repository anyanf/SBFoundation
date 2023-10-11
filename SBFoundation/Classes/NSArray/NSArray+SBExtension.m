//
//  NSArray+SBExetension.m
//  Masonry
//
//  Created by 安康 on 2019/9/5.
//

#import "NSArray+SBExtension.h"

@implementation NSArray (SBExtension)


#pragma mark 防止数组越界

- (id)sb_objectAtIndex:(NSUInteger)index {
#ifdef DEBUG
    // 测试模式下，不做任何处理，就是让系统Crash，便于提前发现问题
#else
    // 正式模式下，数组加入保护
    if (index >= self.count) {
        return nil;
    }
#endif
    
    return [self objectAtIndex:index];
}

#pragma mark 数组处理

- (BOOL)sb_some:(BOOL (^)(id element))condition {
    __block BOOL iss = NO;
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
        if (condition) iss = condition(obj);
        if (iss) *stop = YES;
    }];
    return iss;
}

- (BOOL)sb_every:(BOOL (^)(id element))condition {
    __block BOOL ise = NO;
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
        if (condition) ise = condition(obj);
        if (!ise) *stop = YES;
    }];
    return ise;
}

- (instancetype)sb_map:(id (^)(id element))condition {
    NSMutableArray *marr = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
        if (condition) {
            id newObj = condition(obj);
            if (newObj) [marr addObject:newObj];
        }
    }];
    return marr;
}

- (instancetype)sb_filter:(BOOL (^)(id element))condition {
    NSMutableArray *marr = [NSMutableArray arrayWithCapacity:self.count];

    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
        if (condition && condition(obj)) {
            [marr addObject:obj];
        }
    }];
    return marr;
}

- (id)sb_reduce:(id (^)(id reduceObj, id element))condition initial:(id)initialObj {
    __block id initO = initialObj;
    NSAssert(initialObj, @"reduce: initialObj参数不能为空");
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
        if (condition) {
            initO = condition(initO, obj);
        }
    }];
    
    return initO;
}

@end


@implementation NSMutableArray (SBExetension)

- (void)sb_addObject:(id)anObject {
#ifdef DEBUG
    // 测试模式下，不做任何处理，就是让系统Crash，便于提前发现问题
    [self addObject:anObject];

#else
    // 正式模式下，数组加入保护
    if (anObject) {
        [self addObject:anObject];
    }
#endif
}

- (void)sb_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
#ifdef DEBUG
    /// 测试模式下，不做任何处理，就是让系统Crash，便于提前发现问题
    [self replaceObjectAtIndex:index withObject:anObject];
#else
    /// 正式模式下，数组加入保护
    if (index < self.count) {
        [self replaceObjectAtIndex:index withObject:anObject];
    }
#endif
}


- (void)sb_removeObjectAtIndex:(NSUInteger)objectIndex {
#ifdef DEBUG
    // 测试模式下，不做任何处理，就是让系统Crash，便于提前发现问题
    [self removeObjectAtIndex:objectIndex];
#else
    // 正式模式下，数组加入保护
    if (objectIndex < self.count) {
        [self removeObjectAtIndex:objectIndex];
    }
#endif
}

- (void)sb_removeObjectsInRange:(NSRange)range {
#ifdef DEBUG
    // 测试模式下，不做任何处理，就是让系统Crash，便于提前发现问题
    [self removeObjectsInRange:range];
#else
    // 正式模式下，数组加入保护
    if (range.location + range.length < self.count) {
        [self removeObjectsInRange:range];
    }
#endif
}

- (void)sb_moveObjectFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (toIndex != fromIndex && fromIndex < [self count] && toIndex < [self count]) {
        id obj = [self objectAtIndex:fromIndex];
        [self removeObjectAtIndex:fromIndex];
        
        if (toIndex >= [self count]) {
            [self addObject:obj];
        } else {
            [self insertObject:obj atIndex:toIndex];
        }
    }
}


@end
