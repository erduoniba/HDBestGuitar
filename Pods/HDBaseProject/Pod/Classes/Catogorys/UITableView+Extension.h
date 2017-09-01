//
//  UITableView+Extension.h
//  HarryCategory
//
//  Created by lingHarry on 14/11/14.
//  Copyright (c) 2014年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Extension)

/**
 *  获取表格中下一个索引
 *
 *  @param indexPath 当前索引
 *
 *  @return 下一个索引
 */
-(NSIndexPath *)nextIndexPath:(NSIndexPath *)indexPath;

/**
 *  获取表格的上一个索引
 *
 *  @param indexPath 当前索引
 *
 *  @return 上一个索引,如果没有,则返回空
 */
-(NSIndexPath *)previousIndexPath:(NSIndexPath *)indexPath;


/**
 *  获取表格的下一个cell
 *
 *  @param currentIndexPath 当前cell的索引
 *
 *  @return 下一个cell
 */
-(UITableViewCell *)nextTableViewCellIndexPath: (NSIndexPath *)currentIndexPath;



/**
 *  获取表格的上一个cell
 *
 *  @param currentIndexPath 当前cell的索引
 *
 *  @return 上一个cell
 */
-(UITableViewCell *)previousTableViewCellIndexPath: (NSIndexPath *)currentIndexPath ;

/**
 *  获取当前cell的下一个或者上一个cell
 *
 *  @param currentCell 当前cell
 *  @param flag        0 上一个cell  1 获取下一个cell
 *
 *  @return 获取到的cell,为空,表示没有下一个或者上一个,或者本身就是空的
 */
-(UITableViewCell *)nextOrPreTableViewCell: (UITableViewCell *)currentCell flag:(NSInteger)flag;
-(UITableViewCell *)nextOrPreTableViewCellIndexPath: (NSIndexPath *)currentIndexPath flag:(NSInteger)flag;

/**
 *  将这个表格中的某一个可以成为第一响应者的cell获取第一响应者,这个需要能够响应FirstResponder的cell(一般是包含了一个可以响应键盘的textview或者textFeild)重载了 canBecomeFirstResponder 和 becomeFirstResponder
 */
- (void)setFirstResponder;

/**
 *  注册cell,会首先判断是否有对应名字的nib文件,如果没有,则使用registerClass 否则,使用registerNib
 *
 *  @param cellName   cell的名字
 *  @param identifier 重用的id
 */
-(void)registerCellName :(NSString *)cellName forCellReuseIdentifier:(NSString *)identifier;

/**
 *  注册cell,会首先判断是否有对应名字的nib文件,如果没有,则使用registerClass 否则,使用registerNib  重用的字符串,默认是 cellName+ID
 *
 *  @param cellName cell重用的名字
 */
-(void)registerCellName :(NSString *)cellName ;

/**
 *  返回一个默认的cell重用id,一般是名字+id
 *
 *  @param cellName cell的名字
 *
 *  @return 返回一个默认的cell重用id,一般是名字+id
 */
-(NSString *)deafultCellReuseIdentifier:(NSString *)cellName;


///< 创建一个cell
- (UITableViewCell *)cellForIndexPath:(NSIndexPath *)indexPath cellClass:(Class)cellCalss;

@end
