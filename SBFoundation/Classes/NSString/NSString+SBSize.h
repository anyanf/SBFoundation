//
//  NSString+SBSize.h
//  Masonry
//
//  Created by 安康 on 2019/9/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (SBSize)

/**
 * 获取字符串需要的size
 *
 * @param  font    字体
 * @param  size    文字最大size
 * @return 实际size
 */
- (CGSize)sb_sizeWithFont:(UIFont *)font size:(CGSize)size;


/**
 * 获取字符串宽度
 *
 * @param  font    字体
 * @return 宽度
 */
- (CGFloat)sb_widthWithFont:(UIFont *)font;


/**
 * 获取字符串高度
 *
 * @param  font    字体
 * @param  width    最大宽度
 * @return 高度
 */
- (CGFloat)sb_heightWithFont:(UIFont *)font width:(CGFloat)width;


/**
 * 获取字符串需要的size
 *
 * @param  font    字体
 * @param  size    文字最大size
 * @param  lineBreakMode    换行模式
 * @return 实际size
 */
- (CGSize)sb_sizeWithFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;


/**
 * 获取字符串需要的size
 *
 * @param  font    字体
 * @param  size    文字最大size
 * @param  lineBreakMode    换行模式
 * @param  lineSpaceInt    行内间距
 * @return 实际size
 */
- (CGSize)sb_sizeWithFont:(UIFont *)font
                     size:(CGSize)size
                     mode:(NSLineBreakMode)lineBreakMode
                lineSpace:(NSInteger)lineSpaceInt;



/**
 * 计算最大行数文字高度,可以处理计算带行间距的
 *
 * @param  size    最大size
 * @param  font    字体
 * @param  lineSpacing    行间距
 * @param  maxLines    最大行数
 * @return 最大行数文字高度
 */
- (CGFloat)sb_boundingRectWithSize:(CGSize)size
                              font:(UIFont*)font
                       lineSpacing:(CGFloat)lineSpacing
                          maxLines:(NSInteger)maxLines;

/**
 * 计算是否超过一行   用于给Label 赋值attribute text的时候 超过一行设置lineSpace
 *
 * @param  size    最大size
 * @param  font    字体
 * @param  lineSpacing    行间距
 * @return 是否超过一行
 */
- (BOOL)sb_isMoreThanOneLineWithSize:(CGSize)size
                                font:(UIFont *)font
                        lineSpaceing:(CGFloat)lineSpacing;


@end

NS_ASSUME_NONNULL_END
