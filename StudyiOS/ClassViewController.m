//
//  ClassViewController.m
//  StudyiOS
//
//  Created by ZhangYiCheng on 12-12-3.
//  Copyright (c) 2012年 ZhangYiCheng. All rights reserved.
//

#import "ClassViewController.h"
#import "FlowViewController.h"

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
    
    [self setTitle:NSLocalizedString(@"DevGuide", nil)];
    
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSDictionary *dic = self.items[indexPath.row];
    cell.textLabel.text = dic[@"type"];
    cell.imageView.image = [UIImage imageNamed:dic[@"type"]];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = self.items[indexPath.row][@"type"];
    // 跳转到旧版本
    if ([str isEqualToString:@"Basic"]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        [self.navigationController pushViewController:storyboard.instantiateInitialViewController animated:YES];
        
    } else {
        [self performSegueWithIdentifier:@"classflow" sender:nil];
    }
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"classflow"]) {
        
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        NSDictionary *dic = self.items[path.row];
        NSMutableArray *mutItems = [@[] mutableCopy];
        if ([dic[@"type"] isEqualToString:@"All"]) {
            
            for (NSDictionary *one in self.items) {
                if ([one[@"type"] isEqualToString:@"All"] || [one[@"type"] isEqualToString:@"Basic"]) {
                    continue;
                }
                [mutItems addObjectsFromArray:one[@"items"]];
            }
        } else {
            mutItems = dic[@"items"];
        }
        
        NSString *title = dic[@"type"];
        
        FlowViewController *vc = (FlowViewController *)segue.destinationViewController;
        
        [vc setTitle:title];
        [vc setItems:mutItems];
    }
}

@end
