//
//  BaseUITableViewCell.h
//  SecondHouseBroker
//
//  Created by Harry on 15-8-4.
//  Copyright (c) 2015年 Harry. All rights reserved.
//
/**
 *  带有分隔线的公共Cell类
 *
 */
#import <UIKit/UIKit.h>

@interface HDBaseUITableViewCell : UITableViewCell

@property (nonatomic, copy) void (^ handleCellAction)(Class className, id anything);

- (void)setData:(id)data;

+ (CGFloat)getCellFrame:(id)data;

@end
