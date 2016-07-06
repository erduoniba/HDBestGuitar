//
//  UIImage_UIImage_Add.h
//  Fangpaipai
//
//  Created by lzg on 13-11-20.
//  Copyright (c) 2013年 lzg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Add)

- (UIImage *)scaleAndRotateImage:(UIImage *)image;

//image变圆形
- (UIImage *)circleImage:(UIImage*)image withParam:(CGFloat)inset;

+ (UIImage*)cropImage:(UIImage*)originalImage toRect:(CGRect)rect;

- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

- (UIImage *)TransformtoSize:(CGSize)Newsize;


@end
