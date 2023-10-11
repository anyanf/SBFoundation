//
//  NSBundle+SBExetension.h
//  SBFoundation
//
//  Created by 安康 on 2019/11/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (SBExetension)

/** 静态库bundle */
+ (NSBundle *)staticLibBundleWithModuleName:(NSString *)moduleName;

/** 动态库bundle */
+ (NSBundle *)dynamicLibBundleWithModuleName:(NSString *)moduleName;
@end

NS_ASSUME_NONNULL_END
