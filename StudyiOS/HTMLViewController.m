//
//  HTMLViewController.m
//  StudyiOS
//
//  Created by  on 11-10-27.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "HTMLViewController.h"
#import "TFHpple.h"

@interface HTMLViewController() 
    -(NSString *)urlString:(NSString *)value;
@end

@implementation HTMLViewController
@synthesize textView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)HTMLParse:(id)sender {
    
    // 得到网页DATA
    NSString *urlString = @"http://www.baidu.com";
    NSData *htmlData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]; 
    
    // 创建TFHpple对象
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:htmlData];
    
    // 通过xpath语法解析
    NSArray *elements = [xpathParser searchWithXPathQuery:@"//title"];
    TFHppleElement *element = [elements objectAtIndex:0];
    NSString *myTitle = [element content];
    
    // 更新UI
    self.textView.text = myTitle;
    
}

//访问网站源码
- (NSString *)urlString:(NSString *)value {

    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:value]];  
    
    //解决中文乱码,可以有很多编码格式,以你要抓取的网页编码格式为准
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);    
    
    NSString *retStr = [[NSString alloc] initWithData:data encoding:enc];
    
    NSLog(@"获取到的值：%@",retStr);
    
    return retStr;
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
