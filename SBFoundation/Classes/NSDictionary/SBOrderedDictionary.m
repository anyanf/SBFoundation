//
//  SBOrderedDictionary.m
//  SBFoundation
//
//  Created by 安康 on 2019/10/22.
//

#import "SBOrderedDictionary.h"


@interface SBOrderedDictionary ()

@property (nonatomic, strong) NSMutableDictionary *dic;

@property (nonatomic, strong) NSMutableArray *keysMutAry;


@end

@implementation SBOrderedDictionary

- (NSMutableDictionary *)dic {
    if (!_dic) {
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}

- (NSMutableArray *)keysMutAry {
    if (!_keysMutAry) {
        _keysMutAry = [NSMutableArray array];
    }
    return _keysMutAry;
}


// 添加键值对
- (void)setObject:(nonnull id)anObject forKey:(nonnull id<NSCopying>)aKey {

    if (!aKey) {
        return;
    }
    
    if (self.keysMutAry.count == self.allKeys.count) {
        [self.keysMutAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqual:aKey]) {
                [self.keysMutAry removeObjectAtIndex:idx];
                *stop = YES;
            }
        }];
        [self.keysMutAry addObject:aKey];
    }
    [self.dic setObject:anObject forKey:aKey];
}

- (id)objectForKey:(nonnull id<NSCopying>)aKey {
    return [self.dic objectForKey:aKey];
}

// 移除给定key键值对
- (void)removeObjectForKey:(id)aKey {
    [self.keysMutAry removeObject:aKey];
    [self.dic removeObjectForKey:aKey];
}

// 移除全部键值对
- (void)removeAllObjects {
    [self.keysMutAry removeAllObjects];
    [self.dic removeAllObjects];
}

// 移除给定的keyArray键值对
- (void)removeObjectsForKeys:(NSArray<id> *)keyArray {
    for (id obj in [keyArray mutableCopy]) {
        [self.keysMutAry removeObject:obj];
    }
    [self.dic removeObjectsForKeys:keyArray];
}

// 获取给定index的对象
- (id)objectAtIndex:(NSUInteger)index {
    if (index >= self.keysMutAry.count) {
        return nil;
    }
    return [self.dic objectForKey:self.keysMutAry[index]];
}

// 移除最后一个键值对
- (void)removeLastObject {
    [self removeObjectAtIndex:self.keysMutAry.count - 1];
}

// 移除给定index的键值对
- (void)removeObjectAtIndex:(NSUInteger)index {
    if (index < self.keysMutAry.count) {
        [self removeObjectForKey:self.keysMutAry[index]];
    }
}

// 替换给定index的值
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (index < self.keysMutAry.count) {
        [self.dic setObject:anObject forKey:self.keysMutAry[index]];
    }
}

// 移除给定indexes的键值对
- (void)removeObjectsAtIndexes:(NSIndexSet *)indexes {
    
    NSMutableArray *keysMutAry = [NSMutableArray array];
    
    [indexes enumerateIndexesWithOptions:NSEnumerationReverse usingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < self.keysMutAry.count) {
            [keysMutAry addObject:self.keysMutAry[idx]];
        }
    }];
    [self.keysMutAry removeObjectsAtIndexes:indexes];
    [self removeObjectsForKeys:keysMutAry];
}

// 替换给定indexes的值
- (void)replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray<id> *)objects {
    __block NSUInteger index = 0;
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        [self replaceObjectAtIndex:idx withObject:objects[index]];
        index ++;
    }];
}


- (NSArray *)allKeys {
    return self.keysMutAry.copy;
}


- (NSEnumerator *)keyEnumerator {
    return [self.keysMutAry objectEnumerator];
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    return self;
}

@end
