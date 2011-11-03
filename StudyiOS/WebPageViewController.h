//
//  WebPageViewController.h
//  StudyiOS
//
//  Created by  on 11-10-18.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestHeader.h"

@interface WebPageViewController : UIViewController <UIWebViewDelegate>
	
@property (strong, nonatomic) ASIWebPageRequest *request;
@property (strong, nonatomic) NSMutableArray *requestsInProgress;

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UITextField *urlField;
@property (strong, nonatomic) IBOutlet UITextView *responseField;
@property (strong, nonatomic) IBOutlet UISwitch *replaceURLsSwitch;

- (void)fetchURL:(NSURL *)url;

- (IBAction)fetchWebPage:(id)sender;

- (IBAction)clearCache:(id)sender;

@end
