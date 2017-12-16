//
//  NSObject+ObjectMap.m
//  Framework_OC
//
//  Created by zilu on 2017/12/9.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import "NSObject+ObjectMap.h"

@implementation NSObject (ObjectMap)

+ (id)objectOfClass:(NSString *)object fromJSON:(NSDictionary *)dic{
    if (!dic || ![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    id newObject = [[NSClassFromString(object) alloc] init];
    NSDictionary *mapDic = [newObject propertyDictionary];
    
    for (NSString *key in [dic allKeys]) {
        NSString *tempKey;
        if ([key isEqualToString:@"description"] || [key isEqualToString:@"hash"]) {
            tempKey = [key stringByAppendingString:@"_mine"];
        }else{
            tempKey = key;
        }
        NSString *propertyName = [mapDic objectForKey:tempKey];
        if (!propertyName) {
            continue;
        }
        
        //dictionary
        if ([[dic objectForKey:key] isKindOfClass:[NSDictionary class]]) {
            NSString *propertyType = [newObject classOfPropertyName:propertyName];
            id nestedObj = [NSObject objectOfClass:propertyType fromJSON:[dic objectForKey:key]];
            [newObject setValue:nestedObj forKey:propertyName];
        }else if ([[dic objectForKey:key] isKindOfClass:[NSArray class]]) {
            //array
//            NSString *
        }
    }
    
    return nil;
}

- (NSString *)classOfPropertyName:(NSString *)propertyName{
    return nil;
}

- (NSDictionary *)propertyDictionary{
    return nil;
}

@end
