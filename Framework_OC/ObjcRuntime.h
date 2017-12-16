//
//  ObjcRuntime.h
//  Framework_OC
//
//  Created by zilu on 2017/12/10.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import <Foundation/Foundation.h>

//根据类名获取类
//系统就提供 NSClassFromString(<#NSString * _Nonnull aClassName#>)

//获取一个类的所有属性名字：类型的名字，具有@property的，父类的获取不了
NSDictionary *GetPropertyListOfObject(NSObject *object);
NSDictionary *GetPropertyListOfClass(Class cls);

//交换方法
void Swizzle(Class c, SEL origSEL, SEL newSEL);

