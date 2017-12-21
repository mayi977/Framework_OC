//
//  ZLSegmentControl.m
//  Framework_OC
//
//  Created by 蚂蚁 on 2017/12/20.
//  Copyright © 2017年 zilu. All rights reserved.
//

#import "ZLSegmentControl.h"
#import "ZLSegmentControlItem.h"

@interface ZLSegmentControl()<UIScrollViewDelegate>

@property (nonatomic,assign) CGFloat contextWidth;
@property (nonatomic,strong) UIScrollView *contentView;
@property (nonatomic,strong) NSMutableArray *itemFrames,*items;
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,assign) id<ZLSegmentControlDelegate> delegate;

@end

@implementation ZLSegmentControl

- (instancetype)initWithFrame:(CGRect)frame contextWidth:(CGFloat)contextWidth items:(NSArray *)items selectedItemBlock:(SelectedItemBlock)itemBlock{
    if (self = [super initWithFrame:frame]) {
        self.block = itemBlock;
        self.contextWidth = contextWidth;
        _contentView = ({
            UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
            sv.backgroundColor = [UIColor clearColor];
//            sv.delegate = self;
            sv.showsHorizontalScrollIndicator = NO;
            sv.scrollsToTop = NO;
            sv.bounces = NO;
            [self addSubview:sv];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
            [sv addGestureRecognizer:tapGesture];
            [tapGesture requireGestureRecognizerToFail:sv.panGestureRecognizer];
            
            sv;
        });
        
        self.backgroundColor = [UIColor whiteColor];
        [self initItemsWithTitles:items];
    }
    
    return self;
}

- (void)initItemsWithTitles:(NSArray *)titles{
    _itemFrames = @[].mutableCopy;
    _items = @[].mutableCopy;
    float y = 0;
    float height = CGRectGetHeight(self.bounds);
    NSObject *obj = [titles firstObject];
    if ([obj isKindOfClass:[NSString class]]) {
        for (int i = 0 ; i < titles.count; i ++) {
            float x = i > 0 ? CGRectGetMaxX([_itemFrames[i - 1] CGRectValue]) : 0 ;
            float width = self.contextWidth / titles.count;
            CGRect rect = CGRectMake(x, y, width, height);
            [_itemFrames addObject:[NSValue valueWithCGRect:rect]];
        }
        
        BOOL needResize = NO;
        for (int i = 0; i < titles.count; i ++) {
            CGRect rect = [_itemFrames[i] CGRectValue];
            NSString *title = titles[i];
            if ([title getWidthFont:[UIFont systemFontOfSize:ItemTitleFont] textHeigth:20] > rect.size.width) {
                needResize = YES;
                break;
            }
        }
        if (needResize) {
            [_itemFrames removeAllObjects];
            for (int i = 0 ; i < titles.count; i ++) {
                NSString *title = titles[i];
                float width = [title getWidthFont:[UIFont systemFontOfSize:ItemTitleFont] textHeigth:20] + 25;
                float x = i > 0 ? CGRectGetMaxX([_itemFrames[i - 1] CGRectValue]) : 0 ;
                CGRect rect = CGRectMake(x, y, width, height);
                [_itemFrames addObject:[NSValue valueWithCGRect:rect]];
            }
        }
        
        for (int i = 0; i < titles.count; i ++) {
            CGRect rect = [_itemFrames[i] CGRectValue];
            NSString *title = titles[i];
            ZLSegmentControlItem *item = [[ZLSegmentControlItem alloc] initWithFrame:rect title:title];
            if (i == 0) {
                [item setSelected:YES];
            }
            [_items addObject:item];
            [_contentView addSubview:item];
        }
    }
    
    [_contentView setContentSize:CGSizeMake(self.contextWidth, CGRectGetHeight(self.bounds))];
    self.currentIndex = 0;
    [self selectedIndex:0];
}

- (void)selectedIndex:(NSInteger)index{
    [self addLinView];
    if (index < 0) {
        _currentIndex = -1;
        _lineView.hidden = YES;
        for (ZLSegmentControlItem *item in _items) {
            [item setSelected:NO];
        }
    }else{
        _lineView.hidden = NO;
        if (index != _currentIndex) {
            ZLSegmentControlItem *item = [_items objectAtIndex:index];
            CGRect rect = [_itemFrames[index] CGRectValue];
            CGRect lineRect = CGRectMake(CGRectGetMinX(rect) + 20, CGRectGetHeight(rect) - 3, CGRectGetWidth(rect) - 40, 3);
//            NSLog(@"%@===%@",NSStringFromCGRect(rect),NSStringFromCGRect(lineRect));
//            NSLog(@"%f",CGRectGetMinX(rect));
            if (_currentIndex < 0) {
                _lineView.frame = lineRect;
                [item setSelected:YES];
                _currentIndex = index;
            }else{
                [UIView animateWithDuration:0.5 animations:^{
                    _lineView.frame = lineRect;
                } completion:^(BOOL finished) {
                    [_items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        ZLSegmentControlItem *lastItem = (ZLSegmentControlItem *)obj;
                        [lastItem setSelected:NO];
                    }];
                    [item setSelected:YES];
                    _currentIndex = index;
                }];
            }
        }
    }
    
    [self setScrollOffset:index];
}

