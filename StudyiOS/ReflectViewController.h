//
//  ReflectViewController.h
//  StudyiOS
//
//  Created by  on 11-10-6.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReflectViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UIImageView *reflectView;
@property (strong, nonatomic) IBOutlet UIImageView *roundView;

@property (nonatomic, strong) IBOutlet UISlider *alphaSlider;
@property (nonatomic, strong) IBOutlet UISlider *heightSlider;

- (IBAction)alphaSliderChanged;
- (IBAction)heightSliderChanged;


@end
