//
//  FlowViewController.h
//  StudyiOS
//
//  Created by ZhangYiCheng on 12-12-6.
//  Copyright (c) 2012年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowViewCell.h"

@interface FlowViewController : UITableViewController <FlowViewCellDelegate>

@property (strong, nonatomic) NSArray *items;

@end
