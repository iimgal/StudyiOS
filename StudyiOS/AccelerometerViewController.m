//
//  AccelerometerViewController.m
//  StudyiOS
//
//  Created by  on 11-10-13.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "AccelerometerViewController.h"

#import "GraphView.h"
#import "AccelerometerFilter.h"

#define kUpdateFrequency	60.0
#define kLocalizedPause		NSLocalizedString(@"Pause","pause taking samples")
#define kLocalizedResume	NSLocalizedString(@"Resume","resume taking samples")

@interface AccelerometerViewController()

// Sets up a new filter. Since the filter's class matters and not a particular instance
// we just pass in the class and -changeFilter: will setup the proper filter.
-(void)changeFilter:(Class)filterClass;

@end

@implementation AccelerometerViewController

@synthesize unfiltered, filtered, pause, filterLabel;

// Implement viewDidLoad to do additional setup after loading the view.
-(void)viewDidLoad
{
	[super viewDidLoad];
    
    // 增加Code按钮，可跳转至教学页面
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Code" style:UIBarButtonItemStyleBordered target:self action:@selector(code)];
    self.navigationItem.rightBarButtonItem = item;
    
	isPaused = NO;
	useAdaptive = NO;
    // 设置过滤器
	[self changeFilter:[LowpassFilter class]];
    // 设置加速计采集频率(单位:秒)
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0 / kUpdateFrequency];
	// 设置委托(注意对象销毁时要将委托设置为空)
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
	
	[unfiltered setIsAccessibilityElement:YES];
	[unfiltered setAccessibilityLabel:NSLocalizedString(@"unfilteredGraph", @"")];
    
	[filtered setIsAccessibilityElement:YES];
	[filtered setAccessibilityLabel:NSLocalizedString(@"filteredGraph", @"")];
}

-(void)viewDidUnload
{
	[super viewDidUnload];
	self.unfiltered = nil;
	self.filtered = nil;
	self.pause = nil;
	self.filterLabel = nil;
}

// 本对象销毁时将Accelerometer的委托设置为空，否则会继续触发委托方法导致报错
- (void)dealloc 
{
    [[UIAccelerometer sharedAccelerometer] setDelegate:nil];
}

// 加速计委托方法，根据设置的采集频率定时调用
-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    //NSLog([NSString stringWithFormat:@"%@", [NSDate date]]);
           
    if (acceleration == nil) {
        return;
    }
	// Update the accelerometer graph view
	if(!isPaused)
	{
        // 过滤加速计数据
		[filter addAcceleration:acceleration];
        // 取3个方向的值
		[unfiltered addX:acceleration.x y:acceleration.y z:acceleration.z];
		// 过滤后绘图
        [filtered addX:filter.x y:filter.y z:filter.z];
	}
}
// 改变过滤器
-(void)changeFilter:(Class)filterClass
{
	// Ensure that the new filter class is different from the current one...
	if(filterClass != [filter class])
	{
		filter = [[filterClass alloc] initWithSampleRate:kUpdateFrequency cutoffFrequency:5.0];
		// Set the adaptive flag
		filter.adaptive = useAdaptive;
		// And update the filterLabel with the new filter name.
		filterLabel.text = filter.name;
	}
}
// 开始与暂停
-(IBAction)pauseOrResume:(id)sender
{
	if(isPaused)
	{
		// If we're paused, then resume and set the title to "Pause"
		isPaused = NO;
        [pause setTitle:kLocalizedPause forState:UIControlStateNormal];
        [pause resignFirstResponder];
	}
	else
	{
		// If we are not paused, then pause and set the title to "Resume"
		isPaused = YES;
        [pause setTitle:kLocalizedResume forState:UIControlStateNormal];
	}
	
	// Inform accessibility clients that the pause/resume button has changed.
	UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, nil);
}

-(IBAction)filterSelect:(id)sender
{
	if([sender selectedSegmentIndex] == 0)
	{
		// Index 0 of the segment selects the lowpass filter
		[self changeFilter:[LowpassFilter class]];
	}
	else
	{
		// Index 1 of the segment selects the highpass filter
		[self changeFilter:[HighpassFilter class]];
	}
    
	// Inform accessibility clients that the filter has changed.
	UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, nil);
}

-(IBAction)adaptiveSelect:(id)sender
{
	// Index 1 is to use the adaptive filter, so if selected then set useAdaptive appropriately
	useAdaptive = [sender selectedSegmentIndex] == 1;
	// and update our filter and filterLabel
	filter.adaptive = useAdaptive;
	filterLabel.text = filter.name;
	
	// Inform accessibility clients that the adaptive selection has changed.
	UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, nil);
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
