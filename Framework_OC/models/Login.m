//
//  Login.m
//  Framework_OC
//
//  Created by zilu on 2017/12/9.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import "Login.h"
#import "User.h"
#import "NSObject+ObjectMap.h"

static User *currentUser;

@implementation Login

- (instancetype)init{
    if (self = [super init]) {
        self.remember_me = [NSNumber numberWithBool:YES];
        self.email = @"";
        self.password = @"";
    }
    return self;
}

- (NSDictionary *)toParmas{
    NSMutableDictionary *dic = @{@"acount":self.email,
                          @"password":self.password,
                          @"remember_me":self.remember_me ? @"true" : @"false",
                          }.mutableCopy;
    if (self.captcha.length > 0) {
        dic[@"captcha"] = self.captcha;
    }
    
    return dic;
}

+ (void)doLogin:(NSDictionary *)dic{
    
}

+ (void)doLogout{
    
}

+ (BOOL)isLogin{
    NSNumber *loginStatus = [[NSUserDefaults standardUserDefaults] objectForKey:@"login_status"];
    if (loginStatus.boolValue && [Login currentLoginUser]) {
        User *user = [Login currentLoginUser];
        if (user.status && user.status.integerValue == 0) {
            return NO;
        }
        return YES;
    }
    return NO;
}

+ (User *)currentLoginUser{
    if (!currentUser) {
        NSDictionary *loginData = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_dic"];
        currentUser = loginData ? [User initWithDic:loginData] : nil;
    }
    
    return currentUser;
}

@end
