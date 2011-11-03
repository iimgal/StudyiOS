//
//  JSONViewController.h
//  StudyiOS
//
//  Created by  on 11-10-24.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSONViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *textView;

- (IBAction)JSONParse:(id)sender;

@end
