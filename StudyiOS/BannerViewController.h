//
//  BannerViewController.h
//  StudyiOS
//
//  Created by  on 11-11-8.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface BannerViewController : UIViewController <ADBannerViewDelegate>

@property (strong, nonatomic) IBOutlet ADBannerView *banner;
@end
