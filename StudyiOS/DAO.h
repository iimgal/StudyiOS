//
//  DAO.h
//  StudyiOS
//
//  Created by ZhangYiCheng on 13-1-23.
//  Copyright (c) 2013年 ZhangYiCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAO : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

+ (DAO *)shareDAO;
- (BOOL)saveObject;
- (NSManagedObject *)insertObject:(NSString *)managedObjectName;

@end
