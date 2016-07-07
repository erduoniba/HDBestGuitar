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

@interface HDMainViewController ()

PROPERTY_STRONG UIImageView *bgView;

PROPERTY_STRONG UIImageView *imageView;

@end

@implementation HDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bgView = [[UIImageView alloc] initWithFrame:self.view.frame];
    _bgView.image = [HDImageAssist getWholeImageWithName:@"bg_chordsmode_" ofType:@"jpg"];
    [self.view addSubview:_bgView];
    
    HDGuitarCordView *vvv = [[HDGuitarCordView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:vvv];
    
    
//    
//    UIImage *obj = [UIImage imageNamed:STRING_FROMAT(@"cord%d", 6)];
//    UIImage *image = [obj resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeTile];
//    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frameSizeWidth, obj.size.height)];
//    _imageView.image = image;
//    [self.view addSubview:_imageView];
//    [_imageView centerAlignVerticalForSuperView];
//    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnImageView:)];
//    [self.view addGestureRecognizer:tap];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
