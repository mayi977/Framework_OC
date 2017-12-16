//
//  Login.h
//  Framework_OC
//
//  Created by zilu on 2017/12/9.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Login : NSObject

@property (nonatomic,strong) NSString *email,*password,*captcha;//captcha:验证码
@property (nonatomic,strong) NSNumber *remember_me;

+ (BOOL)isLogin;
+ (void)doLogin:(NSDictionary *)dic;
+ (void)doLogout;
+ (User *)currentLoginUser;

- (NSDictionary *)toParmas;

@end
