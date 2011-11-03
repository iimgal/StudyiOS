//
//  UploadViewController.h
//  StudyiOS
//
//  Created by  on 11-10-17.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestHeader.h"

@interface UploadViewController : UIViewController

@property (strong, nonatomic) ASIFormDataRequest *request;

@property (strong, nonatomic) IBOutlet UIProgressView *progressIndicator;
@property (strong, nonatomic) IBOutlet UITextView *resultView;
@property (strong, nonatomic) IBOutlet UIButton *button;

- (IBAction)performLargeUpload:(id)sender;
- (IBAction)toggleThrottling:(id)sender;

@end
