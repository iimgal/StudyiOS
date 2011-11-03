//
//  ASIHTTPViewController.h
//  StudyiOS
//
//  Created by  on 11-10-15.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestHeader.h"


@interface SynchronousViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *showText;

- (IBAction)grabURL:(id)sender;

@end
