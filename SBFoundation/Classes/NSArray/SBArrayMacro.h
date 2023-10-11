//
//  SBArrayMacro.h
//  Pods
//
//  Created by 安康 on 2019/9/10.
//

#ifndef SBArrayMacro_h
#define SBArrayMacro_h

// 是否NSArray类型（单独处理NSMutableArray）
#define SB_ARY_CLASS_K(ary) [ary isKindOfClass:[NSArray class]]
#define SB_MUT_ARY_CLASS_K(mutAry) [mutAry isKindOfClass:[NSMutableString class]])

// 是否有效，不为空，且是NSArray类型，且count值大于0（单独处理NSMutableArray）
#define SB_ARY_IS_VALID_K(ary) ((ary) && (SB_ARY_CLASS_K(ary)) && ([ary count] > 0))
#define SB_MUT_ARY_IS_VALID_K(mutAry) ((mutAry) && (SB_ARY_CLASS_K(mutAry)) && ([mutAry count] > 0))


#endif /* SBArrayMacro_h */
