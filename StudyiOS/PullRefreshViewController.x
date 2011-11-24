#import "EGORefreshTableHeaderView.h"
// 继承EGORefreshTableHeaderDelegate
// 创建下拉视图
EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
view.delegate = self;
[self.tableView addSubview:view];
        
#pragma mark UIScrollViewDelegate Methods
// 页面滚动时回调
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{	
    [refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}
// 滚动结束时回调
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{	
    [refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark EGORefreshTableHeaderDelegate Methods
// 开始刷新时回调
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{	
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
}
// 下拉时回调
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{	
    return reloading; // should return if data source model is reloading
}
// 请求上次更新时间时调用
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{	
    return [NSDate date]; // should return date data source was last changed
}