//
//  ClassViewController.m
//  StudyiOS
//
//  Created by ZhangYiCheng on 12-12-3.
//  Copyright (c) 2012年 ZhangYiCheng. All rights reserved.
//

#import "ClassViewController.h"

@interface ClassViewController ()

@end

@implementation ClassViewController

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
    
    [self setTitle:@"StudyiOS"];
    
    self.items = @[@"iOS6", @"OLD"];

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.textLabel.text = [self.items objectAtIndex:[indexPath row]];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [self.items objectAtIndex:[indexPath row]];
    
    if ([str isEqualToString:@"OLD"]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        [self.navigationController pushViewController:storyboard.instantiateInitialViewController animated:YES];
        
        return;
    }
    
    [self performSegueWithIdentifier:@"classflow" sender:nil];
    
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    NSString *str = [self.items objectAtIndex:[path row]];
    UIViewController *VC = segue.destinationViewController;
    [VC setTitle:str];
}

@end
