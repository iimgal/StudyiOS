//
//  DemoCodeViewController.m
//  StudyiOS
//
//  Created by ZhangYiCheng on 12-12-7.
//  Copyright (c) 2012年 ZhangYiCheng. All rights reserved.
//

#import "DemoCodeViewController.h"

@interface DemoCodeViewController ()

@end

@implementation DemoCodeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:self.uuid ofType:@"html"];
    if (path) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath: path]]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setWebView:nil];
    [super viewDidUnload];
}
@end
