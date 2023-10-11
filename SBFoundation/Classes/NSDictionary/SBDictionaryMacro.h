//
//  SBDictionaryMacro.h
//  Pods
//
//  Created by 安康 on 2019/9/10.
//

#ifndef SBDictionaryMacro_h
#define SBDictionaryMacro_h

// 是否NSDictionary类型（单独处理NSMutableDictionary）
#define SB_DIC_CLASS_K(dic) [dic isKindOfClass:[NSDictionary class]]
#define SB_MUT_DIC_CLASS_K(mutDic) [mutDic isKindOfClass:[NSMutableDictionary class]]

// 是否有效，不为空，且是NSDictionary类型，且count值大于0（单独处理NSMutableDictionary）
#define SB_DIC_IS_VALID_K(dic) ((dic) && (SB_DIC_CLASS_K(dic)) && ([dic count] > 0))
#define SB_MUT_DIC_IS_VALID_K(mutDic) ((mutDic) && (SB_MUT_DIC_CLASS_K(mutDic)) && ([mutDic count] > 0))

#endif /* SBDictionaryMacro_h */
