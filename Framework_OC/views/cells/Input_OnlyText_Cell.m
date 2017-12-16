//
//  Input_OnlyText_Cell.m
//  Framework_OC
//
//  Created by zilu on 2017/12/13.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import "Input_OnlyText_Cell.h"

@implementation Input_OnlyText_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!_textField) {
            _textField = [UITextField new];
            [_textField setFont:[UIFont systemFontOfSize:17]];
            [_textField addTarget:self action:@selector(editDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
            [_textField addTarget:self action:@selector(editValueChanged:) forControlEvents:UIControlEventEditingChanged];
            [_textField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
            [self.contentView addSubview:_textField];
            _textField.backgroundColor = [UIColor redColor];
            [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(20);
                make.left.equalTo(self.contentView).offset(18);
                make.right.equalTo(self.contentView).offset(-18);
                make.center.equalTo(self.contentView);
            }];
        }
    }
    
    return self;
}

- (void)editDidBegin:(id)sender{
    
}

- (void)editValueChanged:(id)sender{
    
}

- (void)editDidEnd:(id)sender{
    
}

@end
