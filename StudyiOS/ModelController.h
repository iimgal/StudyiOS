//
//  ModelController.h
//  Test
//
//  Created by ZhangYiCheng on 13-1-19.
//  Copyright (c) 2013年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;

@end
