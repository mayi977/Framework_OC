//
//  Knowledge.h
//  Framework_OC
//
//  Created by zilu on 2017/12/9.
//  Copyright © 2017年 zilu. All rights reserved.
//

#ifndef Knowledge_h
#define Knowledge_h
#endif /* Knowledge_h */

/*
 instancesRespondToSelector() 和 respondsToSelector() ：
 instancesRespodToSelector() 是一个类方法，用来判断该类的实例（对象）是否响应某个方法
 respondsToSelector() 是一个实例方法，从来判断该实例是否响应某个方法
 instancesRespondToSelector() 只能写在类名后面，判断的是该类的实例是否响应某个方法；respondsToSelector() 可以写在类名（判断是否包含某类方法）和实例后面（判断该实例是否响应某个方法）；
 
 
 类簇：是Foundation框架中广泛使用的设计模式。类簇将一些私有的、具体的子类组合在一个公共的、抽象的超类下面，以这种方法来组织类可以简化一个面向对象框架的公开架构，而又不减少功能的丰富性。
 NSScanner：（是一个类簇，NSScanner只是其中的一个公开类）
 用来在字符串中扫描指定的字符，尤其是把它们翻译/转换成指定的数字和别的字符串；
 
 
 输入框光标
 [[UITextField appearance] setTintColor:[UIColor colorWithHexString:@"0x2EBE76"]];//光标颜色
 [[UITextView appearance] setTintColor:[UIColor colorWithHexString:@"0x2EBE76"]];//光标颜色
 [[UISearchBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"0xF2F4F6"]] forBarPosition:0 barMetrics:UIBarMetricsDefault];
 
 userAgent(用户代理):是一个特殊的服务头，使得服务器能够识别客服使用的操作系统及版本、CPU类型、浏览器及版本、浏览器语言、浏览器插件等；
 
 
 NSUserDefaults相关：
 [[NSUserDefaults standardUserDefaults] registerDefaults:dic];
 registerDefaults：仅仅是定义一组默认的数据，这些默认的数据是不会保存到plist文件中的，需要手动变更这些数据然后保存；
 作用：可以使用这个方法来确认App是否是第一次启动；
 
 
 tableview相关
 estimatedRowHeight：估算高度；
 优点：1，减少heightForRowAtIndexPath的调用次数；2，可以让暂时看不见的cell的高度延时计算；
 缺点：1，contentSize不太确定；滑动过程中，滚动条的长度会变来变去（可能会有跳跃效果）；
 heightForRowAtIndexPath方法的调用时刻：如果没有设置估算高度（estimatedRowHeight），每当reloadData时，有多少条数据就会调用多少次这个方法，每当有cell出现时，就会调用一次这个方法；设置估算高度时（estimatedRowHeight），每当有cell出现时，就会调用一次这个方法；
 
 
 */
