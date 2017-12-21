//
//  SocketManager.h
//  Framework_OC
//
//  Created by 蚂蚁 on 2017/12/21.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SocketManager : NSObject

@property (nonatomic,copy) void(^receiveBlock)(id data);

+ (instancetype)shareManager;
- (void)connectToService;
- (void)sendDataToService:(id)object;
- (void)disconnectFromService;

@end
