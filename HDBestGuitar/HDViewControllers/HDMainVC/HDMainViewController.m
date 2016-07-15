//
//  HDMainViewController.m
//  HDBestGuitar
//
//  Created by Harry on 16/7/7.
//  Copyright © 2016年 HarryDeng. All rights reserved.
//



#import "HDMainViewController.h"

#pragma mark - assists
#import "HDImageAssist.h"
#import "UIDevice+HDCategory.h"
#import "HDAnimationAssist.h"
#import "HDMidiPlayAssist.h"

#pragma mark - views
#import "HDGuitarCordView.h"
#import "HDGuitarRhythmView.h"
#import "HDGuitarChordView.h"
#import "HDGuitarChordModel.h"


@interface HDMainViewController () <HDGuitarCordViewDelegate, HDGuitarRhythmViewDelegate, HDGuitarChordViewDelegate>

PROPERTY_STRONG UIImageView         *bgView;
PROPERTY_STRONG HDGuitarCordView    *guitarCordView;
PROPERTY_STRONG HDGuitarChordView   *guitarChordView;
PROPERTY_STRONG HDGuitarRhythmView  *guitarRhythmView;

PROPERTY_STRONG HDMidiPlayAssist    *midiPlayAssist;
PROPERTY_STRONG NSArray             *selectGrades;   //选择的和弦品位组

@end

@implementation HDMainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _selectGrades = @[@0, @0, @0, @0, @0, @0, @0, @0];
    
    _bgView = [[UIImageView alloc] initWithFrame:self.view.frame];
    _bgView.image = [HDImageAssist getWholeImageWithName:@"bg_chordsmode_" ofType:@"jpg"];
    [self.view addSubview:_bgView];
    
    _guitarCordView = [[HDGuitarCordView alloc] initWithFrame:self.view.bounds];
    _guitarCordView.delegate = self;
    [self.view addSubview:_guitarCordView];
    
    _guitarRhythmView = [[HDGuitarRhythmView alloc] initWithFrame:CGRectMake(10, 0, 81, self.view.frameSizeHeight)];
    _guitarRhythmView.delegate = self;
    [self.view addSubview:_guitarRhythmView];
    
    _guitarChordView = [[HDGuitarChordView alloc] initWithFrame:CGRectMake(self.view.frameSizeWidth - 91, 0, 81, self.view.frameSizeHeight)];
    _guitarChordView.chords = [HDGuitarChordModel defaultChords];
    _guitarChordView.delegate = self;
    [self.view addSubview:_guitarChordView];
}

- (HDMidiPlayAssist *)midiPlayAssist{
    if (!_midiPlayAssist) {
        _midiPlayAssist = [HDMidiPlayAssist shareInstance];
        @weakify(self);
        _midiPlayAssist.midiPlayCordGradeHandle = ^(NSArray *cords, NSArray *grades){
            [cords enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                @strongify(self);
                [self.guitarCordView animationGuitarCordLineAtIndex:obj.integerValue];
            }];
        };
    }
    return _midiPlayAssist;
}


#pragma mark - HDGuitarCordViewDelegate 
- (void)hdGuitarCordView:(HDGuitarCordView *)guitarCordView atIndex:(NSInteger)index{
    NSInteger grade = [_selectGrades[index - 1] integerValue];
    [self.midiPlayAssist playGuitarAtCord:index grade:grade];
}

#pragma mark - HDGuitarRhythmViewDelegate
- (void)hdGuitarRhythmView:(HDGuitarRhythmView *)rhythmView touchBeginAtIndex:(NSInteger)index{
    if (index == 0) {
        [self.midiPlayAssist playGuitarAtCords:@[@6, @3, @2, @3, @1, @3, @2, @3] grades:_selectGrades];
    }
    else {
        [self.midiPlayAssist playGuitarAtCords:@[@5, @3, @2, @3, @1, @3, @2, @3] grades:_selectGrades];
    }
}

- (void)hdGuitarRhythmView:(HDGuitarRhythmView *)rhythmView touchEndAtIndex:(NSInteger)index{
    [self.midiPlayAssist stopPlayMidiAllNotes];
}

#pragma mark - HDGuitarChordViewDelegate
- (void)hdGuitarChordView:(HDGuitarChordView *)guitarChordView grades:(NSArray *)grades{
    _selectGrades = grades;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
