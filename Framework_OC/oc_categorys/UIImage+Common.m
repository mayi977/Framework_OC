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

@end
