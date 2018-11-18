//
//  HKRefreNormalView.m
//  UIBaseFrame
//
//  Created by 宋宏康 on 2018/11/2.
//  Copyright © 2018 中施科技. All rights reserved.
//

#import "HKRefreNormalView.h"
#import <Masonry.h>

@interface HKRefreNormalView()

@end


@implementation HKRefreNormalView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)setupUI
{
    UIView *containView = [[UIView alloc] init];
    [self addSubview:containView];
    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(0);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image =  [UIImage imageNamed:@"push"];
    [containView addSubview:imageView];
    self.iconImageView =  imageView;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.mas_equalTo(0);
    }];
    /// 下拉刷新 文字label
    UILabel *label = [[UILabel alloc] init];
    [containView addSubview:label];
    label.text = @"下拉刷新哦";
    self.contentLabel  = label;
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).offset(10);
        make.centerY.right.equalTo(@0);
    }];
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.activityIndicatorView = activityIndicatorView;
    activityIndicatorView.color = [UIColor redColor];
    [activityIndicatorView stopAnimating];
    [activityIndicatorView setHidesWhenStopped:YES];
    [containView addSubview:activityIndicatorView];
    
    [activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
    }];
}

@end
