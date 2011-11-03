//
//  IcloudViewController.h
//  StudyiOS
//
//  Created by  on 11-10-6.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IcloudViewController : UIViewController <UITextViewDelegate>

@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSURL *icloudURL;
@property (nonatomic, strong) IBOutlet UITextView *textView;
@property (nonatomic, strong) IBOutlet UILabel *label;

- (IBAction)uploadPressed:(id)sender;
- (IBAction)downloadPressed:(id)sender;

- (BOOL)downloadFileIfNotAvailable:(NSURL*)file;
@end
