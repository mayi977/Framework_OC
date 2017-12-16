//
//  NSString+Common.m
//  Framework_OC
//
//  Created by zilu on 2017/12/9.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import "NSString+Common.h"
#import <sys/utsname.h>

@implementation NSString (Common)

+ (NSString *)userAgent{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    
    NSString *userAgent = [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)",[info objectForKey:(__bridge NSString *)kCFBundleExecutableKey] ?: [info objectForKey:(__bridge NSString *)kCFBundleIdentifierKey],(__bridge id)CFBundleGetValueForInfoDictionaryKey(CFBundleGetMainBundle(), kCFBundleVersionKey) ?: [info objectForKey:(__bridge NSString *)kCFBundleVersionKey],deviceString,[[UIDevice currentDevice] systemVersion],([[UIScreen mainScreen] respondsToSelector:@selector(scale)] ? [[UIScreen mainScreen] scale] : 1.0f)];
    
    return userAgent;
}

@end
