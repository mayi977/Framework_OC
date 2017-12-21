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
#import "RegisterViewController.h"
#import "NetAPIManager.h"

#define paddingLeftWidth 18.0
@interface LoginViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) Login *login;
@property (nonatomic,strong) TPKeyboardAvoidingTableView *tableView;
@property (nonatomic,strong) UIImageView *iconUserView;
@property (nonatomic,strong) UIButton *loginBtn,*cannotLoginBtn,*dismissBtn;
@property (nonatomic,strong) UIView *bottomView;

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
    [self configBottomView];
}

- (UIView *)customHeaderView{
    CGFloat iconUserViewWidth;
    if (kDevice_Is_iPhone6Plus) {
        iconUserViewWidth = 100;
    }else if (kDevice_Is_iPhone6){
        iconUserViewWidth = 90;
    }else{
        iconUserViewWidth = 75;
    }
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height/3.0)];
    _iconUserView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iconUserViewWidth, iconUserViewWidth)];
    _iconUserView.contentMode = UIViewContentModeScaleAspectFit;
    _iconUserView.layer.masksToBounds = YES;
    _iconUserView.layer.cornerRadius = iconUserViewWidth/2.0;
    _iconUserView.layer.borderWidth = 2;
    _iconUserView.layer.borderColor = [UIColor whiteColor].CGColor;
    [headerView addSubview:_iconUserView];
    [_iconUserView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(iconUserViewWidth, iconUserViewWidth));
        make.centerX.equalTo(headerView);
        make.centerY.equalTo(headerView).offset(30);
    }];
    
    _iconUserView.backgroundColor = [UIColor orangeColor];
//    headerView.backgroundColor = [UIColor redColor];
    
    return headerView;
}

- (UIView *)customFooterView{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 150)];
//    footerView.backgroundColor = [UIColor redColor];
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.frame = CGRectMake(paddingLeftWidth, 20, kScreen_Width - paddingLeftWidth*2, 45);
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.cornerRadius = 45/2.0;
    [_loginBtn setBackgroundImage:[UIImage imageWithColor:[UIColor purpleColor] withBounds:_loginBtn.bounds] forState:UIControlStateDisabled];
    [_loginBtn setBackgroundImage:[UIImage imageWithColor:[UIColor redColor] withBounds:_loginBtn.bounds] forState:UIControlStateNormal];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:_loginBtn];
    
    //自动检测输入框是否为空，为空则按钮不可点击
    RAC(self,loginBtn.enabled) = [RACSignal combineLatest:@[RACObserve(self, login.email),
                                                            RACObserve(self, login.password)]
                                                   reduce:^id(NSString *email,
                                                              NSString *password){
                                                       BOOL isValid = (email && email.length > 0) && (password && password.length > 0);
                                                       return @(isValid);
                                                   }];
    
    _cannotLoginBtn = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithWhite:0.5 alpha:0.5] forState:UIControlStateHighlighted];
        
        [button setTitle:@"找回密码" forState:UIControlStateNormal];
        [footerView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 30));
            make.centerX.equalTo(footerView);
            make.top.equalTo(_loginBtn.mas_bottom).offset(20);
        }];
        button;
    });
    [_cannotLoginBtn addTarget:self action:@selector(cannotLoginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return footerView;
}

- (void)showDismissBtn{
    if (!_dismissBtn) {
        _dismissBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 50, 50)];
        [_dismissBtn setImage:[UIImage imageNamed:@"dismissBtn_Nav"] forState:UIControlStateNormal];
        [_dismissBtn addTarget:self action:@selector(dismissButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_dismissBtn];
    }
}

- (void)configBottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreen_Height - 55, kScreen_Width, 55)];
//        _bottomView.backgroundColor = [UIColor orangeColor];
        
        UIButton *registerBtn = ({
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
            [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [button setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithWhite:0.5 alpha:0.5] forState:UIControlStateHighlighted];
            
            [button setTitle:@"去注册" forState:UIControlStateNormal];
            [_bottomView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(100, 30));
                make.centerX.equalTo(_bottomView);
                make.top.equalTo(_bottomView);
            }];
            button;
        });
        [registerBtn addTarget:self action:@selector(goRegisterVC:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_bottomView];
    }
}

- (void)loginBtnClicked:(id)sender{
     [self.view endEditing:YES];
    
    [[NetAPIManager shareManager] request_login:self.login.code block:^(id data, NSError *error) {
        if (error) {
            //展示错误信息
        }else{
            [(AppDelegate *)[UIApplication sharedApplication].delegate setupTabBarController];
        }
    }];
}

- (void)cannotLoginBtnClicked:(id)sender{
    NSLog(@"=-=-=-=-=--=-=-=-");
}

- (void)dismissButtonClicked:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)goRegisterVC:(id)sender{
    RegisterViewController *vc = [RegisterViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
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

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
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
