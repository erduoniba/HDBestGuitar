//
//  BaseUITableViewCell.h
//  SecondHouseBroker
//
//  Created by Harry on 15-8-4.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "HDBaseUITableViewCell.h"

@implementation HDBaseUITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

+ (CGFloat)getCellFrame:(id)msg {
    return 44;
}

- (void)setData:(id)data {
    
}


@end
