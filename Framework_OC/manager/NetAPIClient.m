//
//  NetAPIClient.m
//  Framework_OC
//
//  Created by 蚂蚁 on 2017/12/14.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import "NetAPIClient.h"

@implementation NetAPIClient

+ (instancetype)shareManager{
    static id apiClient = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        apiClient = [[NetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:[NSObject baseUrlStr]]];
    });
    
    return apiClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url{
    if (self = [super initWithBaseURL:url]) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
        
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
        
        self.securityPolicy.allowInvalidCertificates = YES;
    }
    
    return self;
}

- (void)setRequestjsonDataWithPath:(NSString *)aPath withParams:(NSDictionary *)params showError:(BOOL)show withMethodType:(MethodType)method complation:(Block)block{
    if (!aPath || aPath.length <= 0) {
        return;
    }
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将汉字转码
    if (method == MethodTypeGet) {
        [self GET:aPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            id error = [self handleResponse:responseObject autoShowError:show];
            if (error) {
                block(nil,error);
            }else{
                block(responseObject,nil);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            block(nil,error);
        }];
    }else if (method == MethodTypePost){
        [self POST:aPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            block(responseObject,nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            block(nil,error);
        }];
    }
}

@end
