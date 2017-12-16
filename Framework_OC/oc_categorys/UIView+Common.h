//
//  UIView+Common.h
//  Framework_OC
//
//  Created by zilu on 2017/12/10.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Common)

- (void)addLineUpOrDown:(BOOL)upOrDown color:(UIColor *)color;
- (void)addLineUpOrDown:(BOOL)upOrDown color:(UIColor *)color leftSpace:(CGFloat)leftSpace;
- (void)addLineUpOrDown:(BOOL)upOrDown color:(UIColor *)color rightSpace:(CGFloat)rightSpace;
- (void)addLineUpOrDown:(BOOL)upOrDown color:(UIColor *)color leftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSapce;

@end
