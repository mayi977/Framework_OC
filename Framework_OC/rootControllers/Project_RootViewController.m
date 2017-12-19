//
//  Project_RootViewController.m
//  Framework_OC
//
//  Created by zilu on 2017/12/9.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import "Project_RootViewController.h"
//#import <iCarousel.h>
#import <PopMenu.h>

@interface Project_RootViewController ()
//<iCarouselDelegate,iCarouselDataSource>

//@property (nonatomic,strong) iCarousel *icarousel;
//@property (nonatomic,strong) NSArray *segmentItems;
@property (nonatomic,strong) PopMenu *popMenu;

@end

@implementation Project_RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupRightNavItem];
//    self.segmentItems = @[@"",@"",@"",@"",@"",@""];
//    _icarousel = ({
//        iCarousel *icarousel = [[iCarousel alloc] init];
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
//            make.edges.equalTo(self.view);
//        }];
//
//        icarousel;
//    });
    
    NSArray *menuItems = @[
                           [MenuItem initWithTitle:@"项目" iconName:@"pop_Project" index:0],
                           [MenuItem initWithTitle:@"任务" iconName:@"pop_Task" index:1],
                           [MenuItem initWithTitle:@"冒泡" iconName:@"pop_Tweet" index:2],
                           [MenuItem initWithTitle:@"添加好友" iconName:@"pop_User" index:3],
                           [MenuItem initWithTitle:@"私信" iconName:@"pop_Message" index:4],
                           [MenuItem initWithTitle:@"两步验证" iconName:@"pop_2FA" index:5]
                           ];
    _popMenu = [[PopMenu alloc] initWithFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height - 64) items:menuItems];
    _popMenu.perRowItemCount = 3;
    _popMenu.menuAnimationType = kPopMenuAnimationTypeSina;
    @weakify(self);
    _popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
        @strongify(self);
        if (!selectedItem) {
            return ;
        }
        switch (selectedItem.index) {
            case 0:
                NSLog(@"=======%@",selectedItem.title);
                break;
            case 1:
                NSLog(@"=======%@",selectedItem.title);
                break;
            case 2:
                NSLog(@"=======%@",selectedItem.title);
                break;
            case 3:
                NSLog(@"=======%@",selectedItem.title);
                break;
            case 4:
                NSLog(@"=======%@",selectedItem.title);
                break;
            case 5:
                NSLog(@"=======%@",selectedItem.title);
                break;
                
            default:
                break;
        }
    };
}

//- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
//    return self.segmentItems.count;
//}

- (void)setupRightNavItem{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"addBtn_Nav"] style:UIBarButtonItemStylePlain target:self action:@selector(rightNavItemClicked:)];
}

- (void)rightNavItemClicked:(id)sender{
    if (!_popMenu.isShowed) {
        [_popMenu showMenuAtView:[(AppDelegate *)[UIApplication sharedApplication].delegate window] startPoint:CGPointMake(0, -100) endPoint:CGPointMake(0, -100)];
    }else{
        [_popMenu dismissMenu];
    }
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
