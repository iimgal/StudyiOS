//
//  MoviePlayerViewController.m
//  StudyiOS
//
//  Created by  on 11-11-10.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "MoviePlayerViewController.h"
// Offsite resource Betty Boop Cinderella @Archive.org
#define PATHSTRING @"http://devimages.apple.com/iphone/samples/bipbop/gear1/prog_index.m3u8"

@implementation MoviePlayerViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle
- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 增加Code按钮，可跳转至教学页面
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Code" style:UIBarButtonItemStyleBordered target:self action:@selector(code)];
    self.navigationItem.rightBarButtonItem = item;

    NSString *path = [[NSBundle mainBundle] pathForResource:@"Movie" ofType:@"m4v"];
    NSURL *url = [NSURL fileURLWithPath:path];
    // 创建视频播放器
    MPMoviePlayerController* theMovie = [[MPMoviePlayerController alloc] initWithContentURL:url];
    // 设置文件类型
    [theMovie setMovieSourceType:MPMovieSourceTypeFile];
    // 设置UI
    CGRect viewInsetRect = CGRectInset ([self.view bounds], 0, 40);
    theMovie.view.frame = viewInsetRect;
    [self.view addSubview:theMovie.view];
    
    //theMovie.controlStyle = MPMovieControlStyleFullscreen;
    
    self.view.backgroundColor = [UIColor blackColor];
    // 开始播放
    [theMovie play];
}

// 跳转至教学页面
- (void)code
{
    CodeViewController *controller = [[CodeViewController alloc] initWithNibName:@"CodeViewController" bundle:nil];
    NSString *name = [NSString stringWithUTF8String:object_getClassName(self)];
    controller.className = name;
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
