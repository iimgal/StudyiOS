//
//  WebViewController.h
//  StudyiOS
//
//  Created by  on 11-10-14.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *getButton;
@property (strong, nonatomic) IBOutlet UIButton *putButton;
@property (strong, nonatomic) IBOutlet UIButton *postButton;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITextField *urlText;

- (IBAction)getPressed:(id)sender;
- (IBAction)putPressed:(id)sender;
- (IBAction)postPressed:(id)sender;


@end
