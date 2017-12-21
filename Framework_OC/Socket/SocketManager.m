//
//  SocketManager.m
//  Framework_OC
//
//  Created by 蚂蚁 on 2017/12/21.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import "SocketManager.h"
#import <GCDAsyncSocket.h>

@interface SocketManager()<GCDAsyncSocketDelegate>

@property (nonatomic,strong) GCDAsyncSocket *socket;
@property (nonatomic,strong) NSTimer *timer;//断开重连定时器
@property (nonatomic,assign) NSInteger reconnectCount;//重连次数

@end

@implementation SocketManager

+ (instancetype)shareManager{
    
    static id manager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[SocketManager alloc] init];
    });
    
    return manager;
}

- (void)connectToService{
    NSLog(@"======开始连接");
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    //连接
    NSError *error = nil;
    [self.socket connectToHost:HOST onPort:PORT error:&error];
    if (error) {
        NSLog(@"连接失败:%@",error);
    }
}

- (GCDAsyncSocket *)socket{
    if (!_socket) {
        _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];//dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)  dispatch_get_main_queue() 指定在主线程还是分线程
    }
    return _socket;
}

- (void)sendDataToService:(id)object{
    NSData *data = [object dataUsingEncoding:NSUTF8StringEncoding];
    
    //发送
    [self.socket writeData:data withTimeout:-1 tag:1];
    //读取
    [self.socket readDataWithTimeout:-1 tag:200];
}
/*
 timeOut:超时时间
 tag:发送和接受数据的tag一定不能设置一样；
 tag相当于一个通道，并且在这个通道中只能完成一件事；
*/

//连接成功
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"======连接成功");
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
        self.reconnectCount = 0;
    }
    
    //添加心跳包(定时器，定时发送)
    
}

//连接失败、连接断开
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    NSLog(@"======连接失败");
    if (err) {
        NSLog(@"连接失败：%@",err);
        //重连次数、间隔时间
        self.reconnectCount ++;
        //需要判断是在前台断开还是后台断开（不重连），分别处理不同的场景
//        if (!self.timer) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:self.reconnectCount target:self selector:@selector(connectToService) userInfo:nil repeats:NO];
            [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];//在子线程中需要添加，不然不执行
//        }
    }else{
        NSLog(@"正常断开");
    }
}

//数据发送成功
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"======发送数据");
    
    [sock readDataWithTimeout:-1 tag:tag];
}

//读取数据
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
//    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"======收到数据");
    if (self.receiveBlock) {
//        dispatch_sync(dispatch_get_main_queue(), ^{
            self.receiveBlock(data);
//        });
//
//        dispatch_async(<#dispatch_queue_t  _Nonnull queue#>, <#^(void)block#>)
    }
    
    //必须实现
    [self.socket readDataWithTimeout:-1 tag:200];
}

- (void)disconnectFromService{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
        self.reconnectCount = 0;
    }
    [self.socket disconnect];
}



@end
