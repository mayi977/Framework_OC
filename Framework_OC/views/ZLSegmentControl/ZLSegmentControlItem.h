//
//  ZLSegmentControlItem.h
//  Framework_OC
//
//  Created by 蚂蚁 on 2017/12/20.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ItemTitleFont 15
@interface ZLSegmentControlItem : UIView

@property (nonatomic,strong) UILabel *titleLabel;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;
- (void)setSelected:(BOOL)selected;
- (void)resetTitle:(NSString *)title;

@end
