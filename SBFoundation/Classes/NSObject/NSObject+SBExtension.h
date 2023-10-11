//
//  NSObject+SBExtension.h
//  Masonry
//
//  Created by 安康 on 2019/9/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBPropertyModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *propertyType;

@end


@interface NSObject (SBExtension)


/**
 递归循环类及父类
 
 @param enumBlock 回调每一次循环
 */
- (void)sb_enumClass:(void(^)(Class cl, BOOL *stop))enumBlock;


/**
 获取cl中的属性名及属性类型
 
 @param clazz 类名
 @param finish 属性名称及类型model回调
 */
- (void)sb_propertyForClass:(Class)clazz finish:(void(^)(SBPropertyModel *pModel))finish;


@end

NS_ASSUME_NONNULL_END
