//
//  WebPageViewController.m
//  StudyiOS
//
//  Created by  on 11-10-18.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "WebPageViewController.h"

// Private stuff
@interface WebPageViewController ()
- (void)webPageFetchFailed:(ASIHTTPRequest *)theRequest;
- (void)webPageFetchSucceeded:(ASIHTTPRequest *)theRequest;
@end

@implementation WebPageViewController

@synthesize request;
@synthesize requestsInProgress;
@synthesize webView;
@synthesize urlField;
@synthesize responseField;
@synthesize replaceURLsSwitch;


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
    
    self.urlField.text = @"http://weibo.com/1473982797";
    [webView setDelegate:self];
    
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    self.request = nil;
    self.requestsInProgress = nil;
    self.webView = nil;
    self.urlField = nil;
    self.responseField = nil;
    self.replaceURLsSwitch = nil;
    [super viewDidUnload];
}

- (void)dealloc
{
    [request setDelegate:nil];
	[request setDownloadProgressDelegate:nil];
	[request cancel];
	[webView setDelegate:nil];
	
}

- (IBAction)fetchWebPage:(id)sender
{
	[self fetchURL:[NSURL URLWithString:[urlField text]]];
}

- (IBAction)clearCache:(id)sender
{
	[[ASIDownloadCache sharedCache] clearCachedResponsesForStoragePolicy:ASICacheForSessionDurationCacheStoragePolicy];
	[[ASIDownloadCache sharedCache] clearCachedResponsesForStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
}

- (void)fetchURL:(NSURL *)url
{
	[urlField resignFirstResponder];
    
	[self setRequestsInProgress:[NSMutableArray array]];
	//[[self tableView] reloadData];
    
	[request setDelegate:nil];
	[request cancel];
    // 设置Web请求
	[self setRequest:[ASIWebPageRequest requestWithURL:url]];
    // 设置请求完成与失败方法
	[request setDidFailSelector:@selector(webPageFetchFailed:)];
	[request setDidFinishSelector:@selector(webPageFetchSucceeded:)];
    // 设置委托
	[request setDelegate:self];
	[request setDownloadProgressDelegate:self];
    // 设置URL替换模式
	[request setUrlReplacementMode:([replaceURLsSwitch isOn] ? ASIReplaceExternalResourcesWithData : ASIReplaceExternalResourcesWithLocalURLs)];
	
    // 强力推荐为每一个ASIWebPageRequests设置downloadCache和downloadDestinationPath
    
	[request setDownloadCache:[ASIDownloadCache sharedCache]];
	[request setCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
    
	// This is actually the most efficient way to set a download path for ASIWebPageRequest, as it writes to the cache directly
	[request setDownloadDestinationPath:[[ASIDownloadCache sharedCache] pathToStoreCachedResponseDataForRequest:request]];
	
	[[ASIDownloadCache sharedCache] setShouldRespectCacheControlHeaders:NO];
    // 开始异步请求
	[request startAsynchronous];
}
// 网页请求失败
- (void)webPageFetchFailed:(ASIHTTPRequest *)theRequest
{
	[responseField setText:[NSString stringWithFormat:@"Something went wrong: %@",[theRequest error]]];
}
// 网页请求成功
- (void)webPageFetchSucceeded:(ASIHTTPRequest *)theRequest
{
	NSURL *baseURL;
	if ([replaceURLsSwitch isOn]) {
		baseURL = [theRequest url];
        
        // If we're using ASIReplaceExternalResourcesWithLocalURLs, we must set the baseURL to point to our locally cached file
	} else {
		baseURL = [NSURL fileURLWithPath:[request downloadDestinationPath]];
	}
    
	if ([theRequest downloadDestinationPath]) {
		NSString *response = [NSString stringWithContentsOfFile:[theRequest downloadDestinationPath] encoding:[theRequest responseEncoding] error:nil];
		[responseField setText:response];
		[webView loadHTMLString:response baseURL:baseURL];
	} else {
		[responseField setText:[theRequest responseString]];
		[webView loadHTMLString:[theRequest responseString] baseURL:baseURL];
	}
	
	[urlField setText:[[theRequest url] absoluteString]];
}


// 页面跳转时检查是否为页面内部连接
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)theRequest navigationType:(UIWebViewNavigationType)navigationType
{
	if (navigationType == UIWebViewNavigationTypeLinkClicked) {
		[self fetchURL:[theRequest URL]];
		return NO;
	}
	return YES;
}


// At time of writing ASIWebPageRequests do not support automatic progress tracking across all requests needed for a page
// The code below shows one approach you could use for tracking progress - it creates a new row with a progress indicator for each resource request
// However, you could use the same approach and keep track of an overal total to show progress
// 请求开始 一个网页请求会包含很多普通请求
- (void)requestStarted:(ASIWebPageRequest *)theRequest
{
	[[self requestsInProgress] addObject:theRequest];
	//[[self tableView] reloadData];
}
// 请求结束
- (void)requestFinished:(ASIWebPageRequest *)theRequest
{
	if (![[self requestsInProgress] containsObject:theRequest]) {
		[[self requestsInProgress] addObject:theRequest];
		//[[self tableView] reloadData];	
	}
}
// 请求下载数据时不断调用
- (void)request:(ASIHTTPRequest *)theRequest didReceiveBytes:(long long)newLength
{
	NSInteger requestNumber = [[self requestsInProgress] indexOfObject:theRequest];
	if (requestNumber != NSNotFound) {
		//RequestProgressCell *cell = (RequestProgressCell *)[[self tableView] cellForRowAtIndexPath:[NSIndexPath indexPathForRow:requestNumber inSection:2]];
		if ([theRequest contentLength]+[theRequest partialDownloadSize] > 0) {
			//float progressAmount = (float)(([theRequest totalBytesRead]*1.0)/(([theRequest contentLength]+[theRequest partialDownloadSize])*1.0));
			//[[cell progressView] setProgress:progressAmount];
		}
	}
}
// 请求开始下载数据时调用
- (void)request:(ASIHTTPRequest *)theRequest incrementDownloadSizeBy:(long long)newLength
{
	[self request:theRequest didReceiveBytes:0];
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
