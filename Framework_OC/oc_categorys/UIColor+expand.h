//
//  UIColor+expand.h
//  Framework_OC
//
//  Created by zilu on 2017/12/9.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (expand)

@property (nonatomic,readonly) CGColorSpaceModel colorSpaceModel;
@property (nonatomic,readonly) CGFloat red;
@property (nonatomic,readonly) CGFloat green;
@property (nonatomic,readonly) CGFloat blue;
@property (nonatomic,readonly) CGFloat white;
@property (nonatomic,readonly) CGFloat alpha;

+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
