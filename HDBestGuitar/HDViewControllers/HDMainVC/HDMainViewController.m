//
//  HDMainViewController.m
//  HDBestGuitar
//
//  Created by Harry on 16/7/7.
//  Copyright © 2016年 HarryDeng. All rights reserved.
//

#import "HDMainViewController.h"

#pragma mark - assist
#import "HDImageAssist.h"
#import "UIDevice+HDCategory.h"
#import "HDAnimationAssist.h"
#import "HDGuitarCordView.h"

@interface HDMainViewController () <HDGuitarCordViewDelegate>

PROPERTY_STRONG UIImageView *bgView;
PROPERTY_STRONG HDGuitarCordView *guitarCordView;

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

}


#pragma mark - HDGuitarCordViewDelegate 
- (void)hdGuitarCordView:(HDGuitarCordView *)guitarCordView atIndex:(NSInteger)index{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
