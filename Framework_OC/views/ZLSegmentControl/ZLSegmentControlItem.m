//
//  ZLSegmentControlItem.m
//  Framework_OC
//
//  Created by 蚂蚁 on 2017/12/20.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import "ZLSegmentControlItem.h"

@implementation ZLSegmentControlItem

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
            label.font = [UIFont systemFontOfSize:ItemTitleFont];
            label.textAlignment = 1;
            label.text = title;
            label.textColor = [UIColor colorWithHexString:@"0x222222"];
            label.backgroundColor = [UIColor clearColor];
            
            label;
        });
        
        [self addSubview:_titleLabel];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected{
    if (_titleLabel) {
        [_titleLabel setTextColor:selected ? [UIColor colorWithHexString:@"0x2ebe76"] : [UIColor colorWithHexString:@"0x222222"]];
    }
}

- (void)resetTitle:(NSString *)title{
    if (_titleLabel) {
        _titleLabel.text = title;
    }
}

@end
