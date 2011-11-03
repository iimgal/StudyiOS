//
//  ScrollViewController.m
//  StudyiOS
//
//  Created by  on 11-10-30.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController()
@property (strong, nonatomic) NSArray *colors;
@end

@implementation ScrollViewController
@synthesize scrollView;
@synthesize pageControl;
@synthesize colors;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad
{
    // 增加Code按钮，可跳转至教学页面
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Code" style:UIBarButtonItemStyleBordered target:self action:@selector(code)];
    self.navigationItem.rightBarButtonItem = item;
    
    colors = [NSArray arrayWithObjects:
              [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1],
              [UIColor blueColor],
              [UIColor redColor],
              [UIColor yellowColor],
              [UIColor orangeColor],
              [UIColor cyanColor],
              [UIColor purpleColor],
              [UIColor brownColor],
              [UIColor magentaColor],
              [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1],
              nil];
    // 创建滑动视图
    scrollView = [[TTScrollView alloc] initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height - 40 - 5.f)];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    // 设置委托
    scrollView.dataSource = self;
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    // 创建页面控制器
    pageControl = [[TTPageControl alloc] initWithFrame:CGRectMake(0,380, self.view.width, 20)];
    pageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    pageControl.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    pageControl.currentPage = 0;
    pageControl.numberOfPages = [colors count];
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:pageControl];
    
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setPageControl:nil];
    [self setColors:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
// TTScrollViewDataSource
// 有多少页面
- (NSInteger)numberOfPagesInScrollView:(TTScrollView*)scrollView {
    return colors.count;
}
// 创建页面
- (UIView*)scrollView:(TTScrollView*)scrollView pageAtIndex:(NSInteger)pageIndex {
    TTView* pageView = nil;
    if (!pageView) {
        pageView = [[TTView alloc] init];
        pageView.backgroundColor = [UIColor clearColor];
        pageView.userInteractionEnabled = NO;
        //pageView.contentMode = UIViewContentModeLeft;
    }
    
    pageView.style =
    [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:30] next:
     [TTInsetStyle styleWithInset:UIEdgeInsetsMake(10, 10, 10, 10) next:
      [TTLinearGradientFillStyle styleWithColor1:[UIColor whiteColor]
                                          color2:[colors objectAtIndex:pageIndex] next:
       [TTSolidBorderStyle styleWithColor:[UIColor blueColor] width:1 next:
        nil]]]];
    
    return pageView;
}
// 页面大小
- (CGSize)scrollView:(TTScrollView*)scrollView sizeOfPageAtIndex:(NSInteger)pageIndex {
    return CGSizeMake(320, 416);
}

#pragma mark -
#pragma mark TTScrollViewDelegate
// 移动页面触发
- (void)scrollView:(TTScrollView*)scrollView didMoveToPageAtIndex:(NSInteger)pageIndex {
    pageControl.currentPage = pageIndex;
}

#pragma mark -
#pragma mark UIViewController overrides
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

#pragma mark -
#pragma mark TTPageControl

- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;
    [scrollView setCenterPageIndex:page];
}

// 跳转至教学页面
- (void)code
{
    CodeViewController *controller = [[CodeViewController alloc] init];
    NSString *name = [NSString stringWithUTF8String:object_getClassName(self)];
    controller.className = name;
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
