//
//  NSBundle+SBExetension.m
//  SBFoundation
//
//  Created by 安康 on 2019/11/21.
//

#import "NSBundle+SBExetension.h"


@implementation NSBundle (SBExetension)

+ (NSBundle *)staticLibBundleWithModuleName:(NSString *)moduleName {
    
    NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:moduleName withExtension:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithURL:bundleURL];
    return bundle;
}

+ (NSBundle *)dynamicLibBundleWithModuleName:(NSString *)moduleName {
    
    NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"Frameworks" withExtension:nil];
    bundleURL = [bundleURL URLByAppendingPathComponent:moduleName];
    bundleURL = [bundleURL URLByAppendingPathExtension:@"framework"];
    bundleURL = [bundleURL URLByAppendingPathComponent:moduleName];
    bundleURL = [bundleURL URLByAppendingPathExtension:@"bundle"];
    
    NSBundle *bundle = [NSBundle bundleWithURL:bundleURL];
    return bundle;
}

@end
