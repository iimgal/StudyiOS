//
//  T320ViewController.m
//  StudyiOS
//
//  Created by  on 11-10-31.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "T320ViewController.h"

@implementation T320ViewController

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    self.dataSource = [TTSectionedDataSource dataSourceWithObjects:
                       @"TTTableViewController",
                       [TTTableTextItem itemWithText:@"Table No Nib" URL:@"tt://viewController/PhotoWallViewController"],
                       [TTTableTextItem itemWithText:@"Table with default NIB" URL:@"tt://nib/DemoTableViewController"],
                       [TTTableTextItem itemWithText:@"Table with specific NIB" URL:@"tt://nib/FooterTableViewController/DemoTableViewController"],
                       
                       @"Other",
                       [TTTableTextItem itemWithText:@"TTPostController" URL:@"tt://nib/DemoPostController"],
                       [TTTableTextItem itemWithText:@"TTViewController" URL:@"tt://nib/DemoViewController"],
                       
                       [TTTableTextItem itemWithText:@"TTMessageController" URL:@"tt://modal/DemoMessageController"],
                       //    [TTTableTextItem itemWithText:@"TTWebController" URL:@"tt://g"],
                       //    [TTTableTextItem itemWithText:@"TTPopupViewController" URL:@"tt://h"],
                       //
                       //    [TTTableTextItem itemWithText:@"TTPhotoViewController" URL:@"tt://i"],
                       //    [TTTableTextItem itemWithText:@"TTAlertViewController" URL:@"tt://k"],
                       //    [TTTableTextItem itemWithText:@"TTActionSheetController" URL:@"tt://viewController/TTActionSheetController"],
                       
                       nil];
    
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
//- (void)createModel {
//    
//}

@end
