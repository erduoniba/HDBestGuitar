//
//  BaseUIWebViewController.h
//  SecondHouseBroker
//
//  Created by Harry on 15-8-3.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "HDBaseUIWebViewController.h"

#import "HDGlobalMethods.h"
#import "HDGlobalVariable.h"

@interface HDBaseUIWebViewController ()

@property (nonatomic,strong)UIButton *defaultBackButton;//默认的返回按钮
@property (nonatomic,strong)UIButton *closeBtn;//关闭按钮

@end

@implementation HDBaseUIWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.showPageTitles = NO;
    }
    return self;
}

static NSString *backImageName;
+ (void)setBackImageName:(NSString *)imageName{
    backImageName = imageName;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _showCloseBtn = YES;
    NSArray *array=self.navigationController.viewControllers;
    if(array.count > 1){
        [self setNavigationItemBack];
    }
	
	self.view.backgroundColor = [UIColor whiteColor];
	self.webView.opaque = NO;
	self.webView.backgroundColor = [UIColor clearColor];
}

//创建一个默认的后退按钮
-(UIButton *)defaultBackButton
{
    if(_defaultBackButton==nil)
    {
        UIButton *btn = [HDGlobalMethods createBackButton:[UIImage imageNamed:backImageName] hilight:[UIImage imageNamed:backImageName]];
        [btn addTarget:self
                action:@selector(onLeftBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        _defaultBackButton = btn;
    }
    return _defaultBackButton;
}

-(UIBarButtonItem *)defaultBackBarItem{
    UIBarButtonItem *buttonBarITem = [[UIBarButtonItem alloc] initWithCustomView:self.defaultBackButton];
    return buttonBarITem;
}

-(void)setNavigationItemBack {
    UIBarButtonItem  *leftbarbuttonItem = [self defaultBackBarItem];
    self.navigationItem.leftBarButtonItem = leftbarbuttonItem;
}



-(void)setNavigationItemBackAndClose {
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithCustomView:self.closeBtn];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:self.defaultBackButton];
    self.navigationItem.leftBarButtonItems = @[backItem,closeItem, space];
}

-(void)onLeftBtnPress:(id)sender{
    if ([self.webView canGoBack]){
        [self.webView goBack];
        if (_showCloseBtn) {
            [self setNavigationItemBackAndClose];
        }
        else {
            [self setNavigationItemBack];
        }
    }
    else{
        if (self.navigationController.viewControllers.count == 1) {
            [self dismissViewControllerAnimated:YES completion:Nil];
        }
        else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}



- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [super webViewDidStartLoad:webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [super webViewDidFinishLoad:webView];
    if ([self.webView canGoBack])
    {
        if (_showCloseBtn) {
           [self setNavigationItemBackAndClose];
        }
        else {
            [self setNavigationItemBack];
        }
    }
    else {
        [self setNavigationItemBack];
    }
    
}

-(UIButton *)closeBtn {
    if (!_closeBtn) {
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
        [backButton setTitle:@"关闭" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor colorWithRed:242/255.0 green:88/255.0 blue:36/255.0 alpha:1] forState:UIControlStateNormal];
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [backButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _closeBtn = backButton;
    }
    return _closeBtn;
    
}
-(void)closeAction:(id)sender{
    
    if (self.navigationController.viewControllers.count == 0) {
        [self dismissViewControllerAnimated:YES completion:Nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)dealloc {
    
}
@end
