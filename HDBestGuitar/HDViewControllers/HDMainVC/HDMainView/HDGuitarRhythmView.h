//
//  HDGuitarRhythmView.h
//  HDBestGuitar
//
//  Created by Harry on 16/7/8.
//  Copyright © 2016年 HarryDeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HDGuitarRhythmView;

@protocol HDGuitarRhythmViewDelegate <NSObject>

/**
 *  选择右手节奏
 *
 *  @param rhythmView
 *  @param index      选择第几个节奏
 */
- (void)hdGuitarRhythmView:(HDGuitarRhythmView *)rhythmView atIndex:(NSInteger)index;

@end

/**
 *  右手节奏性 界面（自定义设置节奏，比如53231323、53123）
 */
@interface HDGuitarRhythmView : UIView

@property (nonatomic, weak) id <HDGuitarRhythmViewDelegate> delegate;

@end
