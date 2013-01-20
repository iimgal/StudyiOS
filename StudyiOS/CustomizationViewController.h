//
//  CustomizationViewController.h
//  StudyiOS
//
//  Created by ZhangYiCheng on 12-12-16.
//  Copyright (c) 2012年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomizationViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UISwitch *aSwitch;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segment;
@property (strong, nonatomic) IBOutlet UIButton *button;

- (IBAction)custom:(id)sender;
@end
