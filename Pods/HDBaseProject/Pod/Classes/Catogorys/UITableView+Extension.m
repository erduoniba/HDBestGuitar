//
//  UITableView+Extension.m
//  HarryCategory
//
//  Created by lingHarry on 14/11/14.
//  Copyright (c) 2014年 Harry. All rights reserved.
//

#import "UITableView+Extension.h"

@implementation UITableView (Extension)
-(NSIndexPath *)nextIndexPath:(NSIndexPath *)indexPath
{
    if ([self numberOfRowsInSection:indexPath.section] > (indexPath.row + 1)){
        return [NSIndexPath indexPathForRow:(indexPath.row + 1) inSection:indexPath.section];
    }
    else if ([self numberOfSections] > (indexPath.section + 1)){
        if ([self numberOfRowsInSection:(indexPath.section + 1)] > 0){
            return [NSIndexPath indexPathForRow:0 inSection:(indexPath.section + 1)];
        }
    }
    return nil;
}

-(NSIndexPath *)previousIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row - 1 >= 0) {
        return [NSIndexPath indexPathForRow:(indexPath.row - 1) inSection:indexPath.section];
    }
    else {
        if (indexPath.section - 1 >= 0) {
            NSInteger preRows = [self numberOfRowsInSection:(indexPath.section - 1)];
            if (preRows - 1 >= 0) {
                return [NSIndexPath indexPathForRow:preRows - 1 inSection:(indexPath.section - 1)];
            }
            
        }
    }
    
    return nil;
}

-(UITableViewCell *)previousTableViewCellIndexPath: (NSIndexPath *)currentIndexPath {
    return [self nextOrPreTableViewCellIndexPath:currentIndexPath flag:0];
    
}
-(UITableViewCell *)nextTableViewCellIndexPath: (NSIndexPath *)currentIndexPath {
    return [self nextOrPreTableViewCellIndexPath:currentIndexPath flag:1];
    
}



-(UITableViewCell *)nextOrPreTableViewCellIndexPath: (NSIndexPath *)currentIndexPath flag:(NSInteger)flag{
    NSAssert(currentIndexPath == nil,@"当前cell的索引不能为空");
    NSIndexPath *nextPath = nil;
    if (flag == 0) {
        nextPath = [self previousIndexPath:currentIndexPath];
    }
    else {
        nextPath = [self nextIndexPath:currentIndexPath];
    }
    
    if (nextPath!= nil) {
        UITableViewCell *cellWillShow = [self cellForRowAtIndexPath: nextPath];
        if (!cellWillShow) {
            [self scrollToRowAtIndexPath:nextPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
            cellWillShow = [self cellForRowAtIndexPath: nextPath];
        }
        return cellWillShow;
    }
    return nil;
    
}

-(UITableViewCell *)nextOrPreTableViewCell: (UITableViewCell *)currentCell flag:(NSInteger)flag{
    NSAssert(currentCell == nil,@"当前cell不能为空");
    NSIndexPath *nextPath = nil;
    NSIndexPath *currentIndexPath = [self indexPathForCell:currentCell];
    if (flag == 0) {
        nextPath = [self previousIndexPath:currentIndexPath];
    }
    else {
        nextPath = [self nextIndexPath:currentIndexPath];
    }
    
    if (nextPath!= nil) {
        UITableViewCell *cellWillShow = [self cellForRowAtIndexPath: nextPath];
        if (!cellWillShow) {
            [self scrollToRowAtIndexPath:nextPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
            cellWillShow = [self cellForRowAtIndexPath: nextPath];
        }
        return cellWillShow;
    }
    return nil;
    
}



- (void)setFirstResponder
{
    NSInteger sections = [self numberOfSections];
    for (int i = 0; i < sections ; i++) {
        NSInteger rows = [self numberOfRowsInSection:i];
        for (int j = 0; j < rows ; j++) {
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:j inSection:i];
            UITableViewCell * cell = [self cellForRowAtIndexPath:indexpath];
            
            if (!cell) {
                [self scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionTop animated:NO];
                cell = [self cellForRowAtIndexPath: indexpath];
            }
            
            if ([cell canBecomeFirstResponder]) {//这个需要能够响应FirstResponder的cell(一般是包含了一个可以响应键盘的textview或者textFeild)重载了 canBecomeFirstResponder 和 becomeFirstResponder
                [cell becomeFirstResponder];
                return ;
            }
            
        }
    }
    
}



-(void)registerCellName :(NSString *)cellName forCellReuseIdentifier:(NSString *)identifier;
{
    if (!cellName || cellName.length == 0) {
        return ;
    }
    
    NSString *cellReuseID = identifier;//
    if (!identifier || identifier.length == 0) {
        cellReuseID = cellName;
    }
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [[NSBundle mainBundle] pathForResource:cellName ofType:@"nib"];//虽然文件名的后缀是xib,但是这里需要使用nib
    BOOL flag =  [fileManager fileExistsAtPath:path];
    if (flag) {
            UINib *nib = [UINib nibWithNibName:cellName bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:cellReuseID];
    }
    else {
            Class cellClass = NSClassFromString(cellName);
            [self registerClass:cellClass forCellReuseIdentifier:cellReuseID ];
    }
}

-(void)registerCellName :(NSString *)cellName {
    [self registerCellName:cellName forCellReuseIdentifier:nil];
}

-(NSString *)deafultCellReuseIdentifier:(NSString *)cellName {
    NSString *cellReuseID = nil;//
    cellReuseID = cellName;
    return cellReuseID;
}

///< 创建一个cell
- (UITableViewCell *)cellForIndexPath:(NSIndexPath *)indexPath cellClass:(Class)cellCalss{
	UITableViewCell *cell = nil;
	if ([cellCalss isSubclassOfClass:UITableViewCell.class]) {
		id cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass(cellCalss)];
		if (!cell) {
			[self registerCellName:NSStringFromClass(cellCalss)];
			cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass(cellCalss) forIndexPath:indexPath];
		}
	}
	return cell;
}

@end
