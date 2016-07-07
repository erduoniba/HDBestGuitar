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
//        [HDAnimationAssist springAnimationInView:cordLine];
//        [self aaaa:cordLine value:1.4];
//        [self bbbb:cordLine value:3 y:cordLine.frameOriginY];

        [self ccc:cordLine y:5];
    }
}

- (NSValue *)getValue:(CGPoint)point{
    return [NSValue valueWithCGPoint:point];
}

- (void )ccc:(UIView *)view y:(CGFloat)y{
    //获取到当前View的layer
    CALayer *viewLayer = view.layer;
    
    CGPoint position = viewLayer.position;
    
    //设置动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    //设置运动形式
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];

    NSMutableArray *arr = [NSMutableArray array];
    int total = 30;
    for (int i=0; i<total; i++) {
        
        y -= (y / total);
        
        NSLog(@"yyy : %f", y);
        
        if (i % 2 == 0) {
            [arr addObject:@(position.y + y)];
        }
        else {
            [arr addObject:@(position.y - y)];
        }
    }
    
    animation.values = arr;
    
    //设置时间
    [animation setDuration:0.8];
    
    //添加上动画
    [viewLayer addAnimation:animation forKey:nil];
}

- (void)bbbb:(UIView *)view value:(CGFloat)value y:(CGFloat)y{
    
    if (value <= 1) {
        [UIView animateWithDuration:0.1 animations:^{
            view.frameOriginY = y;
        }];
        return ;
    }
    
    [UIView animateWithDuration:0.005 animations:^{
        view.frameOriginY = y + value;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.005 animations:^{
                view.frameOriginY = y - value - 0.1;
            } completion:^(BOOL finished) {
                if (finished) {
                    [self bbbb:view value:value - 0.2 y:y];
                }
            }];
        }
    }];
}

static BOOL dan = YES;
- (void)aaaa:(UIView *)view value:(CGFloat)value{
    
    NSLog(@"value : %f", value);
    
    if (value <= 1) {
        [UIView animateWithDuration:0.1 animations:^{
           view.transform = CGAffineTransformIdentity; 
        }];
        return ;
    }
    
    [UIView animateWithDuration:0.01 animations:^{
        view.transform = CGAffineTransformMakeScale(value, value);
    } completion:^(BOOL finished) {
        if (finished) {
            if (dan) {
                [self aaaa:view value:value-0.88];
            }
            else {
                [self aaaa:view value:value+0.8];
            }
            dan = !dan;
        }
    }];
}

@end
