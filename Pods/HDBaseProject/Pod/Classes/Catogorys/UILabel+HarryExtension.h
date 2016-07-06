//
//  UILabel+HarryExtension.h
//  HDBaseProject
//
//  Created by Harry on 15/10/22.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (HarryExtension)

- (void)harry_adjustFontWithMaxSize:(CGSize)maxSize;
- (void)harry_adjustFrameWithMaxWidth:(CGFloat)maxWidth numberOfLines:(NSInteger)lines;
- (CGSize)harry_contentSizeForWidth:(CGFloat)width;
- (CGSize)harry_contentSize;

/**
 *  设置label中文字和文字之间的间隔空间
 *
 *  @param columnSpace 间隔值
 */
- (void)harry_setColumnSpace:(CGFloat)columnSpace;
/**
 *  设置label的文字的行间距
 *
 *  @param rowSpace 行间距的值
 */
- (void)harry_setRowSpace:(CGFloat)rowSpace;

@end
