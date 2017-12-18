//
//  UIBarButtonItem+Common.m
//  Framework_OC
//
//  Created by 蚂蚁 on 2017/12/18.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import "UIBarButtonItem+Common.h"

@implementation UIBarButtonItem (Common)

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title target:(id)obj action:(SEL)selector{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:obj action:selector];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateDisabled];
    
    return item;
}

@end
