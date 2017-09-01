//
//  HDBaseViewModel.h
//  Pods
//
//  Created by denglibing on 2016/11/11.
//
//

#import <Foundation/Foundation.h>

// __unsafe_unretained 使用 http://stackoverflow.com/questions/8592289/arc-the-meaning-of-unsafe-unretained

@interface HDBaseCellViewModel : NSObject

@property (nonatomic, strong) id cellModel;                     //cell的数据源
@property (nonatomic, assign) Class cellClass;					//cell的Class
@property (nonatomic, weak)	  id delegate;						//cell的代理
@property (nonatomic, assign) CGFloat cellHeight;               //cell的高度，提前计算好
@property (nonatomic, assign) SEL selector;                     //cell的点击事件
@property (nonatomic, strong) UITableViewCell *staticCell;		//兼容静态的cell

+ (instancetype) modelFromClass:(__unsafe_unretained Class)cellClass cellModel:(id)cellModel delegate:(id)delegate height:(NSInteger)height;
+ (instancetype) modelFromStaticCell:(UITableViewCell *)cell cellModel:(id)cellModel delegate:(id)delegate height:(NSInteger)height;

@end
