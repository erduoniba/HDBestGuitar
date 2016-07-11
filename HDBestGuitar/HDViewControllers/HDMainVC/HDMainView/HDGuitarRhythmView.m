//
//  HDGuitarRhythmView.m
//  HDBestGuitar
//
//  Created by Harry on 16/7/8.
//  Copyright © 2016年 HarryDeng. All rights reserved.
//

#import "HDGuitarRhythmView.h"

#import <HDBaseProject/UIImage+Tint.h>

@implementation HDGuitarRhythmView

- (CGFloat )getWidthWithP6Witdh:(CGFloat)width{
    return kScreenHeight * width / 375;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildRhythmView];
    }
    return self;
}

- (void)buildRhythmView{
    CGFloat height = self.frameSizeHeight / 5;
    for (int i=0; i<5; i++) {
        UIButton *rhythmBt = [UIButton buttonWithType:UIButtonTypeCustom];
        rhythmBt.frame = CGRectMake(0, (height - 81)/2 + height * i, 81, 81);
        rhythmBt.tag = i;
        
        UIImage *image = [UIImage imageNamed:@"buts_icon"];
        if (i == 4){
            image = [UIImage imageNamed:@"btn_setting"];
        }
        else {
            image = [image imageTintedWithColor:UIColorFromRGB(198, 131, (i + 2) * 40)];
        }
        
        [rhythmBt setBackgroundImage:[UIImage imageNamed:@"buts"] forState:UIControlStateNormal];
        [rhythmBt setBackgroundImage:[UIImage imageNamed:@"buts_press"] forState:UIControlStateHighlighted];
        [rhythmBt setBackgroundImage:[UIImage imageNamed:@"buts_press"] forState:UIControlStateSelected];
        [rhythmBt setImage:image forState:UIControlStateNormal];
        [rhythmBt setImage:image forState:UIControlStateHighlighted];
        [rhythmBt setImage:image forState:UIControlStateSelected];
        [rhythmBt addTarget:self action:@selector(rhythmAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:rhythmBt];
    }
}

- (void)rhythmAction:(UIButton *)rhythmBt{
    if (_delegate && [_delegate respondsToSelector:@selector(hdGuitarRhythmView:atIndex:)]) {
        [_delegate hdGuitarRhythmView:self atIndex:rhythmBt.tag];
    }
}

@end
