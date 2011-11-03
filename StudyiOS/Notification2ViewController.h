//
//  Notification2ViewController.h
//  StudyiOS
//
//  Created by  on 11-10-27.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Notification2ViewController : UIViewController

@property (weak, nonatomic) id superDelegate;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (copy, nonatomic) NSString *string;


- (IBAction)back:(id)sender;

@end
