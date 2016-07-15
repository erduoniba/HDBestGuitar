//
//  HDGuitarChordView.h
//  HDBestGuitar
//
//  Created by Harry on 16/7/15.
//  Copyright © 2016年 HarryDeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HDGuitarChordView;
@class HDGuitarChordModel;

@protocol HDGuitarChordViewDelegate <NSObject>

/**
 *  吉他和弦界面
 *
 *  @param guitarCordView   吉他和弦界面
 *  @param grades           该和弦所按下的 和弦 （品位组）
 */
- (void)hdGuitarChordView:(HDGuitarChordView *)guitarChordView grades:(NSArray *)grades;

@end

@interface HDGuitarChordView : UIView


/**
 *  和弦 数据源
 */
@property (nonatomic, strong) NSArray <HDGuitarChordModel *>*chords;

@property (nonatomic, assign) id <HDGuitarChordViewDelegate> delegate;

@end
