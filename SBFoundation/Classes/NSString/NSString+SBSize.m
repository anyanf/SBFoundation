//
//  NSString+SBSize.m
//  Masonry
//
//  Created by 安康 on 2019/9/5.
//

#import "NSString+SBSize.h"

@implementation NSString (SBSize)


// 获取字符串需要的size
- (CGSize)sb_sizeWithFont:(UIFont *)font size:(CGSize)size {
    CGSize result = [self sb_sizeWithFont:font size:size mode:NSLineBreakByWordWrapping];
    return  result;
}


// 获取字符串宽度
- (CGFloat)sb_widthWithFont:(UIFont *)font {
    CGSize size =[self sb_sizeWithFont:font size:CGSizeMake(MAXFLOAT, MAXFLOAT) mode:NSLineBreakByWordWrapping];
    return size.width;
}


// 获取字符串高度
- (CGFloat)sb_heightWithFont:(UIFont *)font width:(CGFloat)width {
    CGSize size =[self sb_sizeWithFont:font size:CGSizeMake(width, MAXFLOAT) mode:NSLineBreakByWordWrapping];
    return size.height;
}


// 获取字符串需要的size,有 lineBreakMode
- (CGSize)sb_sizeWithFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result = [self sb_sizeWithFont:font size:size mode:lineBreakMode lineSpace:0];
    return  result;
}


// 获取字符串需要的size,有 lineBreakMode 行间距
- (CGSize)sb_sizeWithFont:(UIFont *)font
                     size:(CGSize)size
                     mode:(NSLineBreakMode)lineBreakMode
                lineSpace:(NSInteger)lineSpaceInt {
    CGSize result = CGSizeZero;
    
    // 默认14号
    if(!font) {
        font =[UIFont systemFontOfSize:14];
    }
    
    NSMutableDictionary *attr =[NSMutableDictionary new];
    attr[NSFontAttributeName] =font;
    
    if(lineBreakMode != NSLineBreakByWordWrapping || lineSpaceInt > 0) {
        
        NSMutableParagraphStyle *paragraphStyle =[NSMutableParagraphStyle new];
        paragraphStyle.lineBreakMode =lineBreakMode;
        
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            paragraphStyle.lineBreakMode =lineBreakMode;
        }
        
        if (lineSpaceInt > 0) {
            paragraphStyle.lineSpacing = lineSpaceInt;
        }
        
        attr[NSParagraphStyleAttributeName] = paragraphStyle;
    }
    CGRect rect =[self boundingRectWithSize:size
                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                 attributes:attr
                                    context:nil];
    result =rect.size;
    return result;
}


// 计算最大行数文字高度,可以处理计算带行间距的
- (CGFloat)sb_boundingRectWithSize:(CGSize)size
                           font:(UIFont*)font
                    lineSpacing:(CGFloat)lineSpacing
                       maxLines:(NSInteger)maxLines {
    if (maxLines <= 0) {
        return 0;
    }
    
    CGFloat maxHeight = font.lineHeight * maxLines + lineSpacing * (maxLines - 1);
    
    CGSize orginalSize = [self sb_sizeWithFont:font
                                          size:size
                                          mode:NSLineBreakByWordWrapping
                                     lineSpace:lineSpacing];
    
    if (orginalSize.height >= maxHeight) {
        return maxHeight;
    } else {
        return orginalSize.height;
    }
}


// 计算是否超过一行   用于给Label 赋值attribute text的时候 超过一行设置lineSpace
- (BOOL)sb_isMoreThanOneLineWithSize:(CGSize)size
                                font:(UIFont *)font
                        lineSpaceing:(CGFloat)lineSpacing {
    if ([self sb_sizeWithFont:font
                         size:size
                         mode:NSLineBreakByWordWrapping
                    lineSpace:lineSpacing].height > font.lineHeight) {
        return YES;
    } else {
        return NO;
    }
}


@end
