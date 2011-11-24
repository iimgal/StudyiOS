#import "AddressBook/AddressBook.h"
#import "AddressBookUI/AddressBookUI.h"
// 实现以下委托
ABPeoplePickerNavigationControllerDelegate,
ABNewPersonViewControllerDelegate,
ABPersonViewControllerDelegate,
ABUnknownPersonViewControllerDelegate
// 查看联系人
ABPeoplePickerNavigationController *picker = 
    [[ABPeoplePickerNavigationController alloc] init];
// 得到地址薄
ABAddressBookRef addressBook = ABAddressBookCreate();
// 寻找名为“CC”的联系人
NSArray *people = (NSArray *)ABAddressBookCopyPeopleWithName(addressBook, CFSTR("CC"));
// 新增联系人
ABNewPersonViewController *picker = [[ABNewPersonViewController alloc] init];