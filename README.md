# HKRefresh

简单的下拉刷新，基本上第三方都是这个思路哈

下载`demo`,`pod initall`

``` _refreshControl = [[HKRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refreshControlAction) forControlEvents: UIControlEventValueChanged];

    [self.tableViewList addSubview:_refreshControl];

    [_refreshControl beginRefreshing];

```

还有很多没有开发玩，后续再继续哈