//
//  NotificationViewController.m
//  StudyiOS
//
//  Created by  on 11-10-27.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "NotificationViewController.h"
#import "Notification2ViewController.h"
#import "Single.h"


@implementation NotificationViewController
@synthesize textView;

// 定义全局变量
NSString *globalString;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    // 增加Code按钮，可跳转至教学页面
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Code" style:UIBarButtonItemStyleBordered target:self action:@selector(code)];
    self.navigationItem.rightBarButtonItem = item;
    
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [self setTextView:nil];
    [super viewDidUnload];
}

// 使用storyboard跳转时触发
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSLog(@"prepareForSegue:%@", segue.identifier);
    // 使用全局变量传参
    if ([segue.identifier isEqualToString:@"global"]) 
    {
        globalString = self.textView.text;
    }
    // 使用单例模式传参
    else if ([segue.identifier isEqualToString:@"single"]) 
    {
        Single *single = [Single shareSingle];
        single.string = self.textView.text;
    }
    // 使用delegate传参
    else if ([segue.identifier isEqualToString:@"delegate"]) 
    {
        [segue.destinationViewController setSuperDelegate:self];
    }
    // 使用通知传参
    else if ([segue.identifier isEqualToString:@"notification"]) 
    {
        // 添加一个观察者，用来观察通知
        // 第一个参数为self,表示将self设为观察者来观察通知，
        // 第二个参数@selector(setData:)表示收到符合条件的通知后要执行方法setData:
        // 第三个参数kNotificationMessage为指定的要观察的通知的名称
        // 第四个参数为nil，表示任何对象发过来的通知都可以被观察到
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doSomething:) name:@"test1" object:nil];
    }
    
    [segue.destinationViewController setString:segue.identifier];
    
}

// 接受到通知后调用的方法
- (void)doSomething:(NSNotification *)notification
{
    NSDictionary *dic = [notification userInfo];
    
    self.textView.text = [dic valueForKey:@"text"];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textView resignFirstResponder];
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
