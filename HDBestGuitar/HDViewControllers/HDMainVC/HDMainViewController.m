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


@interface HDMainViewController () <HDGuitarCordViewDelegate, HDGuitarRhythmViewDelegate>

PROPERTY_STRONG UIImageView *bgView;
PROPERTY_STRONG HDGuitarCordView *guitarCordView;
PROPERTY_STRONG HDGuitarRhythmView *rhythmView;

@end

@implementation HDMainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bgView = [[UIImageView alloc] initWithFrame:self.view.frame];
    _bgView.image = [HDImageAssist getWholeImageWithName:@"bg_chordsmode_" ofType:@"jpg"];
    [self.view addSubview:_bgView];
    
    _guitarCordView = [[HDGuitarCordView alloc] initWithFrame:self.view.bounds];
    _guitarCordView.delegate = self;
    [self.view addSubview:_guitarCordView];
    
    _rhythmView = [[HDGuitarRhythmView alloc] initWithFrame:CGRectMake(10, 0, 81, self.view.frameSizeHeight)];
    _rhythmView.delegate = self;
    [self.view addSubview:_rhythmView];
}


#pragma mark - HDGuitarCordViewDelegate 
- (void)hdGuitarCordView:(HDGuitarCordView *)guitarCordView atIndex:(NSInteger)index{
    NSArray *arr = [HDMidiPlayAssist getGuitarNotes];
    [HDMidiPlayAssist playMidiNote:[arr[index][0] unsignedIntegerValue]];
}

#pragma mark - HDGuitarRhythmViewDelegate
- (void)hdGuitarRhythmView:(HDGuitarRhythmView *)rhythmView touchBeginAtIndex:(NSInteger)index{
//    [HDMidiPlayAssist playGuitarAtCord:index grade:0];
}

- (void)hdGuitarRhythmView:(HDGuitarRhythmView *)rhythmView touchEndAtIndex:(NSInteger)index{
    
    if (index == 0) {
        [HDMidiPlayAssist playGuitarAtCords:@[@5, @2, @1, @2, @0, @2, @1, @2] grades:@[@0, @0, @0, @0, @0, @0, @0, @0]];
    }
    else {
        [HDMidiPlayAssist playGuitarAtCords:@[@4, @2, @1, @2, @0, @2, @1, @2] grades:@[@0, @0, @0, @0, @0, @0, @0, @0]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
