//
//  UploadViewController.m
//  StudyiOS
//
//  Created by  on 11-10-17.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "UploadViewController.h"

@interface UploadViewController ()
- (void)uploadFailed:(ASIHTTPRequest *)theRequest;
- (void)uploadFinished:(ASIHTTPRequest *)theRequest;
@end

@implementation UploadViewController

@synthesize request;
@synthesize progressIndicator;
@synthesize resultView;
@synthesize button;


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidUnload
{

    self.request = nil;
    self.progressIndicator = nil;
    self.resultView = nil;
    self.button = nil;
    
    [super viewDidUnload];
}

- (void)dealloc 
{
    // 退出时取消请求
    [request cancel];
}

- (void)viewDidLoad
{
    // 增加Code按钮，可跳转至教学页面
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Code" style:UIBarButtonItemStyleBordered target:self action:@selector(code)];
    //self.navigationItem.rightBarButtonItem = item;
    self.tabBarController.navigationItem.rightBarButtonItem = item;
    
    [super viewDidLoad];
}

- (IBAction)performLargeUpload:(id)sender
{
	[request cancel];
    // 设置一个表单请求
	[self setRequest:[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://allseeing-i.com/ignore"]]];
    // 模拟表单数据
	[request setPostValue:@"test" forKey:@"value1"];
	[request setPostValue:@"test" forKey:@"value2"];
	[request setPostValue:@"test" forKey:@"value3"];
    // 设置超时时间
	[request setTimeOutSeconds:20];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    // 允许后台运行
	[request setShouldContinueWhenAppEntersBackground:YES];
#endif
    // 设置上传进度条
	[request setUploadProgressDelegate:progressIndicator];
    // 设置委托
	[request setDelegate:self];
    // 设置错误方法
	[request setDidFailSelector:@selector(uploadFailed:)];
    // 设置完成方法
	[request setDidFinishSelector:@selector(uploadFinished:)];
	
	// 创建一个256K的数据
	NSData *data = [[NSMutableData alloc] initWithLength:256*1024];
    // 设置文件路径
	NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"file"];
    // 写入文件
	[data writeToFile:path atomically:NO];
	
	// 让请求带8个文件,以使请求达到2M
	int i;
	for (i=0; i<8; i++) {
        // 设置上传文件
		[request setFile:path forKey:[NSString stringWithFormat:@"file-%hi",i]];
	}
	// 开始异步请求
	[request startAsynchronous];
    
	[resultView setText:@"Uploading data..."];
}

- (IBAction)toggleThrottling:(id)sender
{
    // 打开WWAN节流开关
	[ASIHTTPRequest setShouldThrottleBandwidthForWWAN:[(UISwitch *)sender isOn]];
}

- (void)uploadFailed:(ASIHTTPRequest *)theRequest
{
	[resultView setText:[NSString stringWithFormat:@"Request failed:\r\n%@",[[theRequest error] localizedDescription]]];
}

- (void)uploadFinished:(ASIHTTPRequest *)theRequest
{
	[resultView setText:[NSString stringWithFormat:@"Finished uploading %llu bytes of data",[theRequest postLength]]];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    // 清空旧通知
    if ([[[UIApplication sharedApplication] scheduledLocalNotifications] count] > 0)
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    // 创建新通知
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    if (notification) {
        // 设置首次通知时间
		[notification setFireDate:[NSDate date]];
        // 设置时区
		[notification setTimeZone:[NSTimeZone defaultTimeZone]];
        // 设置重复间隔 0为不重复
		[notification setRepeatInterval:0];
        // 设置声音
		[notification setSoundName:@"alarmsound.caf"];
        // 通知文本
		[notification setAlertBody:@"Boom!\r\n\r\nUpload is finished!"];
        // 加入本地通知序列
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
#endif
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
