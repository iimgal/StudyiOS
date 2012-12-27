//
//  RefreshViewController.m
//  StudyiOS
//
//  Created by ZhangYiCheng on 12-12-10.
//  Copyright (c) 2012年 ZhangYiCheng. All rights reserved.
//

#import "RefreshViewController.h"

@interface RefreshViewController ()

@end

@implementation RefreshViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.items = [@[@"请下拉"] mutableCopy];
    // 初始化下拉控件
    self.refreshControl = [[UIRefreshControl alloc] init];
    // 设置标题
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    // 添加触发事件
    [self.refreshControl addTarget:self action:@selector(refreshDataStart) forControlEvents:UIControlEventValueChanged];
    
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

- (void)refreshDataStart {
    // 判断是否在刷新中
    if (self.refreshControl.refreshing) {
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"刷新中"];
        
        [self performSelector:@selector(refreshDataFinished) withObject:nil afterDelay:2.0f];
    }
    
}

- (void)refreshDataFinished {
    [self.items addObject:@"再拉"];
    // 刷新结束
    [self.refreshControl endRefreshing];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    
    [self.tableView reloadData];
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
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = self.items[indexPath.row];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
