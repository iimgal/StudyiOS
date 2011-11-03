//
//  QueueViewController.h
//  StudyiOS
//
//  Created by  on 11-10-16.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestHeader.h"

@interface QueueViewController : UIViewController

@property (nonatomic, strong) ASINetworkQueue *networkQueue;
@property (nonatomic, strong) IBOutlet UIImageView *imageView1;
@property (nonatomic, strong) IBOutlet UIImageView *imageView2;
@property (nonatomic, strong) IBOutlet UIImageView *imageView3;
@property (nonatomic, strong) IBOutlet UIProgressView *progressIndicator;
@property (nonatomic, strong) IBOutlet UISwitch *accurateProgress;
@property (nonatomic, strong) IBOutlet UIProgressView *imageProgressIndicator1;
@property (nonatomic, strong) IBOutlet UIProgressView *imageProgressIndicator2;
@property (nonatomic, strong) IBOutlet UIProgressView *imageProgressIndicator3;
@property (nonatomic, strong) IBOutlet UILabel *imageLabel1;
@property (nonatomic, strong) IBOutlet UILabel *imageLabel2;
@property (nonatomic, strong) IBOutlet UILabel *imageLabel3;

@property (nonatomic, assign) BOOL failed;

- (IBAction)fetchThreeImages:(id)sender;

@end
