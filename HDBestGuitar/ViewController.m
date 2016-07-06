//
//  ViewController.m
//  HDBestGuitar
//
//  Created by Harry on 16/7/6.
//  Copyright © 2016年 HarryDeng. All rights reserved.
//

#import "ViewController.h"
#import "HDImageAssist.h"
#import "UIDevice+HDCategory.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:self.view.frame];
    iv.image = [HDImageAssist getWholeImageWithName:@"bg_chordsmode_" ofType:@"jpg"];
    [self.view addSubview:iv];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
