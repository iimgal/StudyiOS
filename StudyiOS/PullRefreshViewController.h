//
//  PullRefreshViewController.h
//  StudyiOS
//
//  Created by  on 11-11-3.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@interface PullRefreshViewController : UITableViewController <EGORefreshTableHeaderDelegate>

@property (strong, nonatomic) EGORefreshTableHeaderView *refreshHeaderView;

//  Reloading var should really be your tableviews datasource
//  Putting it here for demo purposes 
@property (assign, nonatomic)BOOL reloading;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
