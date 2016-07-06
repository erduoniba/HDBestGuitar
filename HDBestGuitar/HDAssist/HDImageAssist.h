//
//  HDImageAssist.h
//  HDBestGuitar
//
//  Created by 邓立兵 on 16/7/6.
//  Copyright © 2016年 HarryDeng. All rights reserved.
//

@import UIKit;

@interface HDImageAssist : NSObject

/**
 *  获取不同型号的iPhone设备对应的完整尺寸的图片(图片默认是png格式)
 *
 *  @param imageName 图片名称
 *  不同型号有不同的后缀 iPhone4s(P4)、iPhone5/5c/5s(P5)、iPhone6/6s(P6)、iPhone6Plus/6sPlus(P6P)
 *  通常情况下，P4、P5、P6使用@2x后缀，P6P使用@3x后缀， 不特别为P5做另外一套图，使用P6即可
 *
 *  @return 不同型号的iPhone设备对应的完整尺寸的图片
 */
+ (UIImage *)getWholeImageWithName:(NSString *)imageName;

/**
 *  获取不同型号的iPhone设备对应的完整尺寸的图片
 *
 *  @param imageName 图片名称
 *  不同型号有不同的后缀 iPhone4s(P4)、iPhone5/5c/5s(P5)、iPhone6/6s(P6)、iPhone6Plus/6sPlus(P6P)
 *  通常情况下，P4、P5、P6使用@2x后缀，P6P使用@3x后缀， 不特别为P5做另外一套图，使用P6即可
 *  @param imageType 图片格式
 *
 *  @return 不同型号的iPhone设备对应的完整尺寸的图片
 */
+ (UIImage *)getWholeImageWithName:(NSString *)imageName ofType:(NSString *)imageType;

@end
