//
//  ImageTableViewController.h
//  StudyiOS
//
//  Created by  on 11-11-4.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebImageManagerDelegate.h"
#import "SDWebImageDownloaderDelegate.h"

@interface ImageTableViewController : UITableViewController <SDWebImageManagerDelegate, SDWebImageDownloaderDelegate>

@property (strong, nonatomic) NSArray *list;

@end
