//
//  IIRoundedRect.h
//  StudyiOS
//
//  Created by  on 11-11-8.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IIImage : NSObject

// 得到映射图片 入参fromImage:被映射的UIImageView height:映射的尺寸比例,1为不变形
+ (UIImage *)reflectedImage:(UIImageView *)fromImage withHeight:(NSUInteger)height; 

// 得到圆角图片
+ (id) createRoundedRectImage:(UIImage*)image size:(CGSize)size;
@end
