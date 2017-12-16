//
//  IntroductionViewController.m
//  Framework_OC
//
//  Created by zilu on 2017/12/9.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import "IntroductionViewController.h"
#import "UIImage+Resizing.h"
#import "Masonry.h"
#import "SMPageControl.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface IntroductionViewController ()

@property (nonatomic,strong) NSMutableDictionary *iconsDic, *tipsDic;
@property (nonatomic,strong) UIButton *registerBtn, *loginBtn;
@property (nonatomic,strong) SMPageControl *pageControl;

@end

@implementation IntroductionViewController

- (instancetype)init{
    if (self = [super init]) {
        self.numberOfPages = 7;
        _iconsDic = [@{
                       @"0_image" : @"intro_icon_6",
                       @"1_image" : @"intro_icon_0",
                       @"2_image" : @"intro_icon_1",
                       @"3_image" : @"intro_icon_2",
                       @"4_image" : @"intro_icon_3",
                       @"5_image" : @"intro_icon_4",
                       @"6_image" : @"intro_icon_5",
                       } mutableCopy];
        
        _tipsDic = [@{
                      @"1_image" : @"intro_tip_0",
                      @"2_image" : @"intro_tip_1",
                      @"3_image" : @"intro_tip_2",
                      @"4_image" : @"intro_tip_3",
                      @"5_image" : @"intro_tip_4",
                      @"6_image" : @"intro_tip_5",
                      } mutableCopy];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"0xf1f1f1"];
    
    [self configureViews];
    [self configureAnimations];
}

- (void)configureViews{
    [self configureButtonsAndPageControl];
    
    CGFloat scaleFactor = 1.0;
    CGFloat designHeight = 667.0;
    if (!kDevice_Is_iPhone6 && !kDevice_Is_iPhone6Plus && !kDevice_Is_iPhoneX) {
        scaleFactor = kScreen_Height / designHeight;
    }
    
    for (int i = 0; i < self.numberOfPages; i ++) {
        NSString *imageKey = [NSString stringWithFormat:@"%d_image",i];
        NSString *viewKey = [NSString stringWithFormat:@"%d_view",i];
        NSString *iconImageName = [self.iconsDic objectForKey:imageKey];
        NSString *tipImageName = [self.tipsDic objectForKey:imageKey];
        
        if (iconImageName) {
            UIImage *iconImage = [UIImage imageNamed:iconImageName];
            if (iconImage) {
                iconImage = scaleFactor != 1.0 ? [iconImage scaleByFactor:scaleFactor] : iconImage;
                UIImageView *iconView = [[UIImageView alloc] initWithImage:iconImage];
                [self.contentView addSubview:iconView];
                [self.iconsDic setObject:iconView forKey:viewKey];
            }
        }
        
        if (tipImageName) {
            UIImage *tipImage = [UIImage imageNamed:tipImageName];
            if (tipImage) {
                tipImage = scaleFactor != 1.0 ? [tipImage scaleByFactor:scaleFactor] : tipImage;
                UIImageView *tipView = [[UIImageView alloc] initWithImage:tipImage];
                [self.contentView addSubview:tipView];
                [self.tipsDic setObject:tipView forKey:viewKey];
            }
        }
    }
}

