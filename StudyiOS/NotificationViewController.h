//
//  NotificationViewController.h
//  StudyiOS
//
//  Created by  on 11-10-27.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *textView;

- (void)doSomething:(NSNotification *)notification;

@end
