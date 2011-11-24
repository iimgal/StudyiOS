//
//  IIDate.h
//  提供静态方法处理字符串与时间类型的相互转换
//  Created by ZhangYiCheng on 11-9-18.
//  Copyright 2011 ZhangYiCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kFormat @"YYYY-MM-dd HH:mm:ss"  // 时间格式 需要不同的格式可在此修改

@interface IIDate : NSObject {
    NSDateFormatter *formatter;    
}

@property (nonatomic, retain) NSDateFormatter *formatter;


// 得到当前时间的字符串
+ (NSString *)getNowDateString;

// 时间类型转字符串类型
+ (NSString *)getStringFromDate:(NSDate *)sdate;

// 字符串类型转时间类型
+ (NSDate *)getDateFromString:(NSString *)string;

@end
