//
//  NetAPIManager.m
//  Framework_OC
//
//  Created by 蚂蚁 on 2017/12/14.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import "NetAPIManager.h"
#import "NetAPIClient.h"

@implementation NetAPIManager

+ (instancetype)shareManager{
    static id manager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[NetAPIManager alloc] init];
    });
    return manager;
}

- (void)request_login:(NSString *)code block:(Block)block{
    [[NetAPIClient shareManager] setRequestjsonDataWithPath:@"Login" withParams:@{} showError:YES withMethodType:MethodTypePost complation:^(id data, NSError *error) {
        block(data,error);
    }];
}

@end
