//
//  Single.h
//  StudyiOS
//
//  Created by  on 11-10-28.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Single : NSObject

@property (strong, nonatomic) NSString *string;

+ (Single *)shareSingle;
@end
