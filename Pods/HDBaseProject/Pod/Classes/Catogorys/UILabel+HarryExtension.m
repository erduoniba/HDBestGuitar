//
//  UILabel+HarryExtension.m
//  HDBaseProject
//
//  Created by Harry on 15/10/22.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "UILabel+HarryExtension.h"
#import <CoreText/CoreText.h>
@implementation UILabel (HarryExtension)


- (void)harry_adjustFrameWithMaxWidth:(CGFloat)maxWidth numberOfLines:(NSInteger)lines
{
    if (lines == 0) {
        lines = 1;
    }
    if (maxWidth == 0) {
        maxWidth = self.frame.size.width;
    }
    CGFloat height = self.font.pointSize * lines;
    CGSize maxsize = CGSizeMake(maxWidth, height);
    [self harry_adjustFontWithMaxSize:maxsize];
    
}
- (void)harry_adjustFontWithMaxSize:(CGSize)maxSize {
    CGRect stringRect;
    NSDictionary *attri = @{NSFontAttributeName:self.font};
    if (CGSizeEqualToSize(maxSize, CGSizeZero)) {
        
        if (!self.attributedText || self.attributedText.length == 0) {
            stringRect = [self.text boundingRectWithSize:self.frame.size options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin) attributes:attri context:nil];
        }
        else {
            stringRect = [self.attributedText boundingRectWithSize:self.frame.size options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin) context:nil];
        }
        
    } else {
        if (!self.attributedText || self.attributedText.length == 0) {
            stringRect = [self.text boundingRectWithSize:maxSize options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin) attributes:attri context:nil];
        }
        else {
            
            if ([[[UIDevice currentDevice] systemVersion] floatValue] > 9.0) {
                stringRect = [self.attributedText boundingRectWithSize:maxSize options:(NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin) context:nil];
            }
            else{
                NSRange range = NSMakeRange(0, self.attributedText.length);
                NSDictionary *dic = [self.attributedText attributesAtIndex:0 effectiveRange:&range];
                stringRect = [self.attributedText.string boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine attributes:dic context:nil];
            }
        }
        
        
    }
    CGRect frame = self.frame;
    if (self.font.pointSize == maxSize.height) {
        //一行的时候,计算出来的高度总是比字体的pointsize大,比如字体是16的,单行计算出来是19.09
        frame.size.height = self.font.pointSize;
    }
    else {
        frame.size.height = ceilf(stringRect.size.height);
    }
    frame.size.width = ceilf(stringRect.size.width);
    self.frame = frame;
    
    //NSInteger lines = (int)stringRect.size.height / self.font.xHeight;
    //self.numberOfLines = lines;
}

- (CGSize)harry_contentSizeForWidth:(CGFloat)width
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    paragraphStyle.alignment = self.textAlignment;
    
    CGRect contentFrame = [self.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{ NSFontAttributeName : self.font ,NSParagraphStyleAttributeName : paragraphStyle} context:nil];
    return contentFrame.size;
}

- (CGSize)harry_contentSize
{
    return [self harry_contentSizeForWidth:CGRectGetWidth(self.bounds)];
}

+ (instancetype)harry_createLbWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font color:(UIColor *)color{
    UILabel *lb = [[UILabel alloc] initWithFrame:frame];
    lb.text = text;
    lb.font = font;
    lb.textColor = color;
    return lb;
}


- (void)harry_setColumnSpace:(CGFloat)columnSpace
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    //调整间距
    [attributedString addAttribute:(__bridge NSString *)kCTKernAttributeName value:@(columnSpace) range:NSMakeRange(0, [attributedString length])];
    self.attributedText = attributedString;
}

- (void)harry_setRowSpace:(CGFloat)rowSpace
{
    self.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    //调整行距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = rowSpace;
    //[paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
    //paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
}

@end
