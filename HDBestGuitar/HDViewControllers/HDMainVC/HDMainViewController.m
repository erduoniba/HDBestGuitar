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


@interface HDMainViewController () <HDGuitarCordViewDelegate>

PROPERTY_STRONG UIImageView *bgView;
PROPERTY_STRONG HDGuitarCordView *guitarCordView;

@end

@implementation HDMainViewController

- (void)hdGuitarRhythmView:(HDGuitarRhythmView *)rhythmView atIndex:(NSInteger)index{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bgView = [[UIImageView alloc] initWithFrame:self.view.frame];
    _bgView.image = [HDImageAssist getWholeImageWithName:@"bg_chordsmode_" ofType:@"jpg"];
    [self.view addSubview:_bgView];
    

    _guitarCordView = [[HDGuitarCordView alloc] initWithFrame:self.view.bounds];
    _guitarCordView.delegate = self;
    [self.view addSubview:_guitarCordView];
    
    HDGuitarRhythmView *rhythmView = [[HDGuitarRhythmView alloc] initWithFrame:CGRectMake(10, 0, 81, self.view.frameSizeHeight)];
    rhythmView.delegate = self;
    [self.view addSubview:rhythmView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hhhhhh)];
    [self.view addGestureRecognizer:tap];
}


#pragma mark - HDGuitarCordViewDelegate 
- (void)hdGuitarCordView:(HDGuitarCordView *)guitarCordView atIndex:(NSInteger)index{
    NSArray *arr = [HDMidiPlayAssist getGuitarNotes];
    [HDMidiPlayAssist playMidiNote:[arr[index][0] unsignedIntegerValue]];
}

- (void)hhhhhh{

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
