//
//  ViewController.m
//  CoreImage
//
//  Created by  on 11-11-13.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CoreImageViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreImage/CoreImage.h>

@interface CoreImageViewController()

@property (strong, nonatomic) CIContext *context;
@property (strong, nonatomic) CIFilter *filter;
@property (strong, nonatomic) CIFilter *filter2;
@property (strong, nonatomic) CIImage *beginImage;

- (void)logAllFilters;

@end

@implementation CoreImageViewController

#pragma mark - View lifecycle
- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setSlider:nil];
    self.context = nil;
    self.filter = nil;
    self.filter2 = nil;
    self.beginImage = nil;
    [self setSlider2:nil];
    [super viewDidUnload];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 打印所有过滤器信息
    [self logAllFilters];
    
    // 得到图片路径创建CIImage对象
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"girl" ofType:@"png"];
    NSURL *fileNameAndPath = [NSURL fileURLWithPath:filePath];
    self.beginImage = [CIImage  imageWithContentsOfURL:fileNameAndPath];
    
    // 创建基于GPU的CIContext对象
    CIContext *context = [CIContext contextWithOptions: nil];
    self.context = context;
    
    // 创建基于CPU的CIContext对象
    //context = [CIContext contextWithOptions: [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:kCIContextUseSoftwareRenderer]];
    
    // 创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"];
    CIFilter *filter2 = [CIFilter filterWithName:@"CIHueAdjust"];
    self.filter = filter;
    self.filter2 = filter2;
    
    // 设置界面
    self.slider.minimumValue = 0.0;
    self.slider.maximumValue = 1.0;
    self.slider.value = 0.0;
    
    self.slider2.minimumValue = -3.14;
    self.slider2.maximumValue = 3.14;
    self.slider2.value = 0.0;
    
    [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
    self.imageView.image = [UIImage imageNamed:@"girl"];
    
}

// 打印所有过滤器信息
- (void)logAllFilters {
    NSArray *properties = [CIFilter filterNamesInCategory:
                           kCICategoryBuiltIn];
    NSLog(@"FilterName:\n%@", properties);
    for (NSString *filterName in properties) {
        CIFilter *fltr = [CIFilter filterWithName:filterName];
        NSLog(@"%@:\n%@", filterName, [fltr attributes]);
    }
}

- (IBAction)changeValue:(id)sender 
{
    self.slider2.value = 0.0;
    float slideValue = self.slider.value;
    // 设置过滤器参数
    [self.filter setValue:self.beginImage forKey:kCIInputImageKey];
    [self.filter setValue:[NSNumber numberWithFloat:slideValue] forKey:@"inputIntensity"];

    // 得到过滤后的图片
    CIImage *outputImage = [self.filter outputImage];
    
    // 转换图片
    CGImageRef cgimg = [self.context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    
    // 显示图片
    [self.imageView setImage:newImg];
    // 释放C对象
    CGImageRelease(cgimg);

}

- (IBAction)changeValue2:(id)sender 
{
    self.slider.value = 0.0;
    
    float slideValue = self.slider2.value;
    // 设置过滤器参数
    [self.filter2 setValue:self.beginImage forKey:kCIInputImageKey];
    [self.filter2 setValue:[NSNumber numberWithFloat:slideValue] forKey:@"inputAngle"];

    // 得到过滤后的图片
    CIImage *outputImage = [self.filter2 outputImage];
    // 转换图片
    CGImageRef cgimg = [self.context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];    
    // 显示图片
    [self.imageView setImage:newImg];
    // 释放C对象
    CGImageRelease(cgimg);
}


- (IBAction)loadPhoto:(id)sender 
{
    UIImagePickerController *pickerC = 
    [[UIImagePickerController alloc] init];
    pickerC.delegate = self;
    [self presentModalViewController:pickerC animated:YES];
}

- (IBAction)savePhoto:(id)sender 
{
    CIImage *saveToSave = [self.filter outputImage];
    CGImageRef cgImg = [self.context createCGImage:saveToSave fromRect:[saveToSave extent]];
    
    ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
    [library writeImageToSavedPhotosAlbum:cgImg 
                                 metadata:[saveToSave properties] 
                          completionBlock:^(NSURL *assetURL, NSError *error) {
                              CGImageRelease(cgImg);
                          }];
}

- (IBAction)resetImage:(id)sender 
{
    // 得到图片路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"girl" ofType:@"png"];
    
    // 创建CIImage对象
    NSURL *fileNameAndPath = [NSURL fileURLWithPath:filePath];
    self.beginImage = [CIImage imageWithContentsOfURL:fileNameAndPath];
    
    // 设置界面
    self.slider.value = 0.0;
    self.slider2.value = 0.0;
    self.imageView.image = [UIImage imageWithContentsOfFile:filePath];
}

#pragma mark UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info 
{
    [self dismissModalViewControllerAnimated:YES];
    
    UIImage *gotImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.beginImage = [CIImage imageWithCGImage:gotImage.CGImage];
    self.imageView.image = gotImage;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker 
{
    [self dismissModalViewControllerAnimated:YES];
}



@end
