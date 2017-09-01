//
//  BaseViewController.h
//  Hotchpotch
//
//  Created by Harry on 15/8/3.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;

@class HDHTTPSessionRequest;

@protocol HarryViewControllerDelegate <NSObject>

@optional
/**
 * 用于在控制器之间传递参数
 *
 * @param vc 委托事件的返回对象
 * @param event 事件类型，如果是结构体等可以使用NSValue等进行封装传递
 * @param obj 想要传递的其他参数
 * @return 控制器间传递参数的协议
 */
- (void)harryViewControllerDelegate:(UIViewController*)vc finishEvent:(id)event withObj:(id)obj;

@end


@interface HDBaseViewController : UIViewController <HarryViewControllerDelegate>

/**
 *  设置基类的背景颜色，在项目didFinishLaunchingWithOptions中设置
 *
 *  @param color 背景颜色
 */
+ (void)setBackgroundColor:(UIColor *)color;

/**
 *  设置基类的返回的图片，在项目didFinishLaunchingWithOptions中设置
 *
 *  @param backImageName 返回的图片
 */
+ (void)setBackImageName:(NSString *)backImageName;

/**
 *  广义级别的通知,当我们需要和另一个VC进行交互时候,可以执行此协议相关的方法!
 */
@property (nonatomic,assign)id<HarryViewControllerDelegate> vcDelegate;

/**
 *  网络请求对象，单例
 */
@property (nonatomic, strong) HDHTTPSessionRequest *httpRequest;


/**
 *  获取最上层的UIWindows对象,通常我们在显示一个模态对话框时候,会用到
 *
 *  @return 最上层的UIWindow对象
 */
-( UIWindow *)getKeyWindow;

/**
 *  获取项目AppDelegate对象
 *
 *  @return 项目AppDelegate对象
 */
- (AppDelegate *)getAppDelegate;



#pragma mark - 左右自定义按钮
- (void)showBackBtn;
- (void)hideBackBtn;

- (void)showLeftItemWithTitle:(NSString *)title selector:(SEL) selector;

- (void)showRightItemWithTitle:(NSString *)title selector:(SEL) selector;
- (void)showRightItemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor highlightTitleColor:(UIColor *)highlightColor selector:(SEL)selector;

- (void)showRightBarButtonWithImage:(UIImage *)image selector:(SEL)selector;
- (void)showRightBarButtonWithImage:(UIImage *)image hImage:(UIImage *)hImage selector:(SEL)selector;
- (void)showRightItemFixedOffsetWithTitle:(NSString *)itemTitle titleColor:(UIColor *)titleColor highlightTitleColor:(UIColor *)highlightColor itemSize:(CGSize)itemSize selector:(SEL)selector;

/**
 *  自定义返回按钮事件,showBackBtn的事件
 */
- (void)gotoBack;

/**
 *  自定义返回按钮事件, showLeftItemWithTitle: selector 的事件
 */
- (void)leftAction;

@end
