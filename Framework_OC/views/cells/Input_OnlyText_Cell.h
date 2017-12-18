//
//  Input_OnlyText_Cell.h
//  Framework_OC
//
//  Created by 蚂蚁 on 2017/12/15.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define cellInentifier_name @"cell_name"
#define cellInentifier_phone @"cell_phone"
#define cellInentifier_psw @"cell_psw"
#define cellInentifier_code @"cell_code"
#define cellInentifier_email @"cell_email"
@interface Input_OnlyText_Cell : UITableViewCell

@property (nonatomic,strong) UITextField *textField;

@property (nonatomic,strong) UILabel *countryLab;//手机号前选择国家区号

@property (nonatomic,copy) void (^editDidBeginBlock)(NSString *text);
@property (nonatomic,copy) void (^editDidEndBlock)(NSString *text);
@property (nonatomic,copy) void (^textValueChangedBlock)(NSString *text);
@property (nonatomic,copy) void (^countryBtnClicked)(void);
@property (nonatomic,copy) void (^codeBtnClicked)(void);

- (void)setPlaceholder:(NSString *)placeholder value:(NSString *)valueStr;

@end
