//
//  IcloudViewController.m
//  StudyiOS
//
//  Created by  on 11-10-6.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "IcloudViewController.h"

@implementation IcloudViewController

@synthesize filePath;
@synthesize icloudURL;
@synthesize textView;
@synthesize label;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    // 文件名
    NSString *fileName = @"data.txt";
    
    // 得到文件管理器
    NSFileManager *manager = [NSFileManager defaultManager];
    
    // 验证iCloud是否激活
    NSURL *url = [manager URLForUbiquityContainerIdentifier:nil];
    if (url == nil) 
    {
        NSLog(@"iCloud未激活");
        return;
    }
    
    // 指定iCloud完整路径
    self.icloudURL = [NSURL URLWithString:fileName relativeToURL:url];
    
    // 得到本程序沙盒路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    self.filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];

    [super viewDidLoad];
}


- (void)viewDidUnload
{
    self.filePath = nil;
    self.icloudURL = nil;
    self.textView = nil;
    self.label = nil;
    [super viewDidUnload];
}

// 按下上传按钮
- (IBAction)uploadPressed:(id)sender
{
    // 另起一个线程上传
    [NSThread detachNewThreadSelector:@selector(uploadICloud) toTarget:self withObject:nil];
}

- (void)uploadICloud
{
    // 调用主进程的方法更新界面,在主进程外更新界面常会引起错误
    [self performSelectorOnMainThread:@selector(setString:)
                           withObject:@"开始上传"
                        waitUntilDone:NO];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSArray *data = [[NSArray alloc] initWithObjects:self.textView.text, nil];

    // 判断本地文件是否存在
    if (![manager fileExistsAtPath:self.filePath]) {
        // 不存在则创建
        if (![data writeToFile:self.filePath atomically:YES]) 
        {
            [self performSelectorOnMainThread:@selector(setString:)
                                   withObject:@"写本地文件失败"
                                waitUntilDone:NO];
        }
    }
    
    // 判断iCloud里该文件是否存在
    if ([manager isUbiquitousItemAtURL:self.icloudURL]) {
        // 存在则修改
        if (![data writeToURL:self.icloudURL atomically:YES]) 
        {
            [self performSelectorOnMainThread:@selector(setString:)
                                   withObject:@"写iCloud文件失败"
                                waitUntilDone:NO];
        }
        [self performSelectorOnMainThread:@selector(setString:)
                               withObject:@"上传成功"
                            waitUntilDone:NO];
        return;
    }
    
    // 上传至iCloud
    // 指定本地文件完整路径
    NSURL *url = [NSURL fileURLWithPath:self.filePath];
    NSError *error;
    // 官方文档建议本方法不要在主进程里执行
    if (![manager setUbiquitous:YES itemAtURL:url destinationURL:self.icloudURL error:&error]) 
    {
        NSLog(@"setUbiquitous error %@,\n%@", error, [error userInfo]);
        self.label.text = @"上传失败";
        return;
    }
    self.label.text = @"上传成功";
}

// 按下下载按钮
- (IBAction)downloadPressed:(id)sender
{
    self.label.text = @"开始下载";

    // 下载icloud文件
    if (![self downloadFileIfNotAvailable:self.icloudURL]) 
    {
        self.label.text = @"下载失败";
        return;
    }
    // 更新界面
    NSArray *array = [[NSArray alloc] initWithContentsOfURL:self.icloudURL];
    self.textView.text = [array objectAtIndex:0];
    
    self.label.text = @"下载成功";
}

// 此方法是官方文档提供,用来检查文件状态并下载
- (BOOL)downloadFileIfNotAvailable:(NSURL*)file {
    NSNumber*  isIniCloud = nil;
    
    if ([file getResourceValue:&isIniCloud forKey:NSURLIsUbiquitousItemKey error:nil]) {
        // If the item is in iCloud, see if it is downloaded.
        if ([isIniCloud boolValue]) {
            NSNumber*  isDownloaded = nil;
            if ([file getResourceValue:&isDownloaded forKey:NSURLUbiquitousItemIsDownloadedKey error:nil]) {
                if ([isDownloaded boolValue])
                    return YES;
                
                // Download the file.
                NSFileManager*  fm = [NSFileManager defaultManager];
                if (![fm startDownloadingUbiquitousItemAtURL:file error:nil]) {
                    return NO;
                }
                return YES;
            }
        }
    }
    
    // Return YES as long as an explicit download was not started.
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textView resignFirstResponder];
}

- (void)setString:(NSString *)string
{
    self.label.text = string;
}

@end