- (void)configureButtonsAndPageControl{
    CGFloat buttonWidth = kScreen_Width * 0.4;
    CGFloat buttonHeight = kScaleFrom_iPhone5_Desgin(38);
    CGFloat paddingToCenter = kScaleFrom_iPhone5_Desgin(10);
    CGFloat paddingToBottom = kScaleFrom_iPhone5_Desgin(20);
    
    self.registerBtn = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(registerBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        
        button.backgroundColor = [UIColor colorWithHexString:@"0x2EBE76"];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:@"注册" forState:UIControlStateNormal];
        
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = buttonHeight/2;
        
        button;
    });
    
    self.loginBtn = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(loginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        
        button.backgroundColor = [UIColor clearColor];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [button setTitleColor:[UIColor colorWithHexString:@"0x2EBE76"] forState:UIControlStateNormal];
        [button setTitle:@"登录" forState:UIControlStateNormal];
        
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = buttonHeight/2;
        button.layer.borderWidth = 1.0;
        button.layer.borderColor = [UIColor colorWithHexString:@"0x2EBE76"].CGColor;
        button;
    });
    
    [self.view addSubview:self.registerBtn];
    [self.view addSubview:self.loginBtn];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonHeight));
        make.right.equalTo(self.view.mas_centerX).with.offset(-paddingToCenter);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-paddingToBottom);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonHeight));
        make.left.equalTo(self.view.mas_centerX).with.offset(paddingToCenter);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-paddingToBottom);
    }];
    
    UIImage *pageIndicatorImage = [UIImage imageNamed:@"intro_dot_unselected"];
    UIImage *currentPageIndicatorImage = [UIImage imageNamed:@"intro_dot_selected"];
    
    if (!kDevice_Is_iPhone6 && !kDevice_Is_iPhone6Plus && !kDevice_Is_iPhoneX) {
        CGFloat designWidth = 375.0;
        CGFloat scaleFactor = kScreen_Width / designWidth;
        pageIndicatorImage = [pageIndicatorImage scaleByFactor:scaleFactor];
        currentPageIndicatorImage = [currentPageIndicatorImage scaleByFactor:scaleFactor];
    }
    
    self.pageControl = ({
        SMPageControl *pageControl = [[SMPageControl alloc] init];
        pageControl.numberOfPages = self.numberOfPages;
        pageControl.userInteractionEnabled = NO;
        pageControl.pageIndicatorImage = pageIndicatorImage;
        pageControl.currentPageIndicatorImage = currentPageIndicatorImage;
        [pageControl sizeToFit];
        pageControl.currentPage = 0;
        pageControl;
    });
    [self.view addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width, kScaleFrom_iPhone5_Desgin(20)));
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.registerBtn.mas_top).with.offset(-kScaleFrom_iPhone5_Desgin(20));
    }];
}

- (void)configureAnimations{
    [self configureTipAndTitleViewAnimations];
}

- (void)configureTipAndTitleViewAnimations{
    for (int i = 0; i < self.numberOfPages; i ++) {
        NSString *viewKey = [NSString stringWithFormat:@"%d_view",i];
        UIView *iconView = [self.iconsDic objectForKey:viewKey];
        UIView *tipView = [self.tipsDic objectForKey:viewKey];
        
        if (iconView) {
            if (i == 0) {
                [self keepView:iconView onPages:@[@(i + 1),@(i)] atTimes:@[@(i - 1),@(i)]];
                [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(kScreen_Height / 7.0);
                }];
            }else{
                [self keepView:iconView onPage:i];
                [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(kScreen_Height / 6.0);
                }];
            }
            
            IFTTTAlphaAnimation *iconAnimation = [IFTTTAlphaAnimation animationWithView:iconView];
            [iconAnimation addKeyframeForTime:i - 0.5 alpha:0.f];
            [iconAnimation addKeyframeForTime:i alpha:1.0f];
            [iconAnimation addKeyframeForTime:i + 0.5 alpha:0.f];
            [self.animator addAnimation:iconAnimation];
        }
        
        if (tipView) {
            [self keepView:tipView onPages:@[@(i + 1),@(i),@(i - 1)] atTimes:@[@(i - 1),@(i),@(i + 1)]];
            
            IFTTTAlphaAnimation *iconAnimation = [IFTTTAlphaAnimation animationWithView:tipView];
            [iconAnimation addKeyframeForTime:i - 0.5 alpha:0.f];
            [iconAnimation addKeyframeForTime:i alpha:1.0f];
            [iconAnimation addKeyframeForTime:i + 0.5 alpha:0.f];
            [self.animator addAnimation:iconAnimation];
            
            [tipView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(iconView.mas_bottom).with.offset(kScaleFrom_iPhone5_Desgin(45));
            }];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)registerBtnClicked{
    RegisterViewController *vc = [[RegisterViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)loginBtnClicked{
    LoginViewController *vc = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self animateCurrentFrame];
    NSInteger nearestPage = floorf(self.pageOffset + 0.5);
    self.pageControl.currentPage = nearestPage;
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
