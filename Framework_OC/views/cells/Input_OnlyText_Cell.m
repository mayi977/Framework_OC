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
@property (nonatomic,strong) UIButton *clearBtn;

@end

@implementation Input_OnlyText_Cell

- (void)layoutSubviews{
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
    _clearBtn.hidden = YES;
    
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
    }
    
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder value:(NSString *)valueStr{
    self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"0xffffff" alpha:0.5]}];
    self.textField.text = valueStr;
}

- (void)clearBtnClicked:(id)sender{
    self.textField.text = @"";
    [self textValueChanged:nil];
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
