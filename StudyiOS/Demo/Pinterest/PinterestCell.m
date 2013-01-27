//
//  PinterestCell.m
//  StudyiOS
//
//  Created by ZhangYiCheng on 13-1-26.
//  Copyright (c) 2013年 ZhangYiCheng. All rights reserved.
//

#import "PinterestCell.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>

@implementation PinterestCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
//        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        [self addSubview:_imageView];
    }
    return self;
}

+ (CGFloat)heightForViewWithObject:(id)object inColumnWidth:(CGFloat)columnWidth {
    CGFloat objectWidth = [[object objectForKey:@"width"] floatValue];
    CGFloat objectHeight = [[object objectForKey:@"height"] floatValue];
    if (objectWidth == 0) {
        objectWidth = columnWidth;
    }
    if (objectHeight == 0) {
        objectHeight = columnWidth;
    }
    
    CGFloat imageHeight = objectHeight / objectWidth * columnWidth;
    
    return imageHeight;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.imageView.image = nil;
}

- (void)fillViewWithObject:(id)object {
    [super fillViewWithObject:object];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://i.imgur.com/%@%@", [object objectForKey:@"hash"], [object objectForKey:@"ext"]]];
    
    
    [self.imageView setImageWithURL:URL];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    NSLog(@"%f %f", self.imageView.frame.size.width, self.imageView.frame.size.height);
}

@end
