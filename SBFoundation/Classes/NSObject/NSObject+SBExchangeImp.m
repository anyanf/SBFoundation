//
//  NSObject+SBExchangeImp.m
//  SBFoundation
//
//  Created by 安康 on 2019/10/22.
//

#import "NSObject+SBExchangeImp.h"

#import <objc/runtime.h>

@implementation NSObject (SBExchangeImp)


+ (void)swizzlingClassMethod:(SEL)origSel withMethod:(SEL)customSel {
    
    Class cls = [self class];
    
    Method originalMethod = class_getClassMethod(cls, origSel);
    Method customMethod = class_getClassMethod(cls, customSel);
    
    Class metacls = objc_getMetaClass(NSStringFromClass(cls).UTF8String);
    if (class_addMethod(metacls,
                        origSel,
                        method_getImplementation(customMethod),
                        method_getTypeEncoding(customMethod)) ) {
        class_replaceMethod(metacls,
                            customSel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
        
    } else {
        method_exchangeImplementations(originalMethod, customMethod);
    }
}

+ (void)swizzlingObjectMethod:(SEL)origSel withMethod:(SEL)customSel withClassString:(NSString *)classString {
    Class cls = NSClassFromString(classString);
    Method originalMethod = class_getInstanceMethod(cls, origSel);
    Method customMethod = class_getInstanceMethod(cls, customSel);
    if (class_addMethod(cls,
                        origSel,
                        method_getImplementation(customMethod),
                        method_getTypeEncoding(customMethod)) ) {
        class_replaceMethod(cls,
                            customSel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
        
    } else {
        class_replaceMethod(cls,
                            customSel,
                            class_replaceMethod(cls,
                                                origSel,
                                                method_getImplementation(customMethod),
                                                method_getTypeEncoding(customMethod)),
                            method_getTypeEncoding(originalMethod));
    }
}

@end
