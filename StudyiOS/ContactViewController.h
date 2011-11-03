//
//  ContactViewController.h
//  StudyiOS
//
//  Created by  on 11-10-6.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "IIAddressBook.h"

@interface ContactViewController : UIViewController<ABPeoplePickerNavigationControllerDelegate, 
ABNewPersonViewControllerDelegate,
ABPersonViewControllerDelegate,
ABUnknownPersonViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UILabel *label;

- (IBAction)showPeoplePickerController;
- (IBAction)showNewPersonViewController;
- (IBAction)showPersonViewController;
- (IBAction)showUnknownPersonViewController;


@end
