//
//  NetAPIClient.h
//  Framework_OC
//
//  Created by 蚂蚁 on 2017/12/14.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface NetAPIClient : AFHTTPSessionManager

+ (NetAPIClient *)shareManager;
- (void)setRequestjsonDataWithPath:(NSString *)path withParams:(NSDictionary *)params withMethodType:(MethodType)method complation:(Block)block;

@end
