//
//  ObjcRuntime.m
//  Framework_OC
//
//  Created by zilu on 2017/12/10.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import "ObjcRuntime.h"
#import <objc/runtime.h>

NSDictionary *GetPropertyListOfObject(NSObject *object){
    return GetPropertyListOfClass([object class]);
}

NSDictionary *GetPropertyListOfClass(Class cls){
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList(cls, &outCount);
    for (int i = 0; i < outCount; i ++) {
        objc_property_t property = properties[i];
        const char *propertyName = property_getName(property);
        const char *propertyType = property_getAttributes(property);
        if (propertyName && propertyType) {
            NSArray *anAttribute = [[NSString stringWithUTF8String:propertyType] componentsSeparatedByString:@","];
            NSString *aType = anAttribute[0];
            //暂时不能去掉前缀T@\"和后缀"，需要用以区分标量与否
            //            if ([aType hasPrefix:@"T@\""]) {
            //                aType = [aType substringWithRange:NSMakeRange(3, [aType length]-4)];
            //            }else{
            //                aType = [aType substringFromIndex:1];
            //            }
            [dict setObject:aType forKey:[NSString stringWithUTF8String:propertyName]];
        }
    }
    
    free(properties);
    
    return dict;
}

void Swizzle(Class c, SEL origSEL, SEL newSEL){
    Method origMethod = class_getInstanceMethod(c, origSEL);
    Method newMethod = nil;
    if (!origMethod) {
        origMethod = class_getClassMethod(c, origSEL);
        if (!origMethod) {
            return;
        }
        newMethod = class_getClassMethod(c, newSEL);
        if (!newMethod) {
            return;
        }
    }else{
        newMethod = class_getInstanceMethod(c, newSEL);
        if (!newMethod) {
            return;
        }
    }
    
    //自身已经有了就添加不成功，直接交换即可
    if (class_addMethod(c, origSEL, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(c, newSEL, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }else{
        method_exchangeImplementations(origMethod, newMethod);
    }
}

