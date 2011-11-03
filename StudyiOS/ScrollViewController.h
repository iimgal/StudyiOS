//
//  ScrollViewController.h
//  StudyiOS
//
//  Created by  on 11-10-30.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Three20/Three20+Additions.h"


@interface ScrollViewController : TTViewController <TTScrollViewDataSource, TTScrollViewDelegate>

@property (strong, nonatomic) IBOutlet TTScrollView *scrollView;
@property (strong, nonatomic) IBOutlet TTPageControl *pageControl;
@end
