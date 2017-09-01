//
//  HDBaseViewModel.m
//  Pods
//
//  Created by denglibing on 2016/11/11.
//
//

#import "HDBaseCellViewModel.h"

@implementation HDBaseCellViewModel

+ (instancetype) modelFromClass:(Class)cellClass cellModel:(id)cellModel delegate:(id)delegate height:(NSInteger)height {
	HDBaseCellViewModel *model = [[self alloc] init];
	model.cellClass = cellClass;
	model.delegate = delegate;
	model.cellHeight = height;
	model.cellModel = cellModel;
	return model;
}

+ (instancetype) modelFromStaticCell:(UITableViewCell *)cell cellModel:(id)cellModel delegate:(id)delegate height:(NSInteger)height{
	HDBaseCellViewModel *model = [[self alloc] init];
	model.staticCell = cell;
	model.cellModel = cellModel;
	model.delegate = delegate;
	model.cellHeight = height;
	return model;
}

@end
