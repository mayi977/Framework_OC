//
//  NSObject+Common.m
//  Framework_OC
//
//  Created by zilu on 2017/12/9.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import "NSObject+Common.h"
#import "Login.h"
#import <JDStatusBarNotification.h>

#define BaseUrlString @"https://coding.net/"
@implementation NSObject (Common)

+ (NSString *)baseUrlStr{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults valueForKey:BaseUrlString] ?: BaseUrlString;
}

+ (NSString *)tipFromError:(NSError *)error{
    if (error && error.userInfo) {
        //
    }
    
    return nil;
}

- (id)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError{
    NSError *error = nil;
    NSInteger code = [[responseJSON valueForKey:@"code"] integerValue];
    if (code != 0) {
        error = [NSError errorWithDomain:[NSObject baseUrlStr] code:code userInfo:responseJSON];
        if (code == 1000 || code == 3207) {//用户未登录
            if ([Login isLogin]) {
                [Login doLogout];//已登录的状态要抹去
                //更新UI要延迟>1.0s,否则屏幕可能不能响应触摸事件？？
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [(AppDelegate *)[UIApplication sharedApplication].delegate setupLoginViewController];
                    NSString *errorStr = [NSObject tipFromError:error];
                    [[[UIAlertView alloc] initWithTitle:@"温馨提示" message:errorStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                });
            }
        }else{
            //验证码弹框
            NSMutableDictionary *params = nil;
            if (code == 907) {
                params = @{@"type":@3}.mutableCopy;
            }
            
            if (params) {
                [NSObject showCaptchViewParams:params];
            }
            
            if (autoShowError) {
                [NSObject showError:error];
            }
        }
    }
    
    return error;
}

+ (void)showError:(NSError *)error{
    if ([JDStatusBarNotification isVisible]) {
        NSLog(@"如果statusbar上面正在显示信息，则不再用hud显示error");
        return;
    }
    NSString *tipStr = [NSObject tipFromError:error];
//    [NSObject show];
}

+ (void)showCaptchViewParams:(NSMutableDictionary *)parmas{
    
}

@end
