//
//  UIScrollView+TouchScroll.m
//  Page
//
//  Created by  on 11-11-17.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "UIScrollView+TouchScroll.h"

@implementation UIScrollView (TouchScroll)

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate touchesBegan:touches withEvent:event];
}

@end