- (void)addLinView{
    if (!_lineView) {
        CGRect rect = [_itemFrames[0] CGRectValue];
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetHeight(rect) - 3, CGRectGetWidth(rect) - 40, 3)];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"0x2ebe76"];
        [_contentView addSubview:_lineView];
        
        UIView *bottomLinView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame), 0.5)];
        bottomLinView.backgroundColor = [UIColor colorWithHexString:@"D8DDE4"];
        [self addSubview:bottomLinView];
    }
}

- (void)tapGesture:(UITapGestureRecognizer *)tap{
    CGPoint point = [tap locationInView:tap.view];
    __weak typeof(self) weakSelf = self;
    [_itemFrames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect rect = [obj CGRectValue];
        if (CGRectContainsPoint(rect, point)) {
//            NSLog(@"%@==%@==%d",NSStringFromCGRect(rect),NSStringFromCGPoint(point),idx);
            [weakSelf selectedIndex:idx];
            [weakSelf transformAction:idx];
            
            *stop = YES;
        }
    }];
}

- (void)transformAction:(NSInteger)index{
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(ZLSegmentControlDelegate)] && [self.delegate respondsToSelector:@selector(segmentControl:selectedIndex:)]) {
        [self.delegate segmentControl:self selectedIndex:index];
    }else{
        self.block(index);
    }
}

- (void)setScrollOffset:(NSInteger)index{
    CGRect rect = [_itemFrames[index] CGRectValue];
    float midx = CGRectGetMidX(rect);
    float offset = 0;
    float contentWidth = _contentView.contentSize.width;
    float halfWidth = CGRectGetWidth(self.bounds)/2.0;
    if (midx < halfWidth) {
        offset = 0;
    }else if (midx > contentWidth - halfWidth){
        offset = contentWidth - 2*halfWidth;
    }else{
        offset = midx - halfWidth;
    }
    [UIView animateWithDuration:0.5 animations:^{
        [_contentView setContentOffset:CGPointMake(offset, 0) animated:YES];
    }];
}

- (void)moveToOffset:(CGFloat)offset{
//    NSLog(@"====%f",offset);
    offset = MAX(0, MIN(offset, _items.count));
    [self selectedIndex:floor(offset)];
//    offset = MAX(0, MIN(offset, _items.count));
//    float detla = offset - _currentIndex;
//    CGRect originRect = [_itemFrames[_currentIndex] CGRectValue];
//    CGRect originLineRect = CGRectMake(CGRectGetMinX(originRect) + 20, CGRectGetHeight(originRect) - 3, CGRectGetWidth(originRect) - 40, 3);
//
//    CGRect rect;
//    if (detla > 0) {
//        //如果detla大于1，不能简单的用相邻item间距的乘法来计算距离
//        if (detla > 1) {
//            self.currentIndex += floor(detla);
//            detla -= floor(detla);
//            originRect = [_itemFrames[_currentIndex] CGRectValue];
//            originLineRect = CGRectMake(CGRectGetMinX(originRect) + 20, CGRectGetHeight(originRect) - 3, CGRectGetWidth(originRect) - 40, 3);
//        }
//
//        if (_currentIndex == _itemFrames.count - 1) {
//            return;
//        }
//
//        rect = [_itemFrames[_currentIndex + 1] CGRectValue];
//
//        CGRect lineRect = CGRectMake(CGRectGetMinX(rect) + 20, CGRectGetHeight(rect) - 3, CGRectGetWidth(rect) - 40, 3);
//
//        CGRect moveRect = CGRectZero;
//
//        moveRect.size = CGSizeMake(CGRectGetWidth(originLineRect) + detla * (CGRectGetWidth(lineRect) - CGRectGetWidth(originLineRect)), CGRectGetHeight(lineRect));
//        moveRect.origin = CGPointMake(CGRectGetMidX(originLineRect) + detla * (CGRectGetMidX(lineRect) - CGRectGetMidX(originLineRect)) - CGRectGetMidX(moveRect), CGRectGetMidY(originLineRect) - CGRectGetMidY(moveRect));
//        _lineView.frame = moveRect;
//    } else if (detla < 0){
//
//        if (_currentIndex == 0) {
//            return;
//        }
//        rect = [_itemFrames[_currentIndex - 1] CGRectValue];
//        CGRect lineRect = CGRectMake(CGRectGetMinX(rect) + 20, CGRectGetHeight(rect) - 3, CGRectGetWidth(rect) - 40, 3);
//        CGRect moveRect = CGRectZero;
//        moveRect.size = CGSizeMake(CGRectGetWidth(originLineRect) - detla * (CGRectGetWidth(lineRect) - CGRectGetWidth(originLineRect)), CGRectGetHeight(lineRect));
//        moveRect.origin = CGPointMake(CGRectGetMidX(originLineRect) - detla * (CGRectGetMidX(lineRect) - CGRectGetMidX(originLineRect)) - CGRectGetMidX(moveRect), CGRectGetMidY(originLineRect) - CGRectGetMidY(moveRect));
//        _lineView.frame = moveRect;
//        if (detla < -1) {
//            self.currentIndex -= 1;
//        }
//    }
    
}

@end
