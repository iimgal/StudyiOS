//
//  Notification2ViewController.m
//  StudyiOS
//
//  Created by  on 11-10-27.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "Notification2ViewController.h"
#import "NotificationViewController.h"
#import "Single.h"

@interface Notification2ViewController()

@property (copy, nonatomic) NSString *notiString;

@end

@implementation Notification2ViewController
@synthesize superDelegate;
@synthesize textView;
@synthesize string;
@synthesize notiString;

extern NSString *globalString;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{

    if ([self.string isEqualToString:@"global"]) 
    {
        self.textView.text = [NSString stringWithFormat:@"%@:\n%@", self.string, globalString];
    }
    else if ([self.string isEqualToString:@"single"]) 
    {
        Single *single = [Single shareSingle];
        self.textView.text = [NSString stringWithFormat:@"%@:\n%@", self.string, single.string];
    }
    else if ([self.string isEqualToString:@"delegate"]) 
    {
        self.textView.text = [NSString stringWithFormat:@"%@:\n%@", self.string, [self.superDelegate textView].text];
    }
    else if ([self.string isEqualToString:@"notification"]) 
    {
        
    }
    
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    self.string = nil;
    self.notiString = nil;
    [self setTextView:nil];
    [super viewDidUnload];
}

// 返回上个页面
- (IBAction)back:(id)sender 
{
    [self dismissModalViewControllerAnimated:YES];
    
    if ([self.string isEqualToString:@"notification"]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObject:self.textView.text forKey:@"text"];
        // 发送一个通知
        // 第一个参数表示发出的通知的名称
        // 第二个参数表示谁发出的通知
        // 第三个参数表示通知所带的信息
        [[NSNotificationCenter defaultCenter] postNotificationName:@"test1" object:self userInfo:dic];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textView resignFirstResponder];
}

@end
