//
//  UIImage+Crop.m
//  TestMFT
//
//  Created by EDAN on 15/8/19.
//  Copyright (c) 2015年 EDAN. All rights reserved.
//

#import "UIImage+Crop.h"

@implementation UIImage (Crop)
+ (UIImage*) circleImage:(UIImage*) image borderWidth:(CGFloat) borderWidth borderColor:(UIColor*) borderColor{
    
    if (!image) {
        
        return nil;
    }
    
    CGFloat width = CGImageGetWidth(image.CGImage);
    CGFloat height = CGImageGetHeight(image.CGImage);
    CGFloat radius = MIN(width, height) / 2 + borderWidth;
    CGRect rect = CGRectMake(0, 0, radius * 2, radius * 2);
    CGRect drawRect = CGRectInset(rect, borderWidth, borderWidth);
    CGPoint drawPoint = CGPointMake(radius - width / 2, radius - height / 2);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetShouldAntialias(context, YES);
    
    CGContextSaveGState(context);
    CGContextAddEllipseInRect(context, drawRect);
    CGContextClip(context);
    [image drawAtPoint:drawPoint];
    CGContextRestoreGState(context);
    
    CGContextSetLineWidth(context, borderWidth);
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    CGContextAddEllipseInRect(context, CGRectInset(rect, borderWidth/2, borderWidth/2));
    CGContextStrokePath(context);

    UIImage* circleimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return circleimage;
}
@end
