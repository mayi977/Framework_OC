//
//  NSObject+Common.h
//  Framework_OC
//
//  Created by zilu on 2017/12/9.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Common)

+ (NSString *)baseUrlStr;
- (id)handleResponse:(id)responseJson;
- (id)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError;

@end
