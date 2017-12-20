//
//  Task_RootViewController.m
//  Framework_OC
//
//  Created by zilu on 2017/12/9.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import "Task_RootViewController.h"
#import "ZLSegmentControl.h"
#import <iCarousel.h>
#import "ZLSegmentView.h"

#define sengmentControl_height 44.0
@interface Task_RootViewController ()<iCarouselDelegate,iCarouselDataSource,ZLSegmentViewDelegat>

@property (nonatomic,strong) iCarousel *icarousel;
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) ZLSegmentControl *segmentControl;

@end

@implementation Task_RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"任务";
    self.titles = @[@"全部任务",@"当前任务",@"全部任务",@"当前任务",@"全部任务",@"当前任务",@"全部任务",@"当前任务",@"全部任务",@"当前任务",@"全部任务",@"当前任务"];
    [self setupNavRightItem];
    [self setTopView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)setupNavRightItem{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClicked:)];
}

- (void)setTopView{
    self.icarousel = ({
        iCarousel *icarousel = [[iCarousel alloc] initWithFrame:CGRectZero];
        icarousel.delegate = self;
        icarousel.dataSource = self;
        icarousel.decelerationRate = 1.0;
        icarousel.scrollSpeed = 1.0;
        icarousel.type = iCarouselTypeLinear;
        icarousel.pagingEnabled = YES;
        icarousel.clipsToBounds = YES;
        icarousel.bounceDistance = 0.2;//
        [self.view addSubview:icarousel];
        [icarousel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(sengmentControl_height, 0, 0, 0));
        }];

        icarousel;
    });

    __weak typeof(self) weakSelf = self;
    self.segmentControl = [[ZLSegmentControl alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 44) contextWidth:kScreen_Width *4 items:self.titles selectedItemBlock:^(NSInteger index) {
        [weakSelf.icarousel scrollToItemAtIndex:index animated:YES];
        
    }];
    [self.view addSubview:self.segmentControl];
    
    ZLSegmentView *itemView = (ZLSegmentView *)self.icarousel.currentItemView;
    NSLog(@"======%@",itemView);
    itemView.dataSource = @[@"全部任务",@"当前任务"];
}

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.titles.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    ZLSegmentView *itemView = (ZLSegmentView *)view;
    if (!itemView) {
        itemView = [[ZLSegmentView alloc] initWithFrame:carousel.bounds];
    }
    itemView.backgroundColor = [UIColor redColor];
    itemView.delegate = self;
//    NSLog(@"%@",NSStringFromCGRect(carousel.bounds));
    
    return itemView;
}

- (void)carouselDidScroll:(iCarousel *)carousel{
    if (_segmentControl) {
        float offset = carousel.scrollOffset;
        if (offset > 0) {
            [_segmentControl moveToOffset:offset];
        }   
    }
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    ZLSegmentView *itemView = (ZLSegmentView *)carousel.currentItemView;
    itemView.dataSource = @[@"sdfafsdf",@"asfasdff",@"asfasdff",@"asfasdff",@"asfasdff"];
}

- (void)startRefreshView:(ZLSegmentView *)view{
    NSLog(@"123456787654323456789");
}

- (void)didSelectedItem:(NSIndexPath *)indexPath{
    NSLog(@"======%ld",(long)indexPath.row);
}

- (void)rightItemClicked:(id)sender{
    NSLog(@"serhgeiuhgresugesuglrsiugf");
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
