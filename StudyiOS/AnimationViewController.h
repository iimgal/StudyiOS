//
//  AnimationViewController.h
//  StudyiOS
//
//  Created by  on 11-10-6.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIImageView *blueView;
@property (nonatomic, strong) IBOutlet UIImageView *greenView;
@property (nonatomic, assign) NSInteger typeID;

- (IBAction)buttonPressed1:(id)sender;
- (IBAction)buttonPressed2:(id)sender;

@end
