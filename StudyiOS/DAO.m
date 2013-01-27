//
//  DAO.m
//  StudyiOS
//
//  Created by ZhangYiCheng on 13-1-23.
//  Copyright (c) 2013年 ZhangYiCheng. All rights reserved.
//

#import "DAO.h"
#import "AppDelegate.h"

@implementation DAO

static DAO *dao = nil;

- (id)init {
    self = [super init];
    if (self) {
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _managedObjectContext = delegate.managedObjectContext;
    }
    return self;
}

+ (DAO *)shareDAO {
    if (!dao) {
        dao = [[DAO alloc] init];
    }
    return dao;
}

- (BOOL)saveObject {
    NSError *error;
    [self.managedObjectContext save:&error];
    if (error) {
        NSLog(@"Save fault! Error msg: %@", [error description]);
        return NO;
    }
    return YES;
}

- (NSManagedObject *)insertObject:(NSString *)managedObjectName {
    
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:managedObjectName inManagedObjectContext:self.managedObjectContext];
    
    return newManagedObject;
}

- (NSArray *)queryObjectWithEntityName:(NSString *)entityName {
    
}

@end
