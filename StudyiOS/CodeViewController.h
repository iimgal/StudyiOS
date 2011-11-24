//
//  CodeViewController.h
//  StudyiOS
//
//  Created by  on 11-10-30.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CodeViewController : UIViewController

@property (strong, nonatomic) NSString *className;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@end
