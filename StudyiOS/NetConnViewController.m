//
//  NetConnViewController.m
//  StudyiOS
//
//  Created by  on 11-10-24.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "NetConnViewController.h"
#import<SystemConfiguration/SystemConfiguration.h>
#import<netdb.h>
#import "Reachability.h"


@implementation NetConnViewController
@synthesize textField;


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewDidUnload
{
    [self setTextField:nil];
    [super viewDidUnload];
}

- (void)viewDidLoad
{
    // 增加Code按钮，可跳转至教学页面
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Code" style:UIBarButtonItemStyleBordered target:self action:@selector(code)];
    self.navigationItem.rightBarButtonItem = item;
    
    [super viewDidLoad];
}


- (IBAction)isConn:(id)sender {
    
    struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
	
	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
	SCNetworkReachabilityFlags flags;
	
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	CFRelease(defaultRouteReachability);
	
	if (!didRetrieveFlags) {
		printf("Error. Count not recover network reachability flags\n");
	}
	
	BOOL isReachable = flags & kSCNetworkFlagsReachable;
	BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    
    NSString *result;
	if ((isReachable && !needsConnection) ? YES : NO) {
		result = @"Connection Successed!!!";
	}else {
		result = @"Connection Faild!!!";
	}
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"TestConnection" 
                                                    message:result
												   delegate:self
										  cancelButtonTitle:@"OK,I Know" 
                                          otherButtonTitles:nil];
	[alert show];
}


- (IBAction)connType:(id)sender {
    NSString *connectionKind;
    // 测试连接可用性
    Reachability *hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
	// 判断连接类型
    switch ([hostReach currentReachabilityStatus]) {
		case NotReachable:
			connectionKind = @"没有网络链接";
			break;
		case ReachableViaWiFi:
			connectionKind = @"当前使用的网络类型是WIFI";
			break;
		case ReachableViaWWAN:
			connectionKind = @"当前使用的网络链接类型是WWAN（3G）";
			break;
		default:
			break;
	}
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络链接类型" 
                                                    message:connectionKind
												   delegate:self
										  cancelButtonTitle:@"知道了，谢谢" 
                                          otherButtonTitles:nil];
	[alert show];

}

- (IBAction)isSiteConn:(id)sender {
    [self.textField resignFirstResponder];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *message;
    Reachability *hostReach = [Reachability reachabilityWithHostName:self.textField.text];
    if ([hostReach currentReachabilityStatus] == NotReachable) {
        message = @"连接失败";
    }else {
        message = @"连接成功";
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"结果" 
                                                    message:message 
                                                   delegate:self 
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles:nil];
    [alert show];
    
	//[Reachability hostAvailable:@"www.google.com"]
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textField resignFirstResponder];
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
