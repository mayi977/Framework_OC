//
//  RegisterViewController.m
//  Framework_OC
//
//  Created by zilu on 2017/12/9.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import "RegisterViewController.h"
#import <TPKeyboardAvoidingTableView.h>
#import "Register.h"
#import "Input_OnlyText_Cell.h"
#import "UIBarButtonItem+Common.h"
#import <TTTAttributedLabel.h>

#define paddingLeftWidth 18
@interface RegisterViewController ()<UITableViewDelegate,UITableViewDataSource,TTTAttributedLabelDelegate>

@property (nonatomic,strong) Register *myRegister;
@property (nonatomic,strong) TPKeyboardAvoidingTableView *tableView;
@property (nonatomic,strong) UIButton *registerBtn;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"注册";
    _tableView = ({
        TPKeyboardAvoidingTableView *tableview = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [tableview registerClass:[Input_OnlyText_Cell class] forCellReuseIdentifier:cellInentifier_name];
        [tableview registerClass:[Input_OnlyText_Cell class] forCellReuseIdentifier:cellInentifier_phone];
        [tableview registerClass:[Input_OnlyText_Cell class] forCellReuseIdentifier:cellInentifier_psw];
        [tableview registerClass:[Input_OnlyText_Cell class] forCellReuseIdentifier:cellInentifier_code];
        [tableview registerClass:[Input_OnlyText_Cell class] forCellReuseIdentifier:cellInentifier_email];
        tableview.backgroundColor = [UIColor colorWithHexString:@"0xf2f4f6"];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.view addSubview:tableview];
        [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        tableview.estimatedRowHeight = 0;
        tableview.estimatedSectionFooterHeight = 0;
        tableview.estimatedSectionHeaderHeight = 0;
        
        tableview;
    });
    
    [self setupNavigationBackItem];
    _tableView.tableHeaderView = [self customHeaderView];
    _tableView.tableFooterView = [self customFooterView];
    [self configBottomView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (UIView *)customHeaderView{
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0.15*kScreen_Height)];
    headerV.backgroundColor = [UIColor clearColor];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 50)];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:18];
    headerLabel.textColor = [UIColor colorWithHexString:@"0x222222"];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.text = @"加入Coding，体验云端开发之美！";
    [headerLabel setCenter:headerV.center];
    [headerV addSubview:headerLabel];
    return headerV;
}

- (UIView *)customFooterView{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 150)];
    _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _registerBtn.frame = CGRectMake(paddingLeftWidth, 20, kScreen_Width - paddingLeftWidth*2, 45);
    _registerBtn.layer.masksToBounds = YES;
    _registerBtn.layer.cornerRadius = 45/2.0;
    [_registerBtn setBackgroundImage:[UIImage imageWithColor:[UIColor purpleColor] withBounds:footerView.bounds] forState:UIControlStateDisabled];
    [_registerBtn setBackgroundImage:[UIImage imageWithColor:[UIColor redColor] withBounds:footerView.bounds] forState:UIControlStateNormal];
    [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_registerBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:_registerBtn];
    
    RAC(self, registerBtn.enabled) = [RACSignal combineLatest:@[RACObserve(self, myRegister.name),
                                                                RACObserve(self, myRegister.email),
                                                                RACObserve(self, myRegister.password),
                                                                RACObserve(self, myRegister.code),
                                                                RACObserve(self, myRegister.phone),] reduce:^id(NSString *name,
                                                                    NSString *email,
                                                                    NSString *phone,
                                                                    NSString *password,
                                                                    NSString *code){
                                                                    return @(name.length > 0 && phone.length > 0 && password.length > 0 && code.length > 0);
                                                                }];
    
    TTTAttributedLabel *label = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(paddingLeftWidth, CGRectGetMidY(_registerBtn.bounds) + CGRectGetHeight(_registerBtn.bounds) + 10, kScreen_Width - paddingLeftWidth*2, 20)];
