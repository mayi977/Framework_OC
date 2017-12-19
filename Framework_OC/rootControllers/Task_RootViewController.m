//
//  Task_RootViewController.m
//  Framework_OC
//
//  Created by zilu on 2017/12/9.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import "Task_RootViewController.h"
//#import <iCarousel.h>

#define sengmentControl_height 44.0
@interface Task_RootViewController ()

//@property (nonatomic,strong) iCarousel *icarousel;
@property (nonatomic,strong) NSArray *titles;

@end

@implementation Task_RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"任务";
    self.titles = @[@"全部任务",@"当前任务"];
    [self setupNavRightItem];
    [self setTopView];
}

- (void)setupNavRightItem{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClicked:)];
}

- (void)setTopView{
//    self.icarousel = ({
//        iCarousel *icarousel = [[iCarousel alloc] initWithFrame:CGRectZero];
//        icarousel.delegate = self;
//        icarousel.dataSource = self;
//        icarousel.decelerationRate = 1.0;
//        icarousel.scrollSpeed = 1.0;
//        icarousel.type = iCarouselTypeLinear;
//        icarousel.pagingEnabled = YES;
//        icarousel.clipsToBounds = YES;
//        icarousel.bounceDistance = 0.2;
//        [self.view addSubview:icarousel];
//        [icarousel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(sengmentControl_height, 0, 0, 0));
//        }];
//
//        icarousel;
//    });
//
//    __weak typeof weakSelf = self;
//    self.
}

- (void)rightItemClicked:(id)sender{
    
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
