//
//  AccelerometerViewController.h
//  StudyiOS
//
//  Created by  on 11-10-13.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//


#import <UIKit/UIKit.h>

@class GraphView;
@class AccelerometerFilter;

@interface AccelerometerViewController : UIViewController<UIAccelerometerDelegate>
{
	GraphView *unfiltered;
	GraphView *filtered;
	UIButton *pause;
	UILabel *filterLabel;
	AccelerometerFilter *filter;
	BOOL isPaused, useAdaptive;
}

@property(nonatomic, strong) IBOutlet GraphView *unfiltered;
@property(nonatomic, strong) IBOutlet GraphView *filtered;
@property(nonatomic, strong) IBOutlet UIButton *pause;
@property(nonatomic, strong) IBOutlet UILabel *filterLabel;

-(IBAction)pauseOrResume:(id)sender;
-(IBAction)filterSelect:(id)sender;
-(IBAction)adaptiveSelect:(id)sender;

@end