//
//  IIReflectionImage.h
//  StudyiOS
//  图片映射
//  源自官网样例 http://developer.apple.com/library/ios/#samplecode/Reflection/Introduction/Intro.html#//apple_ref/doc/uid/DTS40008063
//  Created by ZhangYiCheng on 11-9-29.
//  Copyright 2011 ZhangYiCheng. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IIReflectionImage : NSObject {

}

// 得到映射图片 入参fromImage:被映射的UIImageView height:映射的尺寸比例,1为不变形
+ (UIImage *)reflectedImage:(UIImageView *)fromImage withHeight:(NSUInteger)height; 

@end
