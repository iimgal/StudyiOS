//
//  CenterViewController.m
//  StudyiOS
//
//  Created by ZhangYiCheng on 13-1-26.
//  Copyright (c) 2013年 ZhangYiCheng. All rights reserved.
//

#import "CenterViewController.h"
#import "IIViewDeckController.h"

@interface CenterViewController ()

@end

@implementation CenterViewController

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
    
    self.title = @"Facebook";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
}

- (void)cancel {
    [_delegate cancel];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    if (location.x < 160) {
        [self.viewDeckController closeLeftView];
        [self.viewDeckController previewBounceView:IIViewDeckLeftSide];
    } else {
        [self.viewDeckController closeRightView];
        [self.viewDeckController previewBounceView:IIViewDeckRightSide];
    }
}

@end