//    label.backgroundColor = [UIColor blueColor];
    label.textColor = [UIColor colorWithHexString:@"0x999999"];
    label.textAlignment = 1;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    //enabledTextCheckingTypes要放在text, with either setText: or setText:afterInheritingLabelAttributesAndConfiguringWithBlock:前面才有效.
    label.enabledTextCheckingTypes = NSTextCheckingTypePhoneNumber | NSTextCheckingTypeAddress | NSTextCheckingTypeLink;
    //链接正常状态文本属性
    label.linkAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],NSUnderlineStyleAttributeName:@(0)};
    //    NSUnderlineStyleAttributeName:@(0) 0:没有下划线   1：有下划线
    //链接高亮状态文本属性
    label.activeLinkAttributes = @{NSForegroundColorAttributeName:[UIColor redColor],NSUnderlineStyleAttributeName:@(1)};
    
    label.delegate = self;
    NSString *str = @"注册就代表您已经同意《协议》";
    label.text = str;
    [label addLinkToTransitInformation:@{@"actionStr":@"gotoHtmlView"} withRange:[str rangeOfString:@"《协议》"]];
    
    
    [footerView addSubview:label];
    
    return footerView;
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTransitInformation:(NSDictionary *)components{
    NSLog(@"aefjaslhdflashflaksjdflkjdsfsd");
}

- (void)configBottomView{
    
}

- (void)loginBtnClicked:(id)sender{
    NSLog(@"asdfafaysfsayfasdf");
}

- (void)setupNavigationBackItem{
    if (self.navigationController.childViewControllers.count <= 1) {
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"取消" target:self action:@selector(dismissItem:)];
    }
}

- (void)dismissItem:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *idnetifier = indexPath.row == 0 ? cellInentifier_name : indexPath.row == 1 ? cellInentifier_phone : indexPath.row == 2 ? cellInentifier_psw : indexPath.row == 3 ? cellInentifier_code : cellInentifier_email;
    Input_OnlyText_Cell *cell = [tableView dequeueReusableCellWithIdentifier:idnetifier forIndexPath:indexPath];
    __weak typeof(self) weakSelf = self;
    if (indexPath.row == 0) {
        //name
        [cell setPlaceholder:@"用户名" value:self.myRegister.name];
        cell.textValueChangedBlock = ^(NSString *text) {
            weakSelf.myRegister.name = text;
        };
    }else if (indexPath.row == 1){
        //phone
        [cell setPlaceholder:@"手机号" value:self.myRegister.phone];
        cell.textValueChangedBlock = ^(NSString *text) {
            weakSelf.myRegister.phone = text;
        };
        cell.countryBtnClicked = ^{
            NSLog(@"ahfkasfiasf");
        };
    }else if (indexPath.row == 2){
        //password
        [cell setPlaceholder:@"设置密码" value:self.myRegister.password];
        cell.textValueChangedBlock = ^(NSString *text) {
            weakSelf.myRegister.password = text;
        };
    }else if (indexPath.row == 3){
        //code
        [cell setPlaceholder:@"手机验证码" value:self.myRegister.code];
        cell.textValueChangedBlock = ^(NSString *text) {
            weakSelf.myRegister.code = text;
        };
        cell.codeBtnClicked = ^(PhoneCodeButton *codeBtn) {
            [weakSelf codeButtonClicked:codeBtn];
        };
    }else if (indexPath.row == 4){
        //email
        [cell setPlaceholder:@"邮箱（选填）" value:self.myRegister.email];
        cell.textValueChangedBlock = ^(NSString *text) {
            weakSelf.myRegister.email = text;
        };
    }
    return cell;
}

- (void)codeButtonClicked:(PhoneCodeButton *)btn{
    if (![self.myRegister.phone isPhoneNum]) {
        //提示框
        return;
    }
    [btn startUpTimer];
}

- (Register *)myRegister{
    if (!_myRegister) {
        _myRegister = [Register new];
    }
    
    return _myRegister;
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
