//
//  Demo.h
//  StudyiOS
//
//  Created by ZhangYiCheng on 12-12-6.
//  Copyright (c) 2012年 ZhangYiCheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Demo : NSManagedObject

@property (nonatomic, retain) NSString * demoid;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * imagepath;
@property (nonatomic, retain) NSNumber * imagewidth;
@property (nonatomic, retain) NSNumber * imageheight;
@property (nonatomic, retain) NSNumber * isfancy;

@end
