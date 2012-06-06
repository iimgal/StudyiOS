//
//  IIAddressBook.m
//  StudyiOS
//
//  Created by ZhangYiCheng on 11-10-1.
//  Copyright 2011 ZhangYiCheng. All rights reserved.
//

#import "IIAddressBook.h"

@implementation IIAddressBook

// return label, but remove prefix and suffix in "_$!<Mobile>!$_"
+ (NSString *)getPhoneLabel:(ABMultiValueRef)phones index:(int)index
{
    CFStringRef origLabel = ABMultiValueCopyLabelAtIndex(phones, index);    
    
    CFStringRef localizedLabel = ABAddressBookCopyLocalizedLabel(origLabel);
    
    NSString* finalLabel = [NSString stringWithString:(__bridge NSString *)localizedLabel];  
    
    finalLabel = [finalLabel stringByReplacingOccurrencesOfString:@"_$!<" withString:@""];
    finalLabel = [finalLabel stringByReplacingOccurrencesOfString:@">!$_" withString:@""];    
    
    
    return finalLabel;
}

+ (NSDate*)copyModificationDate:(ABRecordRef)person
{
    NSDate* date = (__bridge NSDate *)ABRecordCopyValue(person, kABPersonModificationDateProperty);
    
    return date;
}

+ (NSString *)getFullName:(ABAddressBookRef)addressBook personId:(int)personId
{
    ABRecordRef personRef = ABAddressBookGetPersonWithRecordID(addressBook, personId);
    if (!personRef)
        return nil;
    else {
        return [IIAddressBook getFullName:personRef];
    }
}

+ (NSString *)getFullName:(ABRecordRef)person
{
    
    CFStringRef name = ABRecordCopyCompositeName(person);
    if (name == NULL){
        return [NSString stringWithString:@""];
    }
    
    NSString* ret = [NSString stringWithString:(__bridge NSString*)name];
    
    CFRelease(name);
    
    return ret;
}

+ (NSArray *)getPhonesWithAddressBook:(ABRecordID)personId addressBook:(ABAddressBookRef)addressBook
{
    ABRecordRef person = ABAddressBookGetPersonWithRecordID(addressBook, personId);
    if (person){
        return [IIAddressBook getPhones:person];
    }
    else {
        return nil;
    }
}

// get the first phone number to display
+ (BOOL)hasPhones:(ABRecordRef)person
{
    NSArray* phones = [IIAddressBook getPhones:person];
    if (phones != nil && [phones count] > 0){
        return YES;
    }
    else {
        return NO;
    }
}

+ (BOOL)hasEmails:(ABRecordRef)person
{
    NSArray* emails = [IIAddressBook getEmails:person];
    if (emails != nil && [emails count] > 0){
        return YES;
    }
    else {
        return NO;
    }
    
}

+ (NSArray *)getPhones:(ABRecordRef)person
{
    NSMutableArray* phoneList = [[NSMutableArray alloc] init];
    
    ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);    
    if (phones){
        int count = ABMultiValueGetCount(phones);
        for (CFIndex i = 0; i < count; i++) {
            //NSString *phoneLabel       = (__bridge NSString *)ABMultiValueCopyLabelAtIndex(phones, i);
            NSString *phoneNumber      = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phones, i);
            
            //NSLog(@"phone label (%@), number (%@)", phoneLabel, phoneNumber);
            
            [phoneList addObject:phoneNumber];

        }
    }
    CFRelease(phones);
    return phoneList;
}

+ (NSArray *)getEmailsWithAddressBook:(ABRecordID)personId addressBook:(ABAddressBookRef)addressBook
{
    ABRecordRef person = ABAddressBookGetPersonWithRecordID(addressBook, personId);
    if (person){
        return [IIAddressBook getEmails:person];
    }
    else {
        return nil;
    }
}

// can be refactored to the same implementation later
+ (NSArray *)getEmails:(ABRecordRef)person
{
    NSMutableArray* emailList = [[NSMutableArray alloc] init];
    
    ABMultiValueRef emails = ABRecordCopyValue(person, kABPersonEmailProperty);    
    if (emails){
        for (CFIndex i = 0; i < ABMultiValueGetCount(emails); i++) {
            NSString *label       = (__bridge NSString *)ABMultiValueCopyLabelAtIndex(emails, i);
            NSString *value      = (__bridge NSString *)ABMultiValueCopyValueAtIndex(emails, i);
            
            NSLog(@"email label (%@), number (%@)", label, value);
            
            [emailList addObject:value];

        }
    }
    CFRelease(emails);
    
    return emailList;
}

+ (UIImage*)getImageByPerson:(ABRecordRef)person
{
    UIImage* image = nil;
    
    if (ABPersonHasImageData(person)){
        
        NSData* data = (__bridge NSData *)ABPersonCopyImageData(person);
        image = [UIImage imageWithData:data];

    }
    
    return image;    
}

