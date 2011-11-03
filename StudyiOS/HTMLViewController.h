//
//  HTMLViewController.h
//  StudyiOS
//
//  Created by  on 11-10-27.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTMLViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *textView;

- (IBAction)HTMLParse:(id)sender;

@end
