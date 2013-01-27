//
//  FacebookViewController.m
//  StudyiOS
//
//  Created by ZhangYiCheng on 13-1-26.
//  Copyright (c) 2013年 ZhangYiCheng. All rights reserved.
//

#import "FacebookViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "CenterViewController.h"
#import "IIViewDeckController.h"

@interface FacebookViewController ()

@end

@implementation FacebookViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    LeftViewController *leftController = [[LeftViewController alloc] initWithNibName:@"LeftViewController" bundle:nil];
    RightViewController* rightController = [[RightViewController alloc] initWithNibName:@"RightViewController" bundle:nil];
    
    CenterViewController *centerController = [[CenterViewController alloc] initWithNibName:@"CenterViewController" bundle:nil];
    centerController.delegate = self;
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:centerController];
    
    IIViewDeckController* deckController = [[IIViewDeckController alloc] initWithCenterViewController:nc leftViewController:leftController rightViewController:rightController];
    deckController.rightSize = 44;
    deckController.leftSize = 44;
    
    [self presentModalViewController:deckController animated:YES];
}

- (void)cancel {
    [self dismissModalViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
