//
//  ZLSegmentControl.h
//  Framework_OC
//
//  Created by 蚂蚁 on 2017/12/20.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedItemBlock) (NSInteger index);

@class ZLSegmentControl;
@protocol ZLSegmentControlDelegate <NSObject>

- (void)segmentControl:(ZLSegmentControl *)control selectedIndex:(NSInteger)index;

@end

@interface ZLSegmentControl : UIView

@property (nonatomic,copy) SelectedItemBlock block;


- (instancetype)initWithFrame:(CGRect)frame contextWidth:(CGFloat)contextWidth items:(NSArray *)items selectedItemBlock:(SelectedItemBlock)itemBlock;
- (void)selectedIndex:(NSInteger)index;
- (void)moveToOffset:(CGFloat)offset;

@end
