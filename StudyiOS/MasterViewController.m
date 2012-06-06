//
//  MasterViewController.m
//  StudyiOS
//
//  Created by  on 12-4-25.
//  Copyright (c) 2012年 ZhangYiCheng. All rights reserved.
//

#import "MasterViewController.h"

@interface MasterViewController ()

@end

@implementation MasterViewController
@synthesize list = _list;
@synthesize nameList = _nameList;

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
    
    //字符串不允许修改
    NSArray *list1 = [NSArray arrayWithObjects:
                      NSLocalizedString(@"Contact", nil), 
                      NSLocalizedString(@"Camera", nil), 
                      NSLocalizedString(@"Accelerometer", nil), 
                      nil];
    NSArray *list2 = [NSArray arrayWithObjects:
                      NSLocalizedString(@"NetConn", nil), 
                      NSLocalizedString(@"ASIHTTP", nil), 
                      NSLocalizedString(@"AsyncSocket", nil), 
                      nil];
    NSArray *list3 = [NSArray arrayWithObjects:
                      NSLocalizedString(@"XML", nil), 
                      NSLocalizedString(@"JSON", nil), 
                      NSLocalizedString(@"HTML", nil), 
                      nil];
    NSArray *list4 = [NSArray arrayWithObjects:
                      NSLocalizedString(@"Audio", nil), 
                      NSLocalizedString(@"Video", nil), 
                      nil];
    NSArray *list5 = [NSArray arrayWithObjects:
                      NSLocalizedString(@"Scroll", nil), 
                      NSLocalizedString(@"PullRefresh", nil), 
                      NSLocalizedString(@"AsyncImage", nil), 
                      NSLocalizedString(@"Keyboard", nil), 
                      NSLocalizedString(@"Banner", nil), 
                      NSLocalizedString(@"Progress", nil), 
                      nil];
    NSArray *list6 = [NSArray arrayWithObjects:
                      NSLocalizedString(@"Animation", nil), 
                      NSLocalizedString(@"Reflect", nil), 
                      NSLocalizedString(@"CoreImage", nil), 
                      NSLocalizedString(@"Path", nil), 
                      nil];
    NSArray *list7 = [NSArray arrayWithObjects:
                      NSLocalizedString(@"Notification", nil), 
                      nil];
    
    NSArray *nameList = [NSArray arrayWithObjects:
                         NSLocalizedString(@"System", nil), 
                         NSLocalizedString(@"Network", nil), 
                         NSLocalizedString(@"FileParse", nil), 
                         NSLocalizedString(@"Media", nil), 
                         NSLocalizedString(@"UIDesign", nil), 
                         NSLocalizedString(@"Advanced", nil), 
                         NSLocalizedString(@"Others", nil), 
                         nil];
    
    NSArray *list = [NSArray arrayWithObjects:list1, list2, list3, list4, list5, list6, list7, nil];
    
    self.list = list;
    self.nameList = nameList;
}

- (void)viewDidUnload
{
    self.list = nil;
    self.nameList = nil;
    [super viewDidUnload];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.list count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.nameList objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self.list objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    cell.textLabel.text = [[self.list objectAtIndex:section] objectAtIndex:row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    [self performSegueWithIdentifier:[[self.list objectAtIndex:section] objectAtIndex:row] sender:nil];
}

@end
