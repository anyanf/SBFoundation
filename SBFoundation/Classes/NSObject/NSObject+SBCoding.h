//
//  NSObject+SBCoding.h
//  Masonry
//
//  Created by 安康 on 2019/9/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SBCoding)


- (void)sb_coding_encode:(NSCoder *)aCoder;

- (nullable instancetype)sb_coding_decode:(NSCoder *)aDecoder;

/**
 返回对应targe中的sel返回值
 
 @param target 类名
 @param sel 方法名
 @param firstObj 不定参数
 @return 返回值
 */
+ (id)sb_target:(id)target performSel:(SEL)sel arguments:(id)firstObj,... NS_REQUIRES_NIL_TERMINATION;


@end


#define SBObjectCodingImplmentation \
- (void)encodeWithCoder:(NSCoder *)aCoder { \
[self sb_coding_encode:aCoder];    \
}  \
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder { \
if (self == [super init]){ \
[self sb_coding_decode:aDecoder];\
}\
return  self;\
}\

NS_ASSUME_NONNULL_END
