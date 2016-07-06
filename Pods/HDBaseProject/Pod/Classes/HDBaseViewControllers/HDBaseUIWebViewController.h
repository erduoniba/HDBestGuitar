//
//  BaseUIWebViewController.h
//  SecondHouseBroker
//
//  Created by Harry on 15-8-3.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOWebViewController.h"

@interface TOWebViewController (HarryExtetion)

- (void)webViewDidStartLoad:(UIWebView *)webView;

- (void)webViewDidFinishLoad:(UIWebView *)webView;

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;

@end

@interface HDBaseUIWebViewController : TOWebViewController

@property (nonatomic,assign) BOOL showCloseBtn;


/**
 *  设置基类的返回的图片，在项目didFinishLaunchingWithOptions中设置
 *
 *  @param backImageName 返回的图片
 */
+ (void)setBackImageName:(NSString *)backImageName;


@end
