//
//  JSONViewController.m
//  StudyiOS
//
//  Created by  on 11-10-24.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "JSONViewController.h"
#import "JSON.h"

@implementation JSONViewController
@synthesize textView;


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidUnload
{
    [self setTextView:nil];
    [super viewDidUnload];
}

- (void)viewDidLoad
{
    // 增加Code按钮，可跳转至教学页面
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Code" style:UIBarButtonItemStyleBordered target:self action:@selector(code)];
    self.navigationItem.rightBarButtonItem = item;
    
    [super viewDidLoad];
}


- (IBAction)JSONParse:(id)sender {
    // 得到资源文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"json"];
    
    // 得到json源文件字符串
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    self.textView.text = jsonString;
    
    // 解析json
    NSMutableDictionary *dic = [textView.text JSONValue];
    NSArray *jsonArray = [dic objectForKey:@"result"];
    
    NSMutableString *json = [[NSMutableString alloc] init];
    
    for (int i = 0; i < [jsonArray count]; i++) {
        NSDictionary *_dic = [jsonArray objectAtIndex:i];
        
        NSDictionary *meeting = [_dic objectForKey:@"meeting"];
        
        [json appendString:[NSString stringWithFormat:@"地址是：%@  创建者是：%@ \n",[meeting objectForKey:@"addr"],[meeting objectForKey:@"creator"]]];
    }
    
    self.textView.text = json;
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
