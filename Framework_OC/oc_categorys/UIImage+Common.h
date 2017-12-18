//
//  UIImage+Common.h
//  Framework_OC
//
//  Created by zilu on 2017/12/9.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Common)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color withBounds:(CGRect)bounds;
- (UIImage *)imageZoomLeftCapWidth:(CGFloat)leftRatio topCapWidth:(CGFloat)topCapRatio;//伸缩某个位置(以某个点为基准) Ratio：比例

@end
