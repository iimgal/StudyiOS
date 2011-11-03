//
//  NetConnViewController.h
//  StudyiOS
//
//  Created by  on 11-10-24.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NetConnViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *textField;

- (IBAction)isConn:(id)sender;
- (IBAction)connType:(id)sender;
- (IBAction)isSiteConn:(id)sender;

@end
