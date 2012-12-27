//
//  FlowViewController.m
//  StudyiOS
//
//  Created by ZhangYiCheng on 12-12-6.
//  Copyright (c) 2012年 ZhangYiCheng. All rights reserved.
//

#import "FlowViewController.h"
#import "FlowViewCell.h"
#import "SocialViewController.h"
#import "RefreshViewController.h"
#import "ActivityViewController.h"
#import "CollectionViewController.h"
#import "MapViewController.h"
#import "PassbookViewController.h"
#import "CustomizationViewController.h"
#import "CoreImageViewController.h"

@interface FlowViewController ()

@end

@implementation FlowViewController

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

    NSString *path = [[NSBundle mainBundle] pathForResource:@"Flow.plist" ofType:nil];
    self.items = [NSArray arrayWithContentsOfFile:path];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    FlowViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    [cell setCell:[self.items objectAtIndex:[indexPath row]]];
    cell.flowViewCellDelegate = self;
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - FlowViewCellDelegate
- (void)flowViewCell:(FlowViewCell *)cell startDemo:(NSString *)demoUUID {
    UIViewController *VC = nil;
    
    // iOS6
    if ([demoUUID isEqualToString:@"Social"]) {
        VC = [[SocialViewController alloc] initWithNibName:@"SocialViewController" bundle:nil];
    } else if ([demoUUID isEqualToString:@"Refresh"]) {
        VC = [[RefreshViewController alloc] initWithNibName:@"RefreshViewController" bundle:nil];
    } else if ([demoUUID isEqualToString:@"Activity"]) {
        VC = [[ActivityViewController alloc] initWithNibName:@"ActivityViewController" bundle:nil];
    } else if ([demoUUID isEqualToString:@"Collection"]) {
        VC = [[CollectionViewController alloc] initWithNibName:@"CollectionViewController" bundle:nil];
    } else if ([demoUUID isEqualToString:@"Map"]) {
        VC = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    } else if ([demoUUID isEqualToString:@"Passbook"]) {
        VC = [[PassbookViewController alloc] initWithNibName:@"PassbookViewController" bundle:nil];
    }
    
    // 判断iOS版本
    if (VC) {
        if ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue] >= 6) {
            VC.title = demoUUID;
            [self.navigationController pushViewController:VC animated:YES];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"这是iOS6的新特性" message:@"请升级到iOS6" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        return;
    }
    
    // iOS5
    if ([demoUUID isEqualToString:@"Customization"]) {
        [self customization];
        return;
    } else if ([demoUUID isEqualToString:@"CoreImage"]) {
        VC = [[CoreImageViewController alloc] initWithNibName:@"CoreImageViewController" bundle:nil];
    }
    
    if (VC) {
        VC.title = demoUUID;
        [self.navigationController pushViewController:VC animated:YES];
    }
}

- (void)customization {
    CustomizationViewController *vc0 = [[CustomizationViewController alloc] initWithNibName:@"CustomizationViewController" bundle:nil];
    UINavigationController *vc1 = [[UINavigationController alloc] initWithRootViewController:vc0];
    [vc1 setTabBarItem:[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:100]];
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    [vc2 setTabBarItem:[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:101]];
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    [vc3 setTabBarItem:[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:102]];
    
    UITabBarController *VC = [[UITabBarController alloc] init];
    [(UITabBarController *)VC setViewControllers:[NSArray arrayWithObjects:vc1, vc2, vc3, nil]];
    
    [self presentModalViewController:VC animated:YES];
}

@end
