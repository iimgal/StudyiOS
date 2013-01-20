//
//  ViewController.m
//  DevDiv_ActivityViewController_Demo
//
//  Created by BeyondVincent on 12-6-20.
//  Copyright (c) 2012年 DevDiv. All rights reserved.
//

#import "ActivityViewController.h"

@interface ActivityViewController ()

@end

@implementation ActivityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

// 测试UIActivityViewController
- (IBAction)ActivityVCAction:(id)sender
{
    // 首先初始化activityItems参数
    NSArray *activityItems = [[NSArray alloc]initWithObjects:
                              @"移动开发ActivityViewController测试",
                              @"http://weibo.com/u/1473982797",
                              [UIImage imageNamed:@"girl.png"], nil];
    
    // 初始化一个UIActivityViewController
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:Nil];

    // 初始化completionHandler，当post结束之后（无论是done还是cancell）该blog都会被调用
    activityVC.completionHandler = ^(NSString *activityType, BOOL completed) {
        
    };
    
    // 以模态方式展现出UIActivityViewController
    [self presentViewController:activityVC animated:YES completion:Nil];
}

@end
