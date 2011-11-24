//
//  CameraViewController.m
//  StudyiOS
//
//  Created by  on 11-10-6.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "CameraViewController.h"

@implementation CameraViewController

@synthesize imageView;
@synthesize label;

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
    // 增加Code按钮，可跳转至教学页面
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Code" style:UIBarButtonItemStyleBordered target:self action:@selector(code)];
    self.navigationItem.rightBarButtonItem = item;
    
    [self.label setNumberOfLines:0];
    
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    self.imageView = nil;
    self.label = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


// 打开摄像头
- (IBAction)getCameraPicture:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker =
        [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        // 摄像头
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentModalViewController:picker animated:YES];
    }else {
        UIAlertView *alert = [[UIAlertView alloc] 
                              initWithTitle:@"Error" 
                              message:@"你没有摄像头" 
                              delegate:nil 
                              cancelButtonTitle:@"Drat!" 
                              otherButtonTitles:nil];
        [alert show];
    }
    
}

// 选取图片
- (IBAction)getExistintPicture:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker =
        [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        // 图片库
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentModalViewController:picker animated:YES];
        
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] 
                              initWithTitle:@"Error accessing photo library" 
                              message:@"Device does not support a photo library" 
                              delegate:nil 
                              cancelButtonTitle:@"Drat!" 
                              otherButtonTitles:nil];
        [alert show];
    }
}



// The picker does not dismiss itself; the client dismisses it in these callbacks.
// The delegate will receive one or the other, but not both, depending whether the user
// confirms or cancels.
// 4.1后不用这个方法了
//- (void)imagePickerController:(UIImagePickerController *)picker 
//        didFinishPickingImage:(UIImage *)image 
//                  editingInfo:(NSDictionary *)editingInfo {
//    imageView.image = image;
//    [picker dismissModalViewControllerAnimated:YES];
//
//}

- (void)imagePickerController:(UIImagePickerController *)picker 
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.label.text = @"";
    
    // 得到图片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage]; 
    
    // 获得照片详细信息
    NSDictionary *media = [info objectForKey:UIImagePickerControllerMediaMetadata];
    if (media != nil) {
        NSNumber *DPIHeight = [media objectForKey:@"DPIHeight"];
        NSNumber *DPIWidth = [media objectForKey:@"DPIWidth"];
        NSNumber *Orientation = [media objectForKey:@"Orientation"];
        
        NSDictionary *Exif = [media objectForKey:@"{Exif}"];
        NSNumber *ColorSpace = [Exif objectForKey:@"ColorSpace"];
        NSNumber *PixelYDimension = [Exif objectForKey:@"PixelYDimension"];
        NSString *DateTimeOriginal = [Exif objectForKey:@"DateTimeOriginal"];
        NSString *DateTimeDigitized = [Exif objectForKey:@"DateTimeDigitized"];
        NSNumber *PixelXDimension = [Exif objectForKey:@"PixelXDimension"];
        
        NSDictionary *TIFF = [media objectForKey:@"{TIFF}"];
        NSString *Make = [TIFF objectForKey:@"Make"];
        NSString *Model = [TIFF objectForKey:@"Model"];
        NSNumber *YResolution = [TIFF objectForKey:@"YResolution"];
        NSString *DateTime = [TIFF objectForKey:@"DateTime"];
        NSString *Software = [TIFF objectForKey:@"Software"];
        NSNumber *XResolution = [TIFF objectForKey:@"XResolution"];
        
        self.label.text = [NSString stringWithFormat:@"DPIHeight:%@ DPIWidth:%@ Orientation:%@\nColorSpace:%@ PixelXDimension:%@ PixelYDimension:%@ DateTimeOriginal:%@ DateTimeDigitized:%@\nMake:%@ Model:%@ XResolution:%@ YResolution:%@ DateTime:%@ Software:%@", 
                           DPIHeight, DPIWidth, Orientation,
                           ColorSpace, PixelXDimension, PixelYDimension, DateTimeOriginal, DateTimeDigitized,
                           Make, Model, XResolution, YResolution, DateTime, Software];
    }
    
    imageView.image = image;
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:YES];
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
