//
//  ImageTableViewController.m
//  StudyiOS
//
//  Created by  on 11-11-4.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "ImageTableViewController.h"
#import "AsyncImageView.h"

@implementation ImageTableViewController
@synthesize  list;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];

    // 增加Code按钮，可跳转至教学页面
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Code" style:UIBarButtonItemStyleBordered target:self action:@selector(code)];
    self.navigationItem.rightBarButtonItem = item;

    NSMutableArray *array = [[NSMutableArray alloc] 
                             initWithObjects:@"http://i.6.cn/cvbnm/98/70/47/f40590f07d9901e9106636259686fde7.jpg", 
                             @"http://face.weiphone.com/data/avatar/002/29/85/69_avatar_middle.jpg",
                             nil];
    
    self.list = array;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSInteger row = [indexPath row];
    NSString *imgurl = [self.list objectAtIndex:row];
    NSURL *url = [NSURL URLWithString:imgurl];
         
    AsyncImageView *oldImg = (AsyncImageView *)[cell.contentView viewWithTag:999];
    [oldImg removeFromSuperview];
         
    CGRect frame = CGRectMake(0, 0, 44, 44);
    // 创建异步图片视图
    AsyncImageView* asyncImage = [[AsyncImageView alloc] initWithFrame:frame];    
    asyncImage.tag =999;  
    // 加载异步图片
    [asyncImage loadImageFromURL:url];    
    [cell.contentView addSubview:asyncImage];    
       
    NSLog(@"图片地址：%@",imgurl);
    
    return cell;
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
