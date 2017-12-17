//
//  UIImage+Common.m
//  Framework_OC
//
//  Created by zilu on 2017/12/9.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import "UIImage+Common.h"

@implementation UIImage (Common)

+ (UIImage *)imageWithColor:(UIColor *)color{
    
    return [self imageWithColor:color withFrame:CGRectMake(0, 0, 1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)color withFrame:(CGRect)frame{
    UIGraphicsBeginImageContext(frame.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, frame);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)imageZoomLeftCapWidth:(CGFloat)leftRatio topCapWidth:(CGFloat)topCapRatio{
    return [self stretchableImageWithLeftCapWidth:self.size.width * leftRatio topCapHeight:self.size.height * topCapRatio];
}

/*
 拉伸某个区域
 [self resizableImageWithCapInsets:<#(UIEdgeInsets)#>];
 [self resizableImageWithCapInsets:<#(UIEdgeInsets)#> resizingMode:<#(UIImageResizingMode)#>];
 */

@end
