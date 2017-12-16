//
//  NSObject+ObjectMap.h
//  Framework_OC
//
//  Created by zilu on 2017/12/9.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ObjectMap)

+ (id)objectOfClass:(NSString *)object fromJSON:(NSDictionary *)dic;

@end
