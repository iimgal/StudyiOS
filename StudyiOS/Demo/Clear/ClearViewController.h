//
//  ClearViewController.h
//  StudyiOS
//
//  Created by ZhangYiCheng on 13-1-27.
//  Copyright (c) 2013年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTTransformableTableViewCell.h"
#import "JTTableViewGestureRecognizer.h"
#import "UIColor+JTGestureBasedTableViewHelper.h"


@interface ClearViewController : BaseViewController <JTTableViewGestureEditingRowDelegate, JTTableViewGestureAddingRowDelegate, JTTableViewGestureMoveRowDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *rows;
@property (nonatomic, strong) JTTableViewGestureRecognizer *tableViewRecognizer;
@property (nonatomic, strong) id grabbedObject;

- (void)moveRowToBottomForIndexPath:(NSIndexPath *)indexPath;

@end
