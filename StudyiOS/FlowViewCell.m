//
//  FlowViewCell.m
//  StudyiOS
//
//  Created by ZhangYiCheng on 12-12-6.
//  Copyright (c) 2012年 ZhangYiCheng. All rights reserved.
//

#import "FlowViewCell.h"

@implementation FlowViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

+ (CGFloat)heightForCell:(NSDictionary *)dic {
    
    CGFloat width = [[dic objectForKey:@"width"] floatValue];
    CGFloat height = [[dic objectForKey:@"height"] floatValue];
    CGFloat imageViewWidth = kWidth;
    CGFloat imageViewHeight = 0.0f;
    
    if (width > 0) {
        imageViewHeight = height/width*imageViewWidth;
    } else {
        imageViewHeight = kWidth;
    }
    
    return imageViewHeight;
}

- (void)setCell:(NSDictionary *)dic {
    
    NSString *title = [dic objectForKey:@"title"];
    NSString *uuid = [dic objectForKey:@"uuid"];
    NSString *imageName = [dic objectForKey:@"image"];
    
    self.demoUUID = uuid;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    if (!image) {
        image = [UIImage imageNamed:@"girl"];
    }
    
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    
    CGFloat imageViewWidth = kWidth;
    CGFloat imageViewHeight = height/width*imageViewWidth;
    

    
    self.flowImageView.frame = CGRectMake(kMargin, kMargin, imageViewWidth, imageViewHeight);
    self.flowImageView.image = image;
    
    self.flowTitleLabel.frame = CGRectMake(0, self.flowImageView.frame.size.height + kMargin*2, 320, 20);
    self.flowTitleLabel.text = title;
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.flowTitleLabel.frame.origin.y + self.flowTitleLabel.frame.size.height);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startTheDemo)];
    [_flowImageView addGestureRecognizer:tap];
}

- (IBAction)fancied:(id)sender {
    
}

- (IBAction)add:(id)sender {
    
}

- (IBAction)comment:(id)sender {
    
}

- (void)startTheDemo {
    [self.flowViewCellDelegate flowViewCell:self startDemo:self.demoUUID];
}

@end
