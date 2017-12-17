//
//  NetAPIClient.m
//  Framework_OC
//
//  Created by 蚂蚁 on 2017/12/14.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import "NetAPIClient.h"

@implementation NetAPIClient

+ (NetAPIClient *)shareManager{
    static NetAPIClient *apiClient = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        apiClient = [[NetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:[NSObject baseUrlStr]]];
    });
    
    return apiClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url{
    if (self = [super initWithBaseURL:url]) {
        self.responseSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
        
        [self.responseSerializer setValue:@"application/json" forKey:@"Accept"];
        [self.responseSerializer setValue:url.absoluteString forKey:@"Referer"];
        
        self.securityPolicy.allowInvalidCertificates = YES;
    }
    
    return self;
}

- (void)setRequestjsonDataWithPath:(NSString *)aPath withParams:(NSDictionary *)params withMethodType:(MethodType)method complation:(Block)block{
    if (!aPath || aPath.length <= 0) {
        return;
    }
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将汉字转码
    if (method == MethodTypeGet) {
        [self GET:aPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //
        }];
    }else if (method == MethodTypePost){
        
    }
}

@end
