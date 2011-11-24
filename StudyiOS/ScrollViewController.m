//
//  ScrollViewController.m
//  StudyiOS
//
//  Created by  on 11-10-30.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "ScrollViewController.h"
#import "UIScrollView+TouchScroll.h"

@implementation ScrollViewController
@synthesize scrollView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [super viewDidUnload];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 增加Code按钮，可跳转至教学页面
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Code" style:UIBarButtonItemStyleBordered target:self action:@selector(code)];
    self.navigationItem.rightBarButtonItem = item;
    
    // 是否按页滚动
    self.scrollView.pagingEnabled = YES;
    // 背景色
    self.scrollView.backgroundColor = [UIColor blackColor];
    // 滚动条颜色 因为背景为黑,所以用白色
    self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    // 隐藏滚动条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    self.scrollView.canCancelContentTouches = NO;
    
    self.scrollView.clipsToBounds = YES;
    // 设置委托
    self.scrollView.delegate = self;
    
    // 图片
    NSArray *array = [NSArray arrayWithObjects:@"red.png", @"green.png", @"blue.png", nil];
    
    CGRect rect = self.scrollView.bounds;
    rect = CGRectMake(0, 0, rect.size.width, rect.size.height - 44);
    
    CGFloat width = rect.size.width;
    
    int i = 0;
    for (NSString *name in array) 
    {
        // 创建ImageView
        UIImage *image = [UIImage imageNamed:name];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
        imageView.image = image;
        
        // 加入到ScrollView
        [self.scrollView addSubview:imageView];
        
        // 修改子视图位置
        CGRect frame = imageView.frame;
        frame.origin = CGPointMake(width*i, 0);
        imageView.frame = frame;
        
        i++;
    }
    
    // 设置ScrollView大小
    self.scrollView.contentSize = CGSizeMake(width*[array count], scrollView.bounds.size.height);
    
}
#pragma mark -
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
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
