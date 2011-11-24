//
//  BannerViewController.m
//  StudyiOS
//
//  Created by  on 11-11-8.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "BannerViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface BannerViewController()
- (void)bannerHidden;
- (void)showBanner;
@end

@implementation BannerViewController
@synthesize banner;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 增加Code按钮，可跳转至教学页面
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Code" style:UIBarButtonItemStyleBordered target:self action:@selector(code)];
    self.navigationItem.rightBarButtonItem = item;

    self.banner.delegate = self;
}

- (void)viewDidUnload
{
    [self setBanner:nil];
    [super viewDidUnload];
}

#pragma mark -
#pragma mark ADBannerViewDelegate Methods
// This method is invoked when the banner has confirmation that an ad will be presented, but before the ad
// has loaded resources necessary for presentation.
- (void)bannerViewWillLoadAd:(ADBannerView *)banner
{
    NSLog(@"bannerViewWillLoadAd");
}

// This method is invoked each time a banner loads a new advertisement. Once a banner has loaded an ad,
// it will display that ad until another ad is available. The delegate might implement this method if
// it wished to defer placing the banner in a view hierarchy until the banner has content to display.
- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    NSLog(@"bannerViewDidLoadAd");
    [self showBanner];
}

// This method will be invoked when an error has occurred attempting to get advertisement content.
// The ADError enum lists the possible error codes.
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"didFailToReceiveAdWithError");
}

// This message will be sent when the user taps on the banner and some action is to be taken.
// Actions either display full screen content in a modal session or take the user to a different
// application. The delegate may return NO to block the action from taking place, but this
// should be avoided if possible because most advertisements pay significantly more when
// the action takes place and, over the longer term, repeatedly blocking actions will
// decrease the ad inventory available to the application. Applications may wish to pause video,
// audio, or other animated content while the advertisement's action executes.
- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    NSLog(@"bannerViewActionShouldBegin");
    return YES;
}

// This message is sent when a modal action has completed and control is returned to the application.
// Games, media playback, and other activities that were paused in response to the beginning
// of the action should resume at this point.
- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    NSLog(@"bannerViewActionDidFinish");
}

#pragma mark -
#pragma mark Touch Delegate Methods
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    if (self.banner.hidden) {
//        [self showBanner];
//    }else {
//        [self bannerHidden];
//    }
//}

- (void)bannerHidden
{
    // 创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    animation.delegate = self;
    // 设定动画时间
    animation.duration = 1.0;
    // 设定动画快慢(开始与结束时较慢)
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    // 设定动画类型
    animation.type = kCATransitionFade;
    // 设定动画方向
    animation.subtype = kCATransitionFromLeft;
    
    self.banner.hidden = YES;
    
    // 动画开始
    [[self.view layer] addAnimation:animation forKey:@"animation"];
}

- (void)showBanner
{
    // 创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    animation.delegate = self;
    // 设定动画时间
    animation.duration = 1.0;
    // 设定动画快慢(开始与结束时较慢)
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    // 设定动画类型
    animation.type = kCATransitionFade;
    // 设定动画方向
    animation.subtype = kCATransitionFromLeft;
    
    self.banner.hidden = NO;
    
    // 动画开始
    [[self.view layer] addAnimation:animation forKey:@"animation"];
    
    // 3秒后隐藏
    //[self performSelector:@selector(bannerHidden) withObject:self afterDelay:3.0];
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
