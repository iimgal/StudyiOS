//
//  IIFunction.h
//  StudyiOS
//  常用方法
//  Created by  on 11-10-14.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IIFunction : NSObject

// 检查URL格式，并补完
+ (NSURL *)smartURLForString:(NSString *)str;   
// 得到临时文件路径
+ (NSString *)pathForTemporaryFileWithPrefix:(NSString *)prefix;   
// 检查文件类型是否匹配
+ (BOOL)isHTTPContentType:(NSString *)prefixStr contextType:(NSString *)contextType;    

@end
