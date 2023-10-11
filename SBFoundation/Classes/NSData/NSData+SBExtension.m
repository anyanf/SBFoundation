//
//  NSData+SBExtension.m
//  Masonry
//
//  Created by 安康 on 2019/9/5.
//

#import "NSData+SBExtension.h"

#import "SBStringMacro.h"

@implementation NSData (SBExtension)


// 识别图片类型
- (NSString *)sb_contentTypeForImageData {
    uint8_t c;
    [self getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
        case 0x52:
            // R as RIFF for WEBP
            if ([self length] < 12) {
                return nil;
            }
            
            NSString *testString = [[NSString alloc] initWithData:[self subdataWithRange:NSMakeRange(0, 12)]
                                                         encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"image/webp";
            }
            
            return nil;
    }
    return nil;
}


// 压图片质量
+ (NSData *)sb_zipImageWithImage:(NSData *)orignalImgData
                      targetSize:(NSInteger)targetSize
                       phaseWebp:(UIImageFromWebpData) blockPhaseWebp {
    if (!orignalImgData) {
        return nil;
    }
    
    CGFloat maxFileSize = targetSize;
    CGFloat compression = 0.8f;
    
    UIImage *image;
    NSString *imageContentType = [orignalImgData sb_contentTypeForImageData];
    if ([imageContentType isEqualToString:@"image/webp"]) {
        if (blockPhaseWebp) {
            image = blockPhaseWebp(orignalImgData);
        }
    } else {
        image = [UIImage imageWithData:orignalImgData];
    }
    NSData *compressedData = UIImageJPEGRepresentation(image,
                                                       compression);
    while ([compressedData length] > maxFileSize) {
        compression *= 0.8;
        compressedData = UIImageJPEGRepresentation([[self class] sb_compressImage:image
                                                                         newWidth:image.size.width*compression],
                                                   compression);
    }
    return compressedData;
}


/**
 *  等比缩放本图片大小
 *
 *  @param newImageWidth 缩放后图片宽度，像素为单位
 *
 *  @return self-->(image)
 */
+ (UIImage *)sb_compressImage:(UIImage *)image newWidth:(CGFloat)newImageWidth {
    if (!image) return nil;
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    float width = newImageWidth;
    float height = image.size.height/(image.size.width/width);
    
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    if (widthScale > heightScale) {
        [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }
    else {
        [image drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
}


// 将十六进制字符串转化成图片data
+ (NSData *)sb_imageDataWithbyte16Str:(NSString *)byte16Str finish:(void(^)(NSData *data))blockfinish {
    void (^block)(NSData *) = blockfinish;
    
    if (block) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSData *data = [self sb_imageDataWithbyte16Str:byte16Str];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (block) {
                    block(data);
                }
            });
        });
    } else {
        NSData *data = [self sb_imageDataWithbyte16Str:byte16Str];
        return data;
    }
    
    return nil;
}


+ (NSData *)sb_imageDataWithbyte16Str:(NSString *)byte16Str {
    NSString *hexString = byte16Str; //16进制字符串
    
    // bytes索引
    int j = 0;
    
    NSInteger len = [hexString length];
    
    // 动态分配内存
    Byte *bytes = (Byte *)malloc(len*sizeof(Byte) + 1);
    // 初始化内存
    memset(bytes,'\0',len*sizeof(Byte) + 1);
    
    // 如果字符串不满足图片流,返回nil
    if ([hexString length] % 2 == 1) {
        return nil;
    }
    
    for(int i = 0;i < [hexString length]; i++) {
        NSString *str = [hexString substringWithRange:NSMakeRange(i, 2)];
        
        /// 将16进制字符串转化成十进制
        unsigned long int_ch  = strtoul([str UTF8String], 0, 16);
        bytes[j] = int_ch;
        
        i++;
        j++;
    }
    
    NSData *newData = [[NSData alloc] initWithBytes:bytes length:hexString.length/2];
    /// 释放内存
    free(bytes);
    
    return newData;
}

@end
