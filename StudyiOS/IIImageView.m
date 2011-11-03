//
//  IIImageView.m
//  StudyiOS
//
//  Created by  on 11-10-11.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "IIImageView.h"
#import <QuartzCore/QuartzCore.h>

@implementation IIImageView

+ (Class) layerClass
{
    return [CAEAGLLayer class];
}


@end
