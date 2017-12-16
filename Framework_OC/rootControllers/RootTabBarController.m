//
//  RootTabBarController.m
//  Framework_OC
//
//  Created by zilu on 2017/12/9.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import "RootTabBarController.h"
#import "Mine_RootViewController.h"
#import "Message_RootViewController.h"
#import "Task_RootViewController.h"
#import "Project_RootViewController.h"
#import "Tweet_RootViewController.h"
#import "BaseNavigationController.h"
#import <ReactiveObjC.h>
#import <RDVTabBarItem.h>

@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViewControllers];
}

- (void)setupViewControllers{
    Project_RootViewController *projectVC = [[Project_RootViewController alloc] init];
//    RAC(projectVC,rdv_tabBarItem.badgeValue) = [RACSignal combineLatest:RACObserve(unread, <#KEYPATH#>) reduce:^id _Nullable{
//        <#code#>
//    }];
    UINavigationController *nav_project = [[BaseNavigationController alloc] initWithRootViewController:projectVC];
    
    Task_RootViewController *taskVC = [[Task_RootViewController alloc] init];
    UINavigationController *nav_task = [[BaseNavigationController alloc] initWithRootViewController:taskVC];
    
    Tweet_RootViewController *tweetVC = [[Tweet_RootViewController alloc] init];
    UINavigationController *nav_tweet = [[BaseNavigationController alloc] initWithRootViewController:tweetVC];
    
    Message_RootViewController *messageVC = [[Message_RootViewController alloc] init];
    UINavigationController *nav_message = [[BaseNavigationController alloc] initWithRootViewController:messageVC];
    
    Mine_RootViewController *mineVC = [[Mine_RootViewController alloc] init];
    UINavigationController *nav_mine = [[BaseNavigationController alloc] initWithRootViewController:mineVC];
    
    [self setViewControllers:@[nav_project,nav_task,nav_tweet,nav_message,nav_mine]];
    [self customizeTabBarForController];
    self.delegate = self;
}

- (void)customizeTabBarForController{
    UIImage *backgroundImage = [UIImage imageWithColor:[UIColor colorWithHexString:@"0xFFFFFF" alpha:1.0]];
    NSArray *itemImages = @[@"project",@"task",@"tweet",@"privatemessage",@"me"];
    NSArray *itemTitles = @[@"项目",@"任务",@"冒泡",@"消息",@"我"];
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        item.titlePositionAdjustment = UIOffsetMake(0, 3);//title上下移动
        [item setBackgroundSelectedImage:backgroundImage withUnselectedImage:backgroundImage];
        UIImage *selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",itemImages[index]]];
        UIImage *unselectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",itemImages[index]]];
        [item setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:unselectedImage];
        [item setTitle:itemTitles[index]];
        index ++ ;
    }
    
    [self.tabBar addLineUpOrDown:YES color:[UIColor colorWithHexString:@"0xD8DDE4"]];
}

- (BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
