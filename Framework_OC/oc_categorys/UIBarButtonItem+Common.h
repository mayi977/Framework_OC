//
//  UIBarButtonItem+Common.h
//  Framework_OC
//
//  Created by 蚂蚁 on 2017/12/18.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Common)

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title target:(id)obj action:(SEL)selector;

@end
