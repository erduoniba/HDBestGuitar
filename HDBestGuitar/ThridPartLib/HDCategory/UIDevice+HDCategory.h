//
//  UIDevice+HDCategory.h
//  HDBestGuitar
//
//  Created by 邓立兵 on 16/7/6.
//  Copyright © 2016年 HarryDeng. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  获取当前设备的机型
 */
typedef NS_ENUM(NSInteger, HDDeviceType) {
    /**
     *  iPhone4/4s 尺寸:3.5 像素(pixel):640x960 分辨率(pt):320x480 图片后缀:@2x
     */
    HDDeviceP4 = 1 << 0,
    /**
     *  iPhone5/5c/5s 尺寸:4 像素(pixel):640x1136 分辨率(pt):320x568 图片后缀:@2x
     */
    HDDeviceP5 = 1 << 1,
    /**
     *  iPhone6/6s 尺寸:4.7 像素(pixel):750x1334 分辨率(pt):375x667 图片后缀:@2x
     */
    HDDeviceP6 = 1 << 2,
    /**
     *  iPhone6Plus/6Plus 尺寸:5.5 像素(pixel):启动图片需要1242×2208启动图来标示该设备是三倍(相对分辨率)图，但是其真实的像素是1080x1920[(414x736) * 3 / 1.15 = 1080x1920]  分辨率(pt):414x736 图片后缀:@3x
     */
    HDDeviceP6P = 1 << 3,
    /**
     *  未知设备
     */
    HDDeviceUnkown = 0xFF,
};

@interface UIDevice (HDCategory)

- (HDDeviceType)currentDeviceType;

@end
