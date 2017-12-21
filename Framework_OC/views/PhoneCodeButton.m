//
//  PhoneCodeButton.m
//  Framework_OC
//
//  Created by zilu on 2017/12/19.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import "PhoneCodeButton.h"

@interface PhoneCodeButton()

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) NSTimeInterval duration;
@property (nonatomic,strong) UIView *lineView;

@end

@implementation PhoneCodeButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.enabled = YES;
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 0.5, CGRectGetHeight(frame) - 5 * 2)];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"0xd8d8d8"];
        [self addSubview:_lineView];
    }
    
    return self;
}

- (void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    
    if (enabled) {
        [self setTitle:@"发送验证码" forState:UIControlStateNormal];
    }else if ([self.titleLabel.text isEqualToString:@"发送验证码"]){
        [self setTitle:@"正在发送..." forState:UIControlStateNormal];
    }
}

- (void)startUpTimer{
    _duration = 60;
    if (self.enabled) {
        self.enabled = NO;
    }
    [self setTitle:[NSString stringWithFormat:@"%.0f s",_duration] forState:UIControlStateNormal];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)invalidateTimer{
    if (!self.enabled) {
        self.enabled = YES;
    }
    [self.timer invalidate];
    self.timer = nil;
}

- (void)onTimer:(NSTimer *)timer{
    _duration --;
    if (_duration > 0) {
//        self.titleLabel.text = [NSString stringWithFormat:@"%.0f 秒", _duration];//防止 button_title 闪烁
        [self setTitle:[NSString stringWithFormat:@"%.0f s",_duration] forState:UIControlStateNormal];
    }else{
        [self invalidateTimer];
    }
}

@end
