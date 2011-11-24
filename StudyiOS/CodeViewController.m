//
//  CodeViewController.m
//  StudyiOS
//
//  Created by  on 11-10-30.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "CodeViewController.h"

@implementation CodeViewController
@synthesize className;
@synthesize textView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.navigationItem.title = @"Code";
    
    NSString *path = [[NSBundle mainBundle] pathForResource:self.className ofType:@"x"];
    NSString *kText = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    textView.text = kText;
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    self.className = nil;
    [self setTextView:nil];
    [super viewDidUnload];
}


@end
