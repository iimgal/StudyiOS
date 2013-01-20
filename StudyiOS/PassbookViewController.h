//
//  PassbookViewController.h
//  StudyiOS
//
//  Created by ZhangYiCheng on 12-12-15.
//  Copyright (c) 2012年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PassbookViewController : BaseViewController

@property (assign, nonatomic) BOOL isPassing;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UITextField *field1;
@property (strong, nonatomic) IBOutlet UITextField *field2;

- (IBAction)createPass:(id)sender;

@end
