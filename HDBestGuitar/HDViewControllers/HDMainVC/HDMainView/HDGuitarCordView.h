//
//  HDGuitarCordView.h
//  HDBestGuitar
//
//  Created by Harry on 16/7/7.
//  Copyright © 2016年 HarryDeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HDGuitarCordView;

@protocol HDGuitarCordViewDelegate <NSObject>

/**
 *  吉他六弦界面，点击的第几根弦
 *
 *  @param guitarCordView 吉他六弦界面
 *  @param index          第几根弦
 */
- (void)hdGuitarCordView:(HDGuitarCordView *)guitarCordView atIndex:(NSInteger)index;

@end

@interface HDGuitarCordView : UIView

@property (nonatomic, assign) id <HDGuitarCordViewDelegate> delegate;

@end
