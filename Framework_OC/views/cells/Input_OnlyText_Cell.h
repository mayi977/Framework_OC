//
//  Input_OnlyText_Cell.h
//  Framework_OC
//
//  Created by 蚂蚁 on 2017/12/15.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Input_OnlyText_Cell : UITableViewCell

@property (nonatomic,strong) UITextField *textField;

@property (nonatomic,copy) void (^editDidBeginBlock)(NSString *text);
@property (nonatomic,copy) void (^editDidEndBlock)(NSString *text);
@property (nonatomic,copy) void (^textValueChangedBlock)(NSString *text);

- (void)setPlaceholder:(NSString *)placeholder value:(NSString *)valueStr;

@end
