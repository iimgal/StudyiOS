//
//  PassbookViewController.m
//  StudyiOS
//
//  Created by ZhangYiCheng on 12-12-15.
//  Copyright (c) 2012年 ZhangYiCheng. All rights reserved.
//

#import "PassbookViewController.h"
#import <PassSlot/PassSlot.h>

@interface PassbookViewController ()

@end

@implementation PassbookViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidUnload {
    [self setLabel:nil];
    [self setField1:nil];
    [self setField2:nil];
    [super viewDidUnload];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 填写Passslot的APPID
    [PassSlot start:@"LCUNzJXIZUVJjenuJLZUbLZfTlOnSYiANCFrjMAFHYmplpvaEtHXegkRspXYSlKe"];
    

    // 如要单独使用请注释掉这部分代码
    // 增加Code按钮，可跳转至教学页面
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Code" style:UIBarButtonItemStyleBordered target:self action:@selector(code)];
    self.navigationItem.rightBarButtonItem = item;
}

// 如要单独使用请注释掉这部分代码
// 跳转至教学页面
- (void)code
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    DemoCodeViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"DemoCodeViewController"];
    controller.uuid = self.title;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)createPass:(id)sender {
    if (self.isPassing) {
        return;
    }
    self.isPassing = YES;
    [self performSelector:@selector(closePassing) withObject:nil afterDelay:5.0];
    self.label.text = @"连接服务器...";
    
    NSString *str1 = self.field1.text;
    NSString *str2 = self.field2.text;
    
    // 定制你的Pass
    NSDictionary *values = @{@"value": str1, @"label": str2};
    
    // 使用模板创建一个新的PASS
    [PassSlot createPassFromTemplateWithName:@"coupon" withValues:values andRequestInstallation:self completion:^{
        self.label.text = @"Pass已生成";
        self.isPassing = NO;
    }];
}

- (void)closePassing {
    if (self.isPassing) {
        self.label.text = @"服务器连接失败";
        self.isPassing = NO;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.field1 resignFirstResponder];
    [self.field2 resignFirstResponder];
}

@end
