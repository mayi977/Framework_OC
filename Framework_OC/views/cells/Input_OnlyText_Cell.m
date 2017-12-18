//
//  Input_OnlyText_Cell.m
//  Framework_OC
//
//  Created by 蚂蚁 on 2017/12/15.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import "Input_OnlyText_Cell.h"

#define paddingLeftWidth 18
@interface Input_OnlyText_Cell()

@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UIButton *clearBtn,*pswBtn,*codeBtn;

@end

@implementation Input_OnlyText_Cell

- (void)layoutSubviews{
//    if (!_clearBtn) {
//        _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _clearBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//        [_clearBtn setImage:[UIImage imageNamed:@"text_clear_btn"] forState:UIControlStateNormal];
////        [_clearBtn setBackgroundColor:[UIColor redColor]];
//        [_clearBtn addTarget:self action:@selector(clearBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:_clearBtn];
//        [_clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(CGSizeMake(30, 30));
//            make.right.equalTo(self.contentView).offset(-paddingLeftWidth);
//            make.centerY.equalTo(self.contentView);
//        }];
//    }
//    _clearBtn.hidden = YES;
    
    self.clearBtn.hidden = YES;
    
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"0xffffff" alpha:0.5];
        [self.contentView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.left.equalTo(self.contentView).offset(paddingLeftWidth);
            make.right.equalTo(self.contentView).offset(-paddingLeftWidth);
            make.bottom.equalTo(self.contentView);
        }];
    }
    
    self.textField.textColor = [UIColor whiteColor];
}

- (UIButton *)clearBtn{
    if (!_clearBtn) {
        _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _clearBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_clearBtn setImage:[UIImage imageNamed:@"text_clear_btn"] forState:UIControlStateNormal];
        //        [_clearBtn setBackgroundColor:[UIColor redColor]];
        [_clearBtn addTarget:self action:@selector(clearBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_clearBtn];
        [_clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.right.equalTo(self.contentView).offset(-paddingLeftWidth);
            make.centerY.equalTo(self.contentView);
        }];
    }
    
    return _clearBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor blueColor];
        if (!_textField) {
            _textField = [[UITextField alloc] init];
            [_textField setFont:[UIFont systemFontOfSize:17]];
            [_textField addTarget:self action:@selector(editDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
            [_textField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
            [_textField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
//            _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            [self.contentView addSubview:_textField];
            [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(20);
                make.left.equalTo(self.contentView).offset(paddingLeftWidth);
                make.right.equalTo(self.contentView).offset(-paddingLeftWidth-30);
                make.centerY.equalTo(self.contentView);
            }];
        }
        
        if ([reuseIdentifier isEqualToString:cellInentifier_name]) {
            //
        }else if ([reuseIdentifier isEqualToString:cellInentifier_phone]){
            _countryLab = ({
                UILabel *label = [UILabel new];
                label.font = [UIFont systemFontOfSize:17];
                label.textColor = [UIColor redColor];
                [self.contentView addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.contentView).offset(paddingLeftWidth);
                    make.centerY.equalTo(self.contentView);
                }];
                label.text = @"+86";
                label;
            });
            UIView *lineV = ({
                UIView *view = [UIView new];
                view.backgroundColor = [UIColor colorWithHexString:@"0xd8dde4"];
                [self.contentView addSubview:view];
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.countryLab.mas_right).offset(8);
                    make.centerY.equalTo(self.countryLab);
                    make.width.mas_offset(0.5);
                    make.height.mas_equalTo(15.0);
                }];
                view;
            });
            UIButton *bgBtn = ({
                UIButton *button = [UIButton new];
//                [button setBackgroundColor:[UIColor whiteColor]];
                [self.contentView addSubview:button];
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.bottom.equalTo(self.contentView);
                    make.right.equalTo(lineV);
                }];
                button;
            });
            [bgBtn addTarget:self action:@selector(countryBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            [_textField mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(20);
                make.right.equalTo(self.contentView).offset(-paddingLeftWidth-30);
                make.centerY.equalTo(self.contentView);
                make.left.equalTo(lineV.mas_right).offset(8.0);
            }];
        }else if ([reuseIdentifier isEqualToString:cellInentifier_psw]){
            if (!_pswBtn) {
                _textField.secureTextEntry = YES;
                
                _pswBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreen_Width - 44- paddingLeftWidth, 0, 44, 44)];
                [_pswBtn setImage:[UIImage imageNamed:@"password_unlook"] forState:UIControlStateNormal];
                [_pswBtn addTarget:self action:@selector(passwordBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:_pswBtn];
            }
            
            [self.clearBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(30, 30));
                make.right.equalTo(_pswBtn.mas_left);
                make.centerY.equalTo(self.contentView);
            }];
            
            [_textField mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(20);
                make.right.equalTo(self.clearBtn.mas_left);
                make.centerY.equalTo(self.contentView);
                make.left.equalTo(self.contentView).offset(paddingLeftWidth);
            }];
        }else if ([reuseIdentifier isEqualToString:cellInentifier_code]){
            if (!_codeBtn) {
                _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                _codeBtn.frame = CGRectMake(kScreen_Width - 80 - paddingLeftWidth, (44-25)/2, 80, 25);
                [_codeBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [_codeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
//                _codeBtn = [[PhoneCodeButton alloc] initWithFrame:CGRectMake(kScreen_Width - 80 - paddingLeftWidth, (44-25)/2, 80, 25)];
                [_codeBtn addTarget:self action:@selector(codeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:_codeBtn];
            }
            
            [self.clearBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(30, 30));
                make.right.equalTo(_codeBtn.mas_left);
                make.centerY.equalTo(self.contentView);
            }];
            
            [_textField mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(20);
                make.right.equalTo(self.clearBtn.mas_left);
                make.centerY.equalTo(self.contentView);
                make.left.equalTo(self.contentView).offset(paddingLeftWidth);
            }];
        }else if ([reuseIdentifier isEqualToString:cellInentifier_email]){
            
        }
    }
    
    return self;
}

- (void)countryBtnClicked:(id)sender{
    if (self.countryBtnClicked) {
        self.countryBtnClicked();
    }
}

- (void)setPlaceholder:(NSString *)placeholder value:(NSString *)valueStr{
    self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"0xffffff" alpha:0.5]}];
    self.textField.text = valueStr;
}

- (void)clearBtnClicked:(id)sender{
    self.textField.text = @"";
    [self textValueChanged:nil];
}

- (void)passwordBtnClicked:(UIButton *)button{
    _textField.secureTextEntry = !_textField.secureTextEntry;
    [button setImage:[UIImage imageNamed:_textField.secureTextEntry? @"password_unlook": @"password_look"] forState:UIControlStateNormal];
}

- (void)codeButtonClicked:(id)sender{
    if (self.codeBtnClicked) {
        self.codeBtnClicked();
    }
}

- (void)editDidBegin:(id)sender{
    self.lineView.backgroundColor = [UIColor whiteColor];
    self.clearBtn.hidden = self.textField.text.length <=0 ?: NO;
    if (self.editDidBeginBlock) {
        self.editDidBeginBlock(self.textField.text);
    }
}

- (void)textValueChanged:(id)sender{
    self.clearBtn.hidden = self.textField.text.length <=0 ?: NO;
    if (self.textValueChangedBlock) {
        self.textValueChangedBlock(self.textField.text);
    }
}

- (void)editDidEnd:(id)sender{
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"0xffffff" alpha:0.5];
    self.clearBtn.hidden = YES;
    if (self.editDidEndBlock) {
        self.editDidEndBlock(self.textField.text);
    }
}

@end
