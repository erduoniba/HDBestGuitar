//
//  BaseUITableViewController.h
//  SecondHouseBroker
//
//  Created by Harry on 14-6-10.
//  Copyright (c) 2014年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDBaseViewController.h"
#import "UITableView+Extension.h"

@interface HDBaseUITableViewController : HDBaseViewController<UITableViewDelegate,UITableViewDataSource>

/**
 *  是否添加键盘的观察者 YES 添加,NO 不添加, 注意,这个是在 初始化后
 */
@property (nonatomic, assign) BOOL              addKeyBoardObserverFlag;
@property (nonatomic, assign) NSInteger         pageIndex;
@property (nonatomic, assign) NSInteger         pageSize;
@property (nonatomic, assign) NSInteger         totalCount;

@property (nonatomic, strong) UITableView       *tableView;

@property (nonatomic, strong) NSMutableArray    *dataArr;


- (id)initWithStyle:(UITableViewStyle)style;

//添加刷新追加界面
-(void)addRefreshView;
-(void)addLoadMoreView;

//手动调用刷新追加方法
- (void)refresh;
- (void)loadMore;


/**
 *  刷新结束 关闭动画
 */
-(void)refreshEnd;

/**
 *  是否有更多
 *
 */
-(BOOL)hasMore;


/**
 *  发送请求的,这个子类必须根据实际需要重载它,默认这个方法什么都没做的
 */
- (void)requestData;

@end
