//
//  NSString+Common.h
//  Framework_OC
//
//  Created by zilu on 2017/12/9.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)

+ (NSString *)userAgent;
- (BOOL)isPhoneNum;
- (BOOL)isEmail;
- (CGFloat)getWidthFont:(UIFont *)font textHeigth:(CGFloat)height;

@end
