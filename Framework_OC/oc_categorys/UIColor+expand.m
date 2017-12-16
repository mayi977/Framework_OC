//
//  UIColor+expand.m
//  Framework_OC
//
//  Created by zilu on 2017/12/9.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import "UIColor+expand.h"

@implementation UIColor (expand)

- (CGColorSpaceModel)colorSpaceModel{
    return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}

- (CGFloat)red{
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat)green{
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (self.colorSpaceModel == kCGColorSpaceModelMonochrome) {
        return c[0];
    }
    return c[1];
}

- (CGFloat)blue{
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (self.colorSpaceModel == kCGColorSpaceModelMonochrome) {
        return c[0];
    }
    return c[2];
}

- (CGFloat)white{
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat)alpha{
    return CGColorGetAlpha(self.CGColor);
}

+ (UIColor *)colorWithHexString:(NSString *)hexString{
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) {
        return nil;
    }
    
    return [UIColor colorWithRGBHex:hexNum];
}

+ (UIColor *)colorWithRGBHex:(UInt32)hex{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;

    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha{
    UIColor *color = [UIColor colorWithHexString:hexString];
    return [UIColor colorWithRed:color.red green:color.green blue:color.blue alpha:alpha];
}

@end
