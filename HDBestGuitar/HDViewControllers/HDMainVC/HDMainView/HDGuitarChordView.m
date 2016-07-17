//
//  HDGuitarChordView.m
//  HDBestGuitar
//
//  Created by Harry on 16/7/15.
//  Copyright © 2016年 HarryDeng. All rights reserved.
//

#import "HDGuitarChordView.h"
#import "HDGuitarChordModel.h"

@implementation HDGuitarChordView{
    UIButton        *lastSelectBt;
    NSMutableArray  *chordBts;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        chordBts = [NSMutableArray arrayWithCapacity:5];
        [self buildChordView];
    }
    return self;
}

- (void)buildChordView{
    CGFloat height = self.frameSizeHeight / 5;
    for (int i=0; i<5; i++) {
        UIButton *chordBt = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"btn_accord"];
        chordBt.frame = CGRectMake(0, (height - image.size.height)/2 + height * i, image.size.width, image.size.height);
        chordBt.tag = i;
        chordBt.selected = NO;
        [chordBt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [chordBt setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        chordBt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [chordBt setBackgroundImage:image forState:UIControlStateNormal];
        [chordBt addTarget:self action:@selector(chordAction:) forControlEvents:UIControlEventTouchUpInside];
        [chordBts addObject:chordBt];
        [self addSubview:chordBt];
    }
}

- (void)setChords:(NSArray <HDGuitarChordModel *>*)chords{
    _chords = chords;
    
    for (int i=0; i<_chords.count; i++) {
        UIButton *chordBt = chordBts[i];
        HDGuitarChordModel *chordModel = chords[i];
        [chordBt setTitle:chordModel.chordName forState:UIControlStateNormal];
    }
}

- (void)chordAction:(UIButton *)chordBt{
    
    if (lastSelectBt == chordBt) {
        if (chordBt.isSelected) {
            [chordBt setBackgroundImage:[UIImage imageNamed:@"btn_accord"] forState:UIControlStateNormal];
            if (_delegate && [_delegate respondsToSelector:@selector(hdGuitarChordView:grades:)]) {
                [_delegate hdGuitarChordView:self grades:@[@0, @0, @0, @0, @0, @0]];
            }
        }
        else {
            [chordBt setBackgroundImage:[UIImage imageNamed:@"btn_accord_press"] forState:UIControlStateNormal];
            if (_delegate && [_delegate respondsToSelector:@selector(hdGuitarChordView:grades:)]) {
                NSInteger index = [chordBts indexOfObject:chordBt];
                HDGuitarChordModel *chordModel = _chords[index];
                [_delegate hdGuitarChordView:self grades:chordModel.chordGrades];
            }
        }
        chordBt.selected = !chordBt.isSelected;
    }
    else {
        if (lastSelectBt) {
            [lastSelectBt setBackgroundImage:[UIImage imageNamed:@"btn_accord"] forState:UIControlStateNormal];
            lastSelectBt.selected = NO;
            
            [chordBt setBackgroundImage:[UIImage imageNamed:@"btn_accord_press"] forState:UIControlStateNormal];
            chordBt.selected = YES;
        }
        else {
            [chordBt setBackgroundImage:[UIImage imageNamed:@"btn_accord_press"] forState:UIControlStateNormal];
            chordBt.selected = YES;
        }
        lastSelectBt = chordBt;
        
        if (_delegate && [_delegate respondsToSelector:@selector(hdGuitarChordView:grades:)]) {
            NSInteger index = [chordBts indexOfObject:chordBt];
            HDGuitarChordModel *chordModel = _chords[index];
            [_delegate hdGuitarChordView:self grades:chordModel.chordGrades];
        }
    }
}


@end
