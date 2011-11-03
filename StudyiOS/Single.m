//
//  Single.m
//  StudyiOS
//
//  Created by  on 11-10-28.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "Single.h"

static Single *single = nil;

@implementation Single
@synthesize string;

+ (Single *)shareSingle {
    if (single == nil) {
        single = [[Single alloc] init];
    }
    return single;
}

@end
