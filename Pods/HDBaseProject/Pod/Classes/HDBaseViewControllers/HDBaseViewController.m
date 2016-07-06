//
//  BaseViewController.m
//  Hotchpotch
//
//  Created by Harry on 15/8/3.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "HDBaseViewController.h"

#import "HDBaseUIWebViewController.h"

#import "HDGlobalMethods.h"


@interface HDBaseViewController () <UIGestureRecognizerDelegate>

@end

@implementation HDBaseViewController

static UIColor *backgroundColor;
static NSString *backImageName;

+ (void)setBackgroundColor:(UIColor *)color{
    backgroundColor = color;
}

+ (void)setBackImageName:(NSString *)imageName{
    backImageName = imageName;
    [HDBaseUIWebViewController setBackImageName:imageName];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    if (backgroundColor) {
        self.view.backgroundColor = backgroundColor;
    }
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
	
    NSArray *viewControllers = self.navigationController.viewControllers;
    //不是根VC自动加上返回
    if (viewControllers.count > 1) {
        [self showBackBtn];
    }
    else{
        [self hideBackBtn];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIWindow *)getKeyWindow {
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication] windows] reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        if (window.windowLevel == UIWindowLevelNormal) {
            return window;
        }
    }
    return nil;
}

- (AppDelegate *)getAppDelegate{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return appDelegate;
}

- (BOOL )gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.navigationController.viewControllers.count == 1){
        //关闭主界面的右滑返回
        return NO;
    }
    else{
        return YES;
    }
}


#pragma mark - 左右自定义按钮
- (UIBarButtonItem *)createBarBackButtonItem:(id)target
                                    selector:(SEL)action
{
    UIImage * img = [UIImage imageNamed:backImageName];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, img.size.width+10, img.size.height)];
    
    [button setImage:img forState:UIControlStateNormal];
    
    [button setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLabel = [button titleLabel];
    [titleLabel sizeToFit];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barButtonItem;
}

- (void)hideBackBtn
{
    self.navigationItem.leftBarButtonItems = nil;
    static UIView *clearView = nil;
    if(clearView == nil)
    {
        clearView = [UIView new];
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:clearView];
}

- (void)showBackBtn
{
    [self showBackBtnWithSelector:@selector(gotoBack)];
}

- (void)showBackBtnWithSelector:(SEL)selector
{
    UIBarButtonItem *backItem = [self createBarBackButtonItem:self selector:selector];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, backItem];
}

- (void)showLeftItemWithTitle:(NSString *)title selector:(SEL) selector{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(0, 0, 60, 32)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
}

-(void) showRightItemWithTitle:(NSString *) title selector:(SEL) selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(0, 0, 44, 32)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.rightBarButtonItem = item;
}

- (void)showRightItemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor highlightTitleColor:(UIColor *)highlightColor selector:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitleColor:titleColor ? : [UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:highlightColor ? : [UIColor blackColor] forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(0, 0, 44, 32)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)showRightBarButtonWithImage:(UIImage *)image selector:(SEL)selector
{
    if (image)
    {
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:selector];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)showRightBarButtonWithImage:(UIImage *)image hImage:(UIImage *)hImage selector:(SEL)selector
{
    if (self.navigationItem.rightBarButtonItem == nil) {
        UIButton *mRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        [mRightBtn setAutoresizesSubviews:YES];
        [mRightBtn setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        [mRightBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
        [mRightBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barRButtonItem = [[UIBarButtonItem alloc] initWithCustomView:mRightBtn];
        [self.navigationItem setRightBarButtonItem:barRButtonItem];
    }
    UIButton *mRightBtn = (UIButton *)self.navigationItem.rightBarButtonItem.customView;
    [mRightBtn setImage:image forState:UIControlStateNormal];
    if (hImage) {
        [mRightBtn setImage:hImage forState:UIControlStateHighlighted];
    }
}

- (void)showRightItemFixedOffsetWithTitle:(NSString *)itemTitle titleColor:(UIColor *)titleColor highlightTitleColor:(UIColor *)highlightColor itemSize:(CGSize)itemSize selector:(SEL)selector
{
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, itemSize.width, itemSize.height)];
    [rightBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:itemTitle forState:UIControlStateNormal];
    [rightBtn setTitleColor:titleColor forState:UIControlStateNormal];
    if (highlightColor)
    {
        [rightBtn setTitleColor:highlightColor forState:UIControlStateHighlighted];
    }
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    
    UIBarButtonItem *fixItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixItem.width = -20.0f;
    
    self.navigationItem.rightBarButtonItems = @[fixItem,rightItem];
    
}

- (void)leftAction{
    
}

- (void)gotoBack
{
    if (self.navigationController.viewControllers.count > 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        if ([self presentingViewController])
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

@end
