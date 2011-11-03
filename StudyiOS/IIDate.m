//
//  IIDate.m
//
//  提供静态方法处理字符串与时间类型的相互转换
//  Created by ZhangYiCheng on 11-9-18.
//  Copyright 2011 ZhangYiCheng. All rights reserved.
//

#import "IIDate.h"

@implementation IIDate
@synthesize formatter;

static IIDate *singleDate = nil;


- (IIDate *)init {
    self.formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *zone = [NSTimeZone localTimeZone];
    [self.formatter setTimeZone:zone];
    [self.formatter setDateFormat:kFormat];
    return self;
}

// 得到当前时间的字符串类型值
+ (NSString *)getNowDateString {
    if (singleDate == nil) {
        singleDate = [[IIDate alloc] init];
    }
    return [singleDate.formatter stringFromDate:[NSDate date]];
}

// 时间类型转换成字符串类型
+ (NSString *)getStringFromDate:(NSDate *)sdate {
    if (singleDate == nil) {
        singleDate = [[IIDate alloc] init];
    }
    return [singleDate.formatter stringFromDate:sdate];
}

// 字符类型转换成时间类型
+ (NSDate *)getDateFromString:(NSString *)string {
    if (singleDate == nil) {
        singleDate = [[IIDate alloc] init];
    }
    return [singleDate.formatter dateFromString:string];
}

@end
