//
//  CoreImageViewController.h
//  StudyiOS
//
//  Created by  on 11-10-11.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreImageViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIImageView *imageView;

- (IBAction)buttonPressed:(id)sender;

- (NSMutableDictionary *)buildFilterDictionary: (NSArray *)names;
@end
