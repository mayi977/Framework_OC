//
//  AppDelegate.m
//  Framework_OC
//
//  Created by zilu on 2017/12/7.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import "AppDelegate.h"
#import <UMessage.h>
#import <UserNotifications/UserNotifications.h>
#import "ViewController.h"
#import "IntroductionViewController.h"
#import "Login.h"
#import "RootTabBarController.h"
#import "LoginViewController.h"
#import "BaseNavigationController.h"

#define _IPHONE80_ 80000
@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    //    [self registerAPNS];//系统
    [self umengAPNS:launchOptions];//友盟
    
    [self customizeInterface];//设置导航条样式
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [self registerUserAgent];
    
    if ([Login isLogin]) {
//        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[UIViewController new]];
        [self setupTabBarController];
    }else{
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        [self showIntroductionViewController];
    }
    
    return YES;
}

- (void)registerUserAgent{
    NSLog(@"%@",NSHomeDirectory());
    NSString *userAgent = [NSString userAgent];
    NSDictionary *dic = @{@"userAgent":userAgent};
    NSLog(@"%@",dic);
    [[NSUserDefaults standardUserDefaults] registerDefaults:dic];
}

//自定义导航条样式
- (void)customizeInterface{
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"0xF3C033"]] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setTintColor:[UIColor colorWithHexString:@"0x2EBE76"]];//返回箭头的颜色
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"0x323A45"]};
    [navigationBar setTitleTextAttributes:dic];
    
    [[UITextField appearance] setTintColor:[UIColor colorWithHexString:@"0x2EBE76"]];//光标颜色
    [[UITextView appearance] setTintColor:[UIColor colorWithHexString:@"0x2EBE76"]];//光标颜色
    [[UISearchBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"0xF2F4F6"]] forBarPosition:0 barMetrics:UIBarMetricsDefault];
}

- (void)setupTabBarController{
    RootTabBarController *rootTBC = [[RootTabBarController alloc] init];
    rootTBC.tabBar.translucent = YES;
    [self.window setRootViewController:rootTBC];
}

- (void)setupLoginViewController{
    LoginViewController *vc = [[LoginViewController alloc] init];
    [self.window setRootViewController:[[BaseNavigationController alloc] initWithRootViewController:vc] ];
}

//引导页
- (void)showIntroductionViewController{
    IntroductionViewController *vc = [[IntroductionViewController alloc] init];
    [self.window setRootViewController:vc];
}

//友盟推送
- (void)umengAPNS:(NSDictionary *)launchOptions{
    [UMessage startWithAppkey:@"5a2964c08f4a9d30810000f5" launchOptions:launchOptions];
    [UMessage registerForRemoteNotifications];
    [UMessage setLogEnabled:YES];//打开日志
    //ios10必须添加
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        UNAuthorizationOptions options = UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound;
        [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
              //点击允许
            }else{
                //点击不允许
            }
        }];
        
//        UNNotificationCategory *category = [UNNotificationCategory];
//        NSSet *categories = [NSSet setWithObject:<#(nonnull id)#>];
    } else {
        // Fallback on earlier versions
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    //不需要手动注册deviceToken，友盟sdk会自动注册
//    [UMessage registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [UMessage setAutoAlert:NO];//关闭upush自带的弹框
    [UMessage didReceiveRemoteNotification:userInfo];
    
    //在次通知需要的类
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"userInfoNotification" object:self userInfo:userInfo];
    
}

//ios10新增：处理前台收到通知的代理方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary *userInfo = notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            //应用处于前台时远程推送接受
            [UMessage setAutoAlert:NO];
            [UMessage didReceiveRemoteNotification:userInfo];//必须添加
        }else{
            ////应用处于前台时本地推送接受
        }
    } else {
        // Fallback on earlier versions
    }
    
    //应用处于前台时提醒设置，需要哪个设置哪个
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound);
    } else {
        // Fallback on earlier versions
    }
    
    //用来做action的统计
    [UMessage sendClickReportForRemoteNotification:userInfo];
    //在下面写identifier对各个交互的按钮进行业务处理
    
    
    //在次通知需要的类
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"userInfoNotification" object:self userInfo:userInfo];
}

//ios10新增：处理后台点击通知的代理方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if ([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            //应用处于后台时远程推送接受
            [UMessage setAutoAlert:NO];
            [UMessage didReceiveRemoteNotification:userInfo];//必须添加
            if ([response.actionIdentifier isEqualToString:@"自定义的action id"]) {
                //
            }else{
                
            }
            //用来做action的统计
            [UMessage sendClickReportForRemoteNotification:userInfo];
        }else{
            ////应用处于后台时本地推送接受
        }
    } else {
        // Fallback on earlier versions
    }
    
    //在次通知需要的类
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"userInfoNotification" object:self userInfo:userInfo];
}

/*
//系统推送
- (void)registerAPNS{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc] init];
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeAlert |UIUserNotificationTypeSound categories:[NSSet setWithObject:category]];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
#else
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge)];
#endif
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken{
    NSString *description = [deviceToken description];
    description = [description stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *token = [description stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSLog(@"%@",token);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"234567890");
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"afhalfhuf");
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    NSLog(@"%@",notificationSettings);
}
*/
 
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
