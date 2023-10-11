//
//  NSObject+SBExchangeImp.h
//  SBFoundation
//
//  Created by 安康 on 2019/10/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SBExchangeImp)

+ (void)swizzlingClassMethod:(SEL)origSel withMethod:(SEL)customSel;
+ (void)swizzlingObjectMethod:(SEL)origSel withMethod:(SEL)customSel withClassString:(NSString *)classString;

@end

NS_ASSUME_NONNULL_END
