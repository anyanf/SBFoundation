//
//  NSData+SBExtension.h
//  Masonry
//
//  Created by 安康 on 2019/9/5.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

typedef UIImage *_Nonnull(^UIImageFromWebpData)(NSData*);

@interface NSData (SBExtension)




/**
 * 图片压缩
 
 * @param orignalImgData 图片数据
 * @param targetSize 压缩尺寸
 * @param blockPhaseWebp WebpData 回调
 * @return 压缩后的图片数据
 */
+ (NSData *)sb_zipImageWithImage:(NSData *)orignalImgData
                      targetSize:(NSInteger)targetSize
                       phaseWebp:(UIImageFromWebpData) blockPhaseWebp;




/** 将十六进制字符串转化成图片data */ 
+ (NSData *)sb_imageDataWithbyte16Str:(NSString *)byte16Str finish:(void(^)(NSData *data))blockfinish;





@end

NS_ASSUME_NONNULL_END
