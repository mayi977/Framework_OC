//
//  AppDelegate.h
//  Framework_OC
//
//  Created by zilu on 2017/12/7.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)setupTabBarController;
- (void)setupLoginViewController;

@end

