//
//  AnimationViewController.m
//  StudyiOS
//
//  Created by  on 11-10-6.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "AnimationViewController.h"
#import <QuartzCore/QuartzCore.h>

#define kDuration 0.7   // 动画持续时间(秒)

@implementation AnimationViewController

@synthesize blueView;
@synthesize greenView;
@synthesize typeID;

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
    self.navigationItem.rightBarButtonItem = item;
    
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    self.blueView = nil;
    self.greenView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
#pragma mark -
#pragma mark Core Animation
- (IBAction)buttonPressed1:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSInteger tag = button.tag;
    
    // 使用Core Animation创建动画
    
    // 创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    animation.delegate = self;
    // 设定动画时间
    animation.duration = kDuration;
    // 设定动画快慢(开始与结束时较慢)
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    // 12种类型
    switch (tag) {
        case 101:
            // 设定动画类型
            // kCATransitionFade 淡化
            // kCATransitionPush 推挤
            // kCATransitionReveal 揭开
            // kCATransitionMoveIn 覆盖
            // @"cube" 立方体
            // @"suckEffect" 吸收
            // @"oglFlip" 翻转
            // @"rippleEffect" 波纹
            // @"pageCurl" 翻页
            // @"pageUnCurl" 反翻页
            // @"cameraIrisHollowOpen" 镜头开
            // @"cameraIrisHollowClose" 镜头关
            animation.type = kCATransitionFade;
            break;
        case 102:
            animation.type = kCATransitionPush;
            break;
        case 103:
            animation.type = kCATransitionReveal;
            break;
        case 104:
            animation.type = kCATransitionMoveIn;
            break;
        case 201:
            animation.type = @"cube";
            break;
        case 202:
            animation.type = @"suckEffect";
            break;
        case 203:
            animation.type = @"oglFlip";
            break;
        case 204:
            animation.type = @"rippleEffect";
            break;
        case 205:
            animation.type = @"pageCurl";
            break;
        case 206:
            animation.type = @"pageUnCurl";
            break;
        case 207:
            animation.type = @"cameraIrisHollowOpen";
            break;
        case 208:
            animation.type = @"cameraIrisHollowClose";
            break;
        default:
            break;
    }
    // 四个方向
    switch (self.typeID) {
        case 0:
            // 设定动画方向
            animation.subtype = kCATransitionFromLeft;
            break;
        case 1:
            animation.subtype = kCATransitionFromBottom;
            break;
        case 2:
            animation.subtype = kCATransitionFromRight;
            break;
        case 3:
            animation.subtype = kCATransitionFromTop;
            break;
        default:
            break;
    }
    self.typeID += 1;
    if (self.typeID > 3) {
        self.typeID = 0;
    }
    // 视图切换,请替换以下三行代码
    NSUInteger green = [[self.view subviews] indexOfObject:self.greenView];
    NSUInteger blue = [[self.view subviews] indexOfObject:self.blueView];
    [self.view exchangeSubviewAtIndex:green withSubviewAtIndex:blue];
    
    // 动画开始
    [[self.view layer] addAnimation:animation forKey:@"animation"];
    
}

#pragma mark CAAnimationDelegate
// 动画开始时调用
- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"animationDidStart");
}

// 动画结束时调用
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"animationDidStop");
}

#pragma mark -
#pragma mark UIView动画
- (IBAction)buttonPressed2:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSInteger tag = button.tag;
    
    // 使用UIView创建动画
    
    // 开始设置动画
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 动画开始
    [UIView beginAnimations:nil context:context];
    // 设置动画快慢
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    // 设置动画时间
    [UIView setAnimationDuration:kDuration];
    // 4种类型
    switch (tag) {
        case 105:
            // 设置动画类型
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
            break;
        case 106:
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
            break;
        case 107:
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
            break;
        case 108:
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
            break;
        default:
            break;
    }
    // 视图切换,请替换以下三行代码
    NSUInteger green = [[self.view subviews] indexOfObject:self.greenView];
    NSUInteger blue = [[self.view subviews] indexOfObject:self.blueView];
    [self.view exchangeSubviewAtIndex:green withSubviewAtIndex:blue];
    
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用某个方法
    //[UIView setAnimationDidStopSelector:@selector(animationFinished:)];
    // 提交动画
    [UIView commitAnimations];
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
