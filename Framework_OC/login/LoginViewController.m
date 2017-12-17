//
//  LoginViewController.m
//  Framework_OC
//
//  Created by zilu on 2017/12/9.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import "LoginViewController.h"
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
    self.login.email = [Login preUserEmail];
    
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
//    CGFloat 
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
    Input_OnlyText_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    __weak typeof(self) weakSelf = self;
    if (indexPath.row == 0) {
        cell.textField.keyboardType = UIKeyboardTypeEmailAddress;
        [cell setPlaceholder:@" 手机号码/电子邮箱/个性后缀" value:self.login.email];
        cell.editDidBeginBlock = ^(NSString *text) {
            //
        };
        cell.textValueChangedBlock = ^(NSString *text) {
            weakSelf.login.email = text;
        };
        cell.editDidEndBlock = ^(NSString *text) {
            //
        };
    }else if (indexPath.row == 1){
        [cell setPlaceholder:@"密码" value:self.login.password];
        cell.textField.secureTextEntry = YES;
        cell.editDidBeginBlock = ^(NSString *text) {
            //
        };
        cell.textValueChangedBlock = ^(NSString *text) {
            weakSelf.login.password = text;
        };
        cell.editDidEndBlock = ^(NSString *text) {
            //
        };
    }
    
    return cell;
}

- (Login *)login{
    if (!_login) {
        _login = [[Login alloc] init];
    }
    return _login;
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
