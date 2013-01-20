//
//  ViewController.m
//  shejiao
//
//  Created by Steven on 12-11-17.
//  Copyright (c) 2012年 Steven. All rights reserved.
//

#import "SocialViewController.h"
#import "DemoCodeViewController.h"
#import <Twitter/Twitter.h>
#import <Social/Social.h>

@interface SocialViewController ()

@end

@implementation SocialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// 判断iOS版本
    if ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue] < 6) {
        self.facebookButton.hidden = YES;
        self.weiboButton.hidden = YES;
    }
    
}

//分享到 Twitter
- (IBAction)sendtotwitter:(id)sender {
    int currentver = [[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue];
    // 如果是iOS5
    if (currentver == 5) {
        // iOS5时使用Twitter独有API
        TWTweetComposeViewController *tweetViewController = [[TWTweetComposeViewController alloc] init];
        // 设置文本
        [tweetViewController setInitialText:@"IOS5 twitter"];
        // 设置回调
        [tweetViewController setCompletionHandler:^(TWTweetComposeViewControllerResult result) {
            [self dismissModalViewControllerAnimated:YES];
        }];
        
        [self presentModalViewController:tweetViewController animated:YES];
        
    }
    // 如果是iOS6
    else if (currentver == 6) {
        [self sendMessageWithSocialType:SLServiceTypeTwitter];
    }
}

//分享到新浪weibo
- (IBAction)sendtoWeibo:(id)sender {
    [self sendMessageWithSocialType:SLServiceTypeSinaWeibo];
}
//分享到facebook
- (IBAction)sendtoFacebook:(id)sender {
    [self sendMessageWithSocialType:SLServiceTypeFacebook];
}

- (void)sendMessageWithSocialType:(NSString *)type {
    // 初始化 type: SLServiceTypeFacebook; SLServiceTypeSinaWeibo; SLServiceTypeTwitter
    if ([SLComposeViewController isAvailableForServiceType:type]) {
        SLComposeViewController *slComposerSheet = [SLComposeViewController composeViewControllerForServiceType:type];
        // 设置文本
        [slComposerSheet setInitialText:@"Hello World!"];
        // 设置图片
        [slComposerSheet addImage:[UIImage imageNamed:@"ios6.jpg"]];
        // 设置URL
        [slComposerSheet addURL:[NSURL URLWithString:@"http://www.twitter.com/"]];
        // 显示
        [self presentViewController:slComposerSheet animated:YES completion:nil];
        
        // 设置回调
        [slComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            NSString *output;
            switch (result) {
                    // 取消
                case SLComposeViewControllerResultCancelled:
                    output = @"Action Cancelled";
                    [self dismissViewControllerAnimated:YES completion:nil];
                    break;
                    // 成功
                case SLComposeViewControllerResultDone:
                    output = @"Post Successfull";
                    break;
                default:
                    break;
            }
            if (result != SLComposeViewControllerResultCancelled)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:output delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                        message:@"您需要在\"设置\"里配置您的账号"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

@end