+ (UIImage*)getSmallImage:(ABRecordRef)person size:(CGSize)size
{
    UIImage* image = [IIAddressBook getImageByPerson:person];
    
    if (image != nil){
        // resize image
        //return [image imageByScalingAndCroppingForSize:size];
    }
    
    return nil;
}

+ (NSString*)getShortName:(ABRecordRef)person
{
    NSString* firstName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    NSString* lastName  = (__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    NSString* orgName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonOrganizationProperty);
    
    BOOL useOrgName = NO;
    
    if (firstName == nil && lastName == nil)
        useOrgName = YES;
    
    if (firstName == nil)
        firstName = @"";
    
    if (lastName == nil)
        lastName = @"";        
    
    NSString* fullName;
    
    if (useOrgName == NO){
        NSString* countryCode;
        //NSString* countryCode = [LocaleUtils getCountryCode];
        if (countryCode != nil && ( [countryCode isEqualToString:@"CN"] == YES ||
                                   [countryCode isEqualToString:@"TW"] == YES ||
                                   [countryCode isEqualToString:@"KR"] == YES ||
                                   [countryCode isEqualToString:@"JP"] == YES)                                  
            )
        {
            if ([lastName length] > 0){
                fullName = [NSString stringWithFormat:@"%@ %@", lastName, firstName];    
            }
            else {
                fullName = [NSString stringWithString:firstName];
            }
            
        }
        else {            
            if ([firstName length] > 0){
                fullName = [NSString stringWithFormat:@"%@", firstName];    
            }
            else {
                fullName = [NSString stringWithString:lastName];
            }
            
        }    
    }
    else {
        
        if (orgName == nil)
            orgName = @"";
        
        fullName = [NSString stringWithFormat:@"%@", orgName];
    }
    
    return fullName;
    
}

+ (BOOL)addPhone:(ABRecordRef)person phone:(NSString*)phone
{
    ABMutableMultiValueRef multi = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    
    CFErrorRef anError = NULL;
    
    // The multivalue identifier of the new value isn't used in this example,
    // multivalueIdentifier is just for illustration purposes.  Real-world
    // code can use this identifier to do additional work with this value.
    ABMultiValueIdentifier multivalueIdentifier;
    
    if (!ABMultiValueAddValueAndLabel(multi, (__bridge CFStringRef)phone, kABPersonPhoneMainLabel, &multivalueIdentifier)){
        CFRelease(multi);
        return NO;
    }
    
    if (!ABRecordSetValue(person, kABPersonPhoneProperty, multi, &anError)){
        CFRelease(multi);
        return NO;
    }
    CFRelease(multi);
    return YES;
}

+ (BOOL)addAddress:(ABRecordRef)person street:(NSString*)street
{
    ABMutableMultiValueRef address = ABMultiValueCreateMutable(kABDictionaryPropertyType);
    
    static int  homeLableValueCount = 5;
    
    // Set up keys and values for the dictionary.
    CFStringRef keys[homeLableValueCount];
    CFStringRef values[homeLableValueCount];
    keys[0]      = kABPersonAddressStreetKey;
    keys[1]      = kABPersonAddressCityKey;
    keys[2]      = kABPersonAddressStateKey;
    keys[3]      = kABPersonAddressZIPKey;
    keys[4]      = kABPersonAddressCountryKey;
    values[0]    = (__bridge CFStringRef)street;
    values[1]    = CFSTR("");
    values[2]    = CFSTR("");
    values[3]    = CFSTR("");
    values[4]    = CFSTR("");
    
    CFDictionaryRef aDict = CFDictionaryCreate(
                                               kCFAllocatorDefault,
                                               (void *)keys,
                                               (void *)values,
                                               homeLableValueCount,
                                               &kCFCopyStringDictionaryKeyCallBacks,
                                               &kCFTypeDictionaryValueCallBacks
                                               );
    
    // Add the street address to the person record.
    ABMultiValueIdentifier identifier;
    
    BOOL result = ABMultiValueAddValueAndLabel(address, aDict, kABHomeLabel, &identifier);    
    CFErrorRef error = NULL;
    result = ABRecordSetValue(person, kABPersonAddressProperty, address, &error);
    
    CFRelease(aDict);    
    CFRelease(address);    
    
    return result;
}

+ (BOOL)addImage:(ABRecordRef)person image:(UIImage*)image
{
    CFErrorRef error = NULL;
    
    // remove old image data firstly
    ABPersonRemoveImageData(person, NULL);
    
    // add new image data
    BOOL result = ABPersonSetImageData (
                                        person,
                                        (__bridge CFDataRef)UIImagePNGRepresentation(image),
                                        &error
                                        );    
    
    //    CFRelease(error);
    
    return result;
}

@end