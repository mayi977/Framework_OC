//
//  User.m
//  Framework_OC
//
//  Created by zilu on 2017/12/9.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import "User.h"
#import "MJExtension.h"

@implementation User

+ (instancetype)initWithDic:(NSDictionary *)dic{
    return [User mj_objectWithKeyValues:dic];
}

@end
