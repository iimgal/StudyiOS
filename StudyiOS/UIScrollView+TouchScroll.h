//
//  UIScrollView+TouchScroll.h
//  Page
//  UIScrollView响应单击事件
//  Created by  on 11-11-17.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (TouchScroll)

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end
