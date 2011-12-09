//
//  ImageTableViewController.m
//  StudyiOS
//
//  Created by  on 11-11-4.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "ImageTableViewController.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
#import "SDWebImageDownloader.h"
#import "SDImageCache.h"

@implementation ImageTableViewController
@synthesize  list;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];

    // 增加Code按钮，可跳转至教学页面
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Code" style:UIBarButtonItemStyleBordered target:self action:@selector(code)];
    self.navigationItem.rightBarButtonItem = item;

    NSMutableArray *array = [[NSMutableArray alloc] 
                             initWithObjects:@"http://i.6.cn/cvbnm/98/70/47/f40590f07d9901e9106636259686fde7.jpg", 
                             @"http://face.weiphone.com/data/avatar/002/29/85/69_avatar_middle.jpg",
                             nil];
    
    self.list = array;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
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
    return [self.list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSInteger row = [indexPath row];
    NSString *imgurl = [self.list objectAtIndex:row];
    NSURL *url = [NSURL URLWithString:imgurl];
         
    [cell.imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"hold.png"]];
    cell.textLabel.text = @"My Text";
    
    return cell;
}

- (void)useSDWebImageManager
{
    NSString *path = @"http://face.weiphone.com/data/avatar/002/29/85/69_avatar_middle.jpg";
    NSURL *url = [NSURL URLWithString:path];
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    UIImage *cachedImage = [manager imageWithURL:url];
    if (cachedImage) {
        // Use the cached image immediatly 
    } else {
        // Start an async download
        [manager downloadWithURL:url delegate:self];
    }
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
    // Do something with the downloaded image
}

// 独立的异步图像下载
- (void)useSDWebImageDownloader
{
    NSString *path = @"http://face.weiphone.com/data/avatar/002/29/85/69_avatar_middle.jpg";
    NSURL *url = [NSURL URLWithString:path];
    
    SDWebImageDownloader *downloader = [SDWebImageDownloader downloaderWithURL:url delegate:self];
}

- (void)imageDownloader:(SDWebImageDownloader *)downloader didFinishWithImage:(UIImage *)image
{
    
}

// 独立的异步图像缓存
- (void)useSDImageCache
{
    // 寻找当前缓存
    UIImage *myCachedImage = [[SDImageCache sharedImageCache] imageFromKey:@"imgal1"];
    // 存储一个图像到缓存
    [[SDImageCache sharedImageCache] storeImage:myCachedImage forKey:@"imgal1"];
    // 默认情况下，图像将被存储在内存缓存和磁盘缓存中。如果仅仅是想内存缓存中，要使用
    [[SDImageCache sharedImageCache] storeImage:myCachedImage forKey:@"imgal1" toDisk:NO];
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
