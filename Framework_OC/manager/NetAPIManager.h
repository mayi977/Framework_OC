//
//  NetAPIManager.h
//  Framework_OC
//
//  Created by 蚂蚁 on 2017/12/14.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetAPIManager : NSObject

#pragma mark login
- (void)request_login:(NSString *)code block:(Block)block;

@end
