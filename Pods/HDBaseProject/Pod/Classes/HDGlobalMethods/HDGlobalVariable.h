//
//  GlobalVariable.h
//  Hotchpotch
//
//  Created by Harry on 15/8/3.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#ifndef HD_GlobalVariable_h
#define HD_GlobalVariable_h

#define CURRENT_IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]


#define PROPERTY_STRONG     @property (nonatomic, strong)
#define PROPERTY_ASSIGN     @property (nonatomic, assign)
#define PROPERTY_COPY       @property (nonatomic, copy)

#define weak_self(obj)      __weak typeof(obj) weak_self = obj;

#define kScreenWidth             ([[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight            ([[UIScreen mainScreen] bounds].size.height)
#define kFullViewHeight          (kScreenHeight - 64)


#ifdef DEBUG
    #define DLog(...) NSLog(__VA_ARGS__)
#else
    #define DLog(...)
#endif

#define STRING_FROMAT(...)        [NSString stringWithFormat:__VA_ARGS__]


//RGB转UIColor函数
#define	UIColorFromRGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0  \
blue:b/255.0 alpha:1.0]


//十六进制颜色转换
#define UIColorMakeRGBA(nRed, nGreen, nBlue, nAlpha) [UIColor colorWithRed:(nRed)/255.0f \
green:(nGreen)/255.0f \
blue:(nBlue)/255.0f \
alpha:nAlpha]

/**
 *  使用方式是UIColorHexFromRGB(0x067AB5);
 */
#define UIColorHexFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorHexFromRGBAlpha(rgbValue,alp) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alp]

#define UIColorMakeRGB(nRed, nGreen, nBlue) UIColorMakeRGBA(nRed, nGreen, nBlue, 1.0f)
#define UIColorRGB(color) UIColorMakeRGB(color>>16, (color&0x00ff00)>>8,color&0x0000ff)



#define GET_IMAGE_NAME(name)    [UIImage imageNamed:name]
#define GET_IMAGE_PATH(path)    [UIImage imageWithContentsOfFile:path]


#endif






