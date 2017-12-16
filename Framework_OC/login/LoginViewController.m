//
//  LoginViewController.m
//  Framework_OC
//
//  Created by zilu on 2017/12/9.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "Login.h"
#import <TPKeyboardAvoidingTableView.h>
#import "Input_OnlyText_Cell.h"

@interface LoginViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) Login *login;
@property (nonatomic,strong) TPKeyboardAvoidingTableView *tableView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.bounds = CGRectMake(0, 0, 100, 40);
//    btn.center = self.view.center;
//    btn.backgroundColor = [UIColor redColor];
//    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
    self.tableView = ({
        TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [tableView registerClass:[Input_OnlyText_Cell class] forCellReuseIdentifier:@"cell"];
//        tableView.backgroundView
        tableView.backgroundColor = [UIColor blueColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        tableView.estimatedRowHeight = 0;//估算高度
        tableView.estimatedSectionFooterHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        
        tableView;
    });
    
    self.tableView.tableHeaderView = [self customHeaderView];
    self.tableView.tableFooterView = [self customFooterView];
    [self showDismissBtn];
}

- (UIView *)customHeaderView{
    return nil;
}

- (UIView *)customFooterView{
    return nil;
}

- (void)showDismissBtn{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
}

- (Login *)login{
    if (!_login) {
        _login = [[Login alloc] init];
    }
    return _login;
}

- (void)btnClicked{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] setupTabBarController];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
