//
//  ASIHTTPViewController.m
//  StudyiOS
//
//  Created by  on 11-10-15.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "SynchronousViewController.h"

@interface SynchronousViewController()

@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation SynchronousViewController
@synthesize showText;
@synthesize queue;


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    // 增加Code按钮，可跳转至教学页面
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Code" style:UIBarButtonItemStyleBordered target:self action:@selector(code)];
    //self.navigationItem.rightBarButtonItem = item;
    self.tabBarController.navigationItem.rightBarButtonItem = item;
    
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    self.queue = nil;
    [self setShowText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (IBAction)grabURL:(id)sender {
    // 创建ASIHTTPRequest对象
    NSURL *url = [NSURL URLWithString:@"http://www.163.com"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    // 开始同步请求
    [request startSynchronous];
    // 是否报错
    if ([request error]) {
        // 得到错误信息
        [showText setText:[[request error] localizedDescription]];
    } else if ([request responseString]) {
        // 得到返回信息
        [showText setText:[request responseString]];
    }
}

// 跳转至教学页面
- (void)code
{
    CodeViewController *controller = [[CodeViewController alloc] initWithNibName:@"CodeViewController" bundle:nil];
    NSString *name = [NSString stringWithUTF8String:object_getClassName(self)];
    controller.className = name;
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
