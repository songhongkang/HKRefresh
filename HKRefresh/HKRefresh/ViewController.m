//
//  ViewController.m
//  HKRefresh
//
//  Created by 宋宏康 on 2018/11/18.
//  Copyright © 2018 demo. All rights reserved.
//

#import "ViewController.h"
#import "HKRefresh/HKRefreshControl.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableViewList;

@property (nonatomic, strong) HKRefreshControl *refreshControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _refreshControl = [[HKRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refreshControlAction) forControlEvents: UIControlEventValueChanged];
    [self.tableViewList addSubview:_refreshControl];
    [_refreshControl beginRefreshing];
    
    __weak typeof(self)weakSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.refreshControl endRefreshing];
    });
    
}

- (void)refreshControlAction
{
    NSLog(@"执行了.....");
    __weak typeof(self) weakSelf = self;    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.refreshControl endRefreshing];
    });
}


@end
