//
//  ZLSegmentView.h
//  Framework_OC
//
//  Created by 蚂蚁 on 2017/12/20.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ODRefreshControl.h>

@class ZLSegmentView;
@protocol ZLSegmentViewDelegat<NSObject>

- (void)startRefreshView:(ZLSegmentView *)view;
- (void)didSelectedItem:(NSIndexPath *)indexPath;

@end

@interface ZLSegmentView : UIView

@property (nonatomic,assign) id<ZLSegmentViewDelegat> delegate;
@property (nonatomic,strong) NSArray *dataSource;
@property (nonatomic,strong) ODRefreshControl *refreshControl;

@end
