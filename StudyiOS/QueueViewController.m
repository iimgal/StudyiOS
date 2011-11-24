//
//  QueueViewController.m
//  StudyiOS
//
//  Created by  on 11-10-16.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "QueueViewController.h"


// Private stuff
@interface QueueViewController ()
- (void)imageFetchComplete:(ASIHTTPRequest *)request;
- (void)imageFetchFailed:(ASIHTTPRequest *)request;
@end

@implementation QueueViewController
@synthesize networkQueue;
@synthesize imageView1;
@synthesize imageView2;
@synthesize imageView3;
@synthesize progressIndicator;
@synthesize accurateProgress;
@synthesize imageProgressIndicator1;
@synthesize imageProgressIndicator2;
@synthesize imageProgressIndicator3;
@synthesize imageLabel1;
@synthesize imageLabel2;
@synthesize imageLabel3;
@synthesize failed;


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewDidUnload
{
    self.networkQueue = nil;
    self.imageView1 = nil;
    self.imageView2 = nil;
    self.imageView3 = nil;
    self.progressIndicator = nil;
    self.accurateProgress = nil;
    self.imageProgressIndicator1 = nil;
    self.imageProgressIndicator2 = nil;
    self.imageProgressIndicator3 = nil;
    self.imageLabel1 = nil;
    self.imageLabel2 = nil;
    self.imageLabel3 = nil;
    
    [super viewDidUnload];
}

- (void)dealloc
{
    // 退出时清空队列
    [networkQueue reset];
}

- (void)viewDidLoad
{
    // 增加Code按钮，可跳转至教学页面
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Code" style:UIBarButtonItemStyleBordered target:self action:@selector(code)];
    //self.navigationItem.rightBarButtonItem = item;
    self.tabBarController.navigationItem.rightBarButtonItem = item;
    
    [super viewDidLoad];
}

- (IBAction)fetchThreeImages:(id)sender
{
    // UI清空
	[imageView1 setImage:nil];
	[imageView2 setImage:nil];
	[imageView3 setImage:nil];
    self.progressIndicator.progress = 0.0;
    self.imageProgressIndicator1.progress = 0.0;
    self.imageProgressIndicator2.progress = 0.0;
    self.imageProgressIndicator3.progress = 0.0;
	
    // 初始化队列
	if (!networkQueue) {
		networkQueue = [[ASINetworkQueue alloc] init];	
        // 设置最大并发数 默认为-1 无限制
        [networkQueue setMaxConcurrentOperationCount:10];
	}
	failed = NO;
    // 重制队列
	[networkQueue reset];
    // 设置队列的进度条
	[networkQueue setDownloadProgressDelegate:progressIndicator];
    // 设置完成方法
	[networkQueue setRequestDidFinishSelector:@selector(imageFetchComplete:)];
    // 设置错误方法
	[networkQueue setRequestDidFailSelector:@selector(imageFetchFailed:)];
	// 显示精确进度
    [networkQueue setShowAccurateProgress:YES];
    
	[networkQueue setDelegate:self];
	
    // 初始化请求
    
	ASIHTTPRequest *request;
    // 设置请求URL
	request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"http://allseeing-i.com/ASIHTTPRequest/tests/images/small-image.jpg"]];
    // 设置下载的目标路径
	[request setDownloadDestinationPath:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"1.png"]];
    // 设置进度条
	[request setDownloadProgressDelegate:imageProgressIndicator1];
    // 自定义用户信息
    [request setUserInfo:[NSDictionary dictionaryWithObject:@"request1" forKey:@"name"]];
    // 将请求加入队列
	[networkQueue addOperation:request];
	
    // 同上
	request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:@"http://allseeing-i.com/ASIHTTPRequest/tests/images/medium-image.jpg"]];
	[request setDownloadDestinationPath:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"2.png"]];
	[request setDownloadProgressDelegate:imageProgressIndicator2];
    [request setUserInfo:[NSDictionary dictionaryWithObject:@"request2" forKey:@"name"]];
	[networkQueue addOperation:request];
	
    // 同上
	request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:@"http://allseeing-i.com/ASIHTTPRequest/tests/images/large-image.jpg"]];
	[request setDownloadDestinationPath:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"3.png"]];
	[request setDownloadProgressDelegate:imageProgressIndicator3];
    [request setUserInfo:[NSDictionary dictionaryWithObject:@"request3" forKey:@"name"]];
	[networkQueue addOperation:request];
	
    // 启动队列
	[networkQueue go];
}

// 请求成功后更新UI
- (void)imageFetchComplete:(ASIHTTPRequest *)request
{
    // 从下载路径里读取文件
	UIImage *img = [UIImage imageWithContentsOfFile:[request downloadDestinationPath]];
    NSString *name = [[request userInfo] valueForKey:@"name"];
    
    if (img) {
        if ([name isEqualToString:@"request1"]) {
            [imageView1 setImage:img];
        }else if([name isEqualToString:@"request2"]){
            [imageView2 setImage:img];
        }else if([name isEqualToString:@"request3"]){
            [imageView3 setImage:img];
        }
    }
	
}

// 请求失败后调用
- (void)imageFetchFailed:(ASIHTTPRequest *)request
{
	if (!failed) {
		if ([[request error] domain] != NetworkRequestErrorDomain || [[request error] code] != ASIRequestCancelledErrorType) {
			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Download failed" message:@"Failed to download images" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alertView show];
		}
		failed = YES;
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
