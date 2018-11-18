//
//  HKRefreNormalView.h
//  UIBaseFrame
//
//  Created by 宋宏康 on 2018/11/2.
//  Copyright © 2018 中施科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKRefreNormalView : UIView
/** 下拉刷新的 文字Label */
@property (nonatomic, weak)UILabel *contentLabel;
/** 图标 */
@property (nonatomic, weak)UIImageView *iconImageView;
/** 旋转的小菊花 */
@property (nonatomic, strong)UIActivityIndicatorView *activityIndicatorView;

- (void)setupUI;
@end
