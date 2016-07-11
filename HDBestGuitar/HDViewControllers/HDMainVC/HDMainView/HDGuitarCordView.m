//
//  HDGuitarCordView.m
//  HDBestGuitar
//
//  Created by Harry on 16/7/7.
//  Copyright © 2016年 HarryDeng. All rights reserved.
//

#import "HDGuitarCordView.h"
#import "HDAnimationAssist.h"

@implementation HDGuitarCordView{
    CGFloat distance;
    CGFloat edgeDistance;
}

- (CGFloat )getWidthWithP6Witdh:(CGFloat)width{
    return kScreenHeight * width / 375;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        edgeDistance = [self getWidthWithP6Witdh:20];
        distance = (self.frameSizeHeight - edgeDistance * 2) / 6;
        
        [self buildCordLine];
    }
    return self;
}

- (void)buildCordLine{
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:6];
    for (int i=6; i>0; i--) {
        UIImage *image = [UIImage imageNamed:STRING_FROMAT(@"cord%d", i)];
        [images addObject:image];
    }
    
    [images enumerateObjectsUsingBlock:^(UIImage *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, edgeDistance + distance * idx, self.frameSizeWidth, distance)];
        bgView.backgroundColor = [UIColor clearColor]; //UIColorFromRGB(rand() % 255, 213, 34);
        bgView.tag = idx;
        [self addSubview:bgView];

        UIImage *image = [obj resizableImageWithCapInsets:UIEdgeInsetsMake(2, 0, 2, 0) resizingMode:UIImageResizingModeTile];
        UIImageView *cordLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bgView.frameSizeWidth, obj.size.height)];
        cordLine.image = image;
        cordLine.tag = 160707;
        [bgView addSubview:cordLine];
        [cordLine centerAlignVerticalForSuperView];
        
        cordLine.layer.shadowColor = [UIColor blackColor].CGColor;
        cordLine.layer.shadowOffset = CGSizeMake(0, 15);
        cordLine.layer.shadowOpacity = 0.8;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self parseTouches:touches];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self parseTouches:touches];
}

- (void)parseTouches:(NSSet<UITouch *> *)touches{
    UITouch *touch = [touches.allObjects firstObject];
    CGPoint point = [touch locationInView:self];
    
    //点击属于第几块区域
    NSInteger index = roundf(point.y / distance) - 1;
    UIView *bgView = [self viewWithTag:index];
    UIImageView *cordLine = (UIImageView *)[bgView viewWithTag:160707];
    if (cordLine) {
        [HDAnimationAssist combinAnimationInView:cordLine amplitude:2];
        
        if (_delegate && [_delegate respondsToSelector:@selector(hdGuitarCordView:atIndex:)]) {
            [_delegate hdGuitarCordView:self atIndex:index];
        }
    }
}

@end
