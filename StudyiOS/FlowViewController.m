//
//  FlowViewController.m
//  StudyiOS
//
//  Created by ZhangYiCheng on 12-12-6.
//  Copyright (c) 2012年 ZhangYiCheng. All rights reserved.
//

#import "FlowViewController.h"
#import "FlowViewCell.h"
#import "DefineViewController.h"

@interface FlowViewController ()

@end

@implementation FlowViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _items = @[];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
    

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
    return [FlowViewCell heightForCell:self.items[indexPath.row]];
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
    BOOL isAnimate = YES;
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
            [self.navigationController pushViewController:VC animated:isAnimate];
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
    } else if ([demoUUID isEqualToString:@"Page"]) {
        VC = [[PageViewController alloc] initWithNibName:@"PageViewController" bundle:nil];
    }
    
    // Popular
    if ([demoUUID isEqualToString:@"Path"]) {
        VC = [[PathViewController alloc] initWithNibName:@"PathViewController" bundle:nil];
    } else if ([demoUUID isEqualToString:@"Pinterest"]) {
        VC = [[PinterestViewController alloc] initWithNibName:@"PinterestViewController" bundle:nil];
    } else if ([demoUUID isEqualToString:@"Facebook"]) {
        VC = [[FacebookViewController alloc] initWithNibName:@"FacebookViewController" bundle:nil];
        isAnimate = NO;
    } else if ([demoUUID isEqualToString:@"Clear"]) {
        VC = [[ClearViewController alloc] initWithNibName:@"ClearViewController" bundle:nil];
    }

    if (VC) {
        VC.title = demoUUID;
        [self.navigationController pushViewController:VC animated:isAnimate];
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
