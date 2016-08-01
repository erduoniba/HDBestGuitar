//
//  HDGuitarRhythmView.h
//  HDBestGuitar
//
//  Created by Harry on 16/7/8.
//  Copyright © 2016年 HarryDeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HDGuitarRhythmView;
@class HDGuitarRhythmModel;

@protocol HDGuitarRhythmViewDelegate <NSObject>

/**
 *  进入设置，选择和弦和节奏
 *
 *  @param rhythmView 
 */
- (void)hdGuitarRhythmViewSetAction:(HDGuitarRhythmView *)rhythmView;

/**
 *  选择开始右手节奏
 *
 *  @param rhythmView
 *  @param rhythm      选择节奏对象
 */
- (void)hdGuitarRhythmView:(HDGuitarRhythmView *)rhythmView touchBeginRhythmModel:(HDGuitarRhythmModel *)rhythm;

/**
 *  结束右手节奏
 *
 *  @param rhythmView
 *  @param rhythm      选择节奏对象
 */
- (void)hdGuitarRhythmView:(HDGuitarRhythmView *)rhythmView touchEndRhythmModel:(HDGuitarRhythmModel *)rhythm;

@end

/**
 *  右手节奏性 界面（自定义设置节奏，比如53231323、53123）
 */
@interface HDGuitarRhythmView : UIView

@property (nonatomic, weak) id <HDGuitarRhythmViewDelegate> delegate;

@property (nonatomic, strong) NSArray <HDGuitarRhythmModel *>* rhythms;

@end
