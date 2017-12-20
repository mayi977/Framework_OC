//
//  ZLSegmentView.m
//  Framework_OC
//
//  Created by 蚂蚁 on 2017/12/20.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import "ZLSegmentView.h"

@interface ZLSegmentView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableview;

@end;

@implementation ZLSegmentView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        _tableview = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableview.backgroundColor = [UIColor clearColor];
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [self addSubview:_tableview];
        
        _tableview.estimatedRowHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        
        _refreshControl = [[ODRefreshControl alloc] initInScrollView:_tableview];
        [_refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
        
    }
    
    return self;
}

- (void)refresh{
    if (_delegate && [_delegate respondsToSelector:@selector(startRefreshView:)]) {
        [_delegate startRefreshView:self];
    }
}

- (void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    [_tableview reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedItem:)]) {
        [_delegate didSelectedItem:indexPath];
    }
}

@end
