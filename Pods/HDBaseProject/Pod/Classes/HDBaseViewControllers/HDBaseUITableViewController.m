//
//  BaseUITableViewController.m
//  SecondHouseBroker
//
//  Created by Harry on 14-6-10.
//  Copyright (c) 2014年 Harry. All rights reserved.
//

#import "HDBaseUITableViewController.h"

#import "HDBaseUITableViewCell.h"
#import "MJRefresh.h"
#import "UIView+Helpers.h"

#define kPageSize        20

@interface HDBaseUITableViewController ()
{
    UITableViewStyle _uitableViewStyle;
}

/**
 *  有需要的时候,才使用
 */
@property (nonatomic, strong) UIView    *tableviewHead;
@property (nonatomic, assign) BOOL      registerHeadSectionViewFlag;
@end

@implementation HDBaseUITableViewController

- (id)initWithStyle:(UITableViewStyle)style;{
    self = [super init];
    if (self) {
        _uitableViewStyle = style;
    }
    return self;
}

-(id)init {
    self = [super init];
    if (self) {
        _uitableViewStyle = UITableViewStylePlain;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _dataArr = [NSMutableArray arrayWithCapacity:10];
        _pageIndex = 0;
        _pageSize = kPageSize;
        _addKeyBoardObserverFlag = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_addKeyBoardObserverFlag) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
    }
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (_addKeyBoardObserverFlag) {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIKeyboardWillShowNotification
                                                      object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIKeyboardWillHideNotification
                                                      object:nil];
    }
}



-(void)addRefreshView{
    [self addRefreshViewArrowImage:nil];
}

-(void)addRefreshViewArrowImage:(UIImage *)arrowImage{
    __weak typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf refresh];
    }];
    
    if (arrowImage) {
        [(MJRefreshNormalHeader *)self.tableView.mj_header arrowView].image = arrowImage;
    }
    
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
}

-(void)addRefreshViewIdleArrowImages:(NSArray <UIImage *>*)idleArrowImages pullingArrowArrowImages:(NSArray <UIImage *>*)pullingArrowImages{
    __weak typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）

    if (idleArrowImages && pullingArrowImages) {
        self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            [weakSelf refresh];
        }];
        
        [(MJRefreshGifHeader *)self.tableView.mj_header setImages:idleArrowImages forState:MJRefreshStateIdle];
        [(MJRefreshGifHeader *)self.tableView.mj_header setImages:pullingArrowImages forState:MJRefreshStatePulling];
        [(MJRefreshGifHeader *)self.tableView.mj_header setImages:pullingArrowImages forState:MJRefreshStateRefreshing];
    }
        
    // 马上进入刷新状态
//    [self.tableView.mj_header beginRefreshing];
}

-(void)addLoadMoreView{
    // 添加默认的上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    
    // 设置文字
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    
    // 设置footer
    self.tableView.mj_footer = footer;
}


- (void)beginRefreshing{
	[self.tableView.mj_header beginRefreshing];
}

/**
 *  刷新结束 关闭动画
 */
-(void)refreshEnd{
    
    // 拿到当前的下拉刷新控件，结束刷新状态
    [self.tableView.mj_header endRefreshing];
    
    // 拿到当前的上拉刷新控件，结束刷新状态
    [self.tableView.mj_footer endRefreshing];
    
    if (![self hasMore]) {
        // 拿到当前的上拉刷新控件，变为没有更多数据的状态
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    
	[self.tableView reloadData];

}

-(BOOL)hasMore{
	int count = (int)self.totalCount/_pageSize;
	if(_totalCount%_pageSize > 0)
		count++;
	BOOL bHasMore = (_pageIndex >= count);
	return bHasMore;
}

-(UIView *)tableviewHead {
    if (!_tableviewHead) {
        _tableviewHead = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frameSizeWidth, 30)];
        _tableviewHead.backgroundColor = [UIColor clearColor];
    }
    return _tableviewHead;
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:_uitableViewStyle];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

#pragma mark - table

//iOS8上 cell分割线置顶
-(void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	
	if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
		[self.tableView setSeparatorInset:UIEdgeInsetsZero];
	}
	
	if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
		[self.tableView setLayoutMargins:UIEdgeInsetsZero];
	}
}

//分割线不留空
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
		[cell setSeparatorInset:UIEdgeInsetsZero];
	}
	
	if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
		[cell setLayoutMargins:UIEdgeInsetsZero];
	}
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HarryUITableViewCellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HarryUITableViewCellID"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (_addKeyBoardObserverFlag) {
        [self.view endEditing:YES];
    }
}


#pragma mark - net

- (void)refresh{
    //子类实现
    _pageIndex = 0;
    [self requestData];
}

- (void)loadMore{
    //子类实现
    _pageIndex ++;
    [self requestData];
}

- (void)requestData{
    //子类实现
}

- (void)closeMoreRefreshView{
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}


#pragma mark - 键盘弹出检测

- (void)keyboardWillShow:(NSNotification *)notification
{
    UIView * firstResponderView = [self.tableView fdd_findFirstResponder];
    UITableViewCell * cell = [firstResponderView fdd_superTableCell];
    if (cell){
        NSDictionary *keyboardInfo = [notification userInfo];
        CGRect keyboardFrame = [self.tableView.window convertRect:[keyboardInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue] toView:self.tableView.superview];
        CGFloat newBottomInset = self.tableView.frame.origin.y + self.tableView.frame.size.height - keyboardFrame.origin.y;
        if (newBottomInset > 0){
            UIEdgeInsets tableContentInset = self.tableView.contentInset;
            UIEdgeInsets tableScrollIndicatorInsets = self.tableView.scrollIndicatorInsets;
            tableContentInset.bottom = newBottomInset;
            tableScrollIndicatorInsets.bottom = tableContentInset.bottom;
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:[keyboardInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
            [UIView setAnimationCurve:[keyboardInfo[UIKeyboardAnimationCurveUserInfoKey] intValue]];
            self.tableView.contentInset = tableContentInset;
            self.tableView.scrollIndicatorInsets = tableScrollIndicatorInsets;
            NSIndexPath *selectedRow = [self.tableView indexPathForCell:cell];
            [self.tableView scrollToRowAtIndexPath:selectedRow atScrollPosition:UITableViewScrollPositionNone animated:NO];
            [UIView commitAnimations];
        }
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    UIView * firstResponderView = [self.tableView fdd_findFirstResponder];
    UITableViewCell * cell = [firstResponderView fdd_superTableCell];
    if (cell){
        NSDictionary *keyboardInfo = [notification userInfo];
        UIEdgeInsets tableContentInset = self.tableView.contentInset;
        UIEdgeInsets tableScrollIndicatorInsets = self.tableView.scrollIndicatorInsets;
        tableContentInset.bottom = 0;
        tableScrollIndicatorInsets.bottom = tableContentInset.bottom;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:[keyboardInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
        [UIView setAnimationCurve:[keyboardInfo[UIKeyboardAnimationCurveUserInfoKey] intValue]];
        self.tableView.contentInset = tableContentInset;
        self.tableView.scrollIndicatorInsets = tableScrollIndicatorInsets;
        [UIView commitAnimations];
    }
}

@end
