//
//  DemoCodeViewController.h
//  StudyiOS
//
//  Created by ZhangYiCheng on 12-12-7.
//  Copyright (c) 2012年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
 
@interface DemoCodeViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (copy, nonatomic) NSString *uuid;

@end
