//
//  UIView+Common.m
//  Framework_OC
//
//  Created by zilu on 2017/12/10.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import "UIView+Common.h"

#define kTagLineView 1007
@implementation UIView (Common)

- (void)addLineUpOrDown:(BOOL)upOrDown color:(UIColor *)color{
    [self addLineUpOrDown:upOrDown color:color leftSpace:0 rightSpace:0];
}

- (void)addLineUpOrDown:(BOOL)upOrDown color:(UIColor *)color leftSpace:(CGFloat)leftSpace{
    [self addLineUpOrDown:upOrDown color:color leftSpace:leftSpace rightSpace:0];
}

- (void)addLineUpOrDown:(BOOL)upOrDown color:(UIColor *)color rightSpace:(CGFloat)rightSpace{
    [self addLineUpOrDown:upOrDown color:color leftSpace:0 rightSpace:rightSpace];
}

- (void)addLineUpOrDown:(BOOL)upOrDown color:(UIColor *)color leftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSapce{
    [self removeViewWithTag:kTagLineView];
    UIView *view;
    if (upOrDown) {
        view = [UIView viewY:0 color:color left:leftSpace right:rightSapce];
    }else{
        view = [UIView viewY:CGRectGetMaxY(self.bounds) - 0.5 color:color left:leftSpace right:rightSapce];
    }
    view.tag = kTagLineView;
    [self addSubview:view];
}

- (void)removeViewWithTag:(NSInteger)tag{
    for (UIView *aView in [self subviews]) {
        if (aView.tag == kTagLineView) {
            [aView removeFromSuperview];
        }
    }
}

+ (UIView *)viewY:(CGFloat)y color:(UIColor *)color left:(CGFloat)left right:(CGFloat)right{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(left, y, kScreen_Width - left - right, 0.5)];
    lineView.backgroundColor = color;
    return lineView;
}

@end
