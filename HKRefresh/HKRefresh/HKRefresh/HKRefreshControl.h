//
//  HKRefreshControl.h
//  UIBaseFrame
//
//  Created by 宋宏康 on 2018/11/2.
//  Copyright © 2018 中施科技. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 刷新控件的状态 */
typedef NS_ENUM(NSUInteger, HKRefreshHeaderState){
    /** 普通闲置状态 */
    HKRefreshHeaderStateIdle = 0,
    /** 松开就可以进行刷新的状态 */
    HKRefreshHeaderStatePulling,
    /** 正在刷新中的状态 */
    HKRefreshHeaderStateRefreshing
};

@interface HKRefreshControl : UIControl
/** 开始刷新 */
- (void)beginRefreshing;
/** 结束刷新 */
- (void)endRefreshing;
@end


