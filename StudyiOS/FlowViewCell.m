//
//  FlowViewCell.m
//  StudyiOS
//
//  Created by ZhangYiCheng on 12-12-6.
//  Copyright (c) 2012年 ZhangYiCheng. All rights reserved.
//

#import "FlowViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "DAO.h"

#define kImageWidth         300.0f
#define kImageHeight        300.0f
#define kCellHeight         356.0f

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
    
    if (width == 0) {
        return kCellHeight;
    }
    
    CGFloat imageViewWidth = kImageWidth;
    CGFloat imageViewHeight = 0.0f;
    
    imageViewHeight = height/width*imageViewWidth;
    
    return kCellHeight + imageViewHeight - kImageHeight;
}

- (void)setCell:(NSDictionary *)dic {
    if (!self.demoUUID) {
//        self.flowTitleLabel.backgroundColor = [UIColor whiteColor];
        self.topView.layer.cornerRadius = 5;
        self.topView.layer.masksToBounds = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startTheDemo)];
        [self.flowImageView addGestureRecognizer:tap];
        
    }
    
    NSString *title = [dic objectForKey:@"title"];
    NSString *uuid = [dic objectForKey:@"uuid"];
    NSString *imageName = [dic objectForKey:@"image"];
    title = NSLocalizedString(title, nil);
    
    self.demoUUID = uuid;
    
    [self.flowTitleLabel setText:title];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    if (!image) {
        image = [UIImage imageNamed:@"flowdefault"];
    }
    self.flowImageView.image = image;
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
