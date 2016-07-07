//
//  HDAnimationAssist.h
//  HDBestGuitar
//
//  Created by Harry on 16/7/7.
//  Copyright © 2016年 HarryDeng. All rights reserved.
//

@import UIKit;

@interface HDAnimationAssist : NSObject

/**
 *  对view进行弹簧动画，用于吉他的扫弦动画 （0.08s先1.3倍放大，然后同时执行 0.25秒1.0倍缩小动画、0.02的振动动画执行10次）
 *
 *  @param view
 */
+ (void)springAnimationInView:(UIView *)view;

@end
