//
//  HKRefreshControl.m
//  UIBaseFrame
//
//  Created by 宋宏康 on 2018/11/2.
//  Copyright © 2018 中施科技. All rights reserved.
//

#import "HKRefreshControl.h"
#import "HKRefreNormalView.h"
#import <Masonry.h>
/** 下拉的临界点 */
const CGFloat HKRefrshOffSetY = 60.0f;

@interface HKRefreshControl()

/** 暂时保存scrollView */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 下拉刷新状态 */
@property (assign, nonatomic) HKRefreshHeaderState headState;
/** 下拉属性控件 */
@property (nonatomic, strong) HKRefreNormalView *normalView;

@end

@implementation HKRefreshControl
    
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.clipsToBounds = YES;
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.normalView = [[HKRefreNormalView alloc] init];
    [self addSubview:self.normalView];
    [self.normalView setupUI];

    [self.normalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@60);
        make.centerY.equalTo(@0);
    }];
}
    
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if ([newSuperview isKindOfClass:[UIScrollView class]]) {
        self.scrollView = (UIScrollView *)newSuperview;
        [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
    [super willMoveToSuperview:newSuperview];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void *)context
{
    if (object == self.scrollView) {
        NSValue *newvalue = change[NSKeyValueChangeNewKey];
        CGFloat newoffset_y = newvalue.UIOffsetValue.vertical;
//        NSLog(@"New:%f",newoffset_y);
        CGFloat height = -(newoffset_y + self.scrollView.contentInset.top);
        self.frame = CGRectMake(0, - height, self.scrollView.bounds.size.width, height);
//        self.backgroundColor = [UIColor yellowColor];
//        [self adjustStateWithContentOffset];
        if (height < 0)  return;
        
        if (self.scrollView.isDragging) {
            if (height > HKRefrshOffSetY && self.headState == HKRefreshHeaderStateIdle) {
                NSLog(@"松开就刷新");
                self.headState = HKRefreshHeaderStatePulling;
            }else if (height < HKRefrshOffSetY && self.headState == HKRefreshHeaderStatePulling){
                self.headState = HKRefreshHeaderStateIdle;
                NSLog(@"往下面啦");
            }
        }else{
            if (self.headState == HKRefreshHeaderStatePulling) {
                [self beginRefreshing];
                NSLog(@"开始刷新");
                [self sendActionsForControlEvents: UIControlEventValueChanged];
            }
        }
    }
}

#pragma mark - beginRefreshing && endRefreshing
- (void)beginRefreshing
{
    if (self.headState == HKRefreshHeaderStateRefreshing) {
        return;
    }
    self.headState = HKRefreshHeaderStateRefreshing;
    NSLog(@"正在进行刷新");
    UIEdgeInsets edgeInsets = self.scrollView.contentInset;
    edgeInsets.top += HKRefrshOffSetY;
    self.scrollView.contentInset = edgeInsets;
}

- (void)endRefreshing
{
    if (self.headState != HKRefreshHeaderStateRefreshing) {
        return;
    }
    self.clipsToBounds = YES;
    self.headState = HKRefreshHeaderStateIdle;
    UIEdgeInsets edgeInsets = self.scrollView.contentInset;
    edgeInsets.top -= HKRefrshOffSetY;
    self.scrollView.contentInset = edgeInsets;
}

- (void)adjustStateWithContentOffset
{
    
}

- (void)removeFromSuperview
{
    if (self.scrollView) {
        [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
    [super removeFromSuperview];
}

#pragma mark - setHead方法

- (void)setHeadState:(HKRefreshHeaderState)headState
{
    _headState = headState;

    if (headState == HKRefreshHeaderStateIdle) {
        self.normalView.contentLabel.text = @"下拉刷新";
        [self.normalView.activityIndicatorView stopAnimating];
        self.normalView.iconImageView.hidden = NO;

        [UIView animateWithDuration:0.25 animations:^{
            self.normalView.iconImageView.transform = CGAffineTransformIdentity;
        }];
    }
    if (headState == HKRefreshHeaderStatePulling) {
        self.normalView.contentLabel.text = @"松开刷新";
        [self.normalView.activityIndicatorView stopAnimating];
        self.normalView.iconImageView.hidden = NO;

        [UIView animateWithDuration:0.25 animations:^{
            self.normalView.iconImageView.transform = CGAffineTransformMakeRotation(M_PI - 0.0000001);
        }];
    }
    if (headState == HKRefreshHeaderStateRefreshing) {
        self.clipsToBounds = NO;
        self.normalView.contentLabel.text = @"正在刷新";
        self.normalView.iconImageView.hidden = YES;
        [self.normalView.activityIndicatorView startAnimating];
    }
}




@end
