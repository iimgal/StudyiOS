//
//  IIAddressBook.h
//  StudyiOS
//  提供解析通讯录数据的一系列方法
//  源自皮皮彭的代码 http://www.cocoachina.com/bbs/read.php?tid-20938.html
//  Created by ZhangYiCheng on 11-10-1.
//  Copyright 2011 ZhangYiCheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

@interface IIAddressBook : NSObject {
    
}

// get label of phone number (e.g. Mobile, Home, etc)
+ (NSString *)getPhoneLabel:(ABMultiValueRef)phones index:(int)index;
// get full name of contact
+ (NSString *)getFullName:(ABAddressBookRef)addressBook personId:(int)personId;
+ (NSString *)getFullName:(ABRecordRef)person;
// get all phone numbers of one contact
+ (NSArray *)getPhones:(ABRecordRef)person;
// get all emails of one contact
+ (NSArray *)getEmails:(ABRecordRef)person;
// get image of contact
+ (UIImage*)getImageByPerson:(ABRecordRef)person;
+ (UIImage*)getSmallImage:(ABRecordRef)person size:(CGSize)size;
+ (NSString*)getShortName:(ABRecordRef)person;

+ (NSDate*)copyModificationDate:(ABRecordRef)person;
// set address into contact
+ (BOOL)addAddress:(ABRecordRef)person street:(NSString*)street;
// set phones into contact
+ (BOOL)addPhone:(ABRecordRef)person phone:(NSString*)phone;
// set image into contact
+ (BOOL)addImage:(ABRecordRef)person image:(UIImage*)image;

+ (NSArray *)getEmailsWithAddressBook:(ABRecordID)personId addressBook:(ABAddressBookRef)addressBook;

+ (NSArray *)getPhonesWithAddressBook:(ABRecordID)personId addressBook:(ABAddressBookRef)addressBook;

+ (BOOL)hasPhones:(ABRecordRef)person;

+ (BOOL)hasEmails:(ABRecordRef)person;

@end
