//
//  HDAnimationAssist.m
//  HDBestGuitar
//
//  Created by Harry on 16/7/7.
//  Copyright © 2016年 HarryDeng. All rights reserved.
//

#import "HDAnimationAssist.h"

@implementation HDAnimationAssist

/**
 *  对view进行弹簧动画，用于吉他的扫弦动画
 *
 *  @param view
 */
+ (void)springAnimationInView:(UIView *)view{
    [UIView animateWithDuration:0.05 animations:^{
        view.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            view.transform = CGAffineTransformMakeScale(1, 1);
        }];
        
        //获取到当前View的layer
        CALayer *viewLayer = view.layer;
        
        CGPoint position = viewLayer.position;
        
        //移动的两个终点位置
        CGPoint beginPosition = CGPointMake(position.x, position.y);
        CGPoint endPosition = CGPointMake(position.x, position.y - 2.5);

        //设置动画
        CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"position"];
        //设置运动形式
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        //设置开始位置
        [animation setFromValue:[NSValue valueWithCGPoint:beginPosition]];
        //设置结束位置
        [animation setToValue:[NSValue valueWithCGPoint:endPosition]];
        //设置时间
        [animation setDuration:0.02];
        
        /*
         duration 动画从开始到结束的时间间隔
         delay 延迟的时间
         dampingRatio 在接近最终状态的时候震荡的幅度，0到1，1震荡最小。
         velocity 最初条约的速度，例如，如果动画的距离是200，这个值是0.5，那么速度就是100pt/s
         animations 实际要执行的动画
         completion 动画结束时候执行的block
         */
        animation.damping = 0.2;
        animation.initialVelocity = 35;
        
        //设置次数
        [animation setRepeatCount:10];
        //添加上动画
        [viewLayer addAnimation:animation forKey:nil];
        
    }];
}

@end
