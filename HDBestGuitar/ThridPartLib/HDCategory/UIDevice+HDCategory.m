//
//  UIDevice+HDCategory.m
//  HDBestGuitar
//
//  Created by 邓立兵 on 16/7/6.
//  Copyright © 2016年 HarryDeng. All rights reserved.
//

#import "UIDevice+HDCategory.h"

@implementation UIDevice (HDCategory)

- (HDDeviceType)currentDeviceType{
    CGSize size = [UIScreen mainScreen].bounds.size;
    if ([self isTheSameSize:size betweenSize:CGSizeMake(320, 480)]) {
        return HDDeviceP4;
    }
    else if ([self isTheSameSize:size betweenSize:CGSizeMake(320, 568)]){
        return HDDeviceP5;
    }
    else if ([self isTheSameSize:size betweenSize:CGSizeMake(375, 667)]){
        return HDDeviceP6;
    }
    else if ([self isTheSameSize:size betweenSize:CGSizeMake(414, 736)]){
        return HDDeviceP6P;
    }
    return HDDeviceUnkown;
}

- (BOOL)isTheSameSize:(CGSize)size1 betweenSize:(CGSize)size2{
    if (size1.width == size2.width) {
        if (size1.height == size2.height) {
            return YES;
        }
    }
    else if (size1.width == size2.height) {
        if (size1.height == size2.width) {
            return YES;
        }
    }
    return NO;
}

@end
