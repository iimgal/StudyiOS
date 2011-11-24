//
//  ContactViewController.m
//  StudyiOS
//
//  Created by  on 11-10-6.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "ContactViewController.h"

@implementation ContactViewController

@synthesize label;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    // 增加Code按钮，可跳转至教学页面
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Code" style:UIBarButtonItemStyleBordered target:self action:@selector(code)];
    self.navigationItem.rightBarButtonItem = item;
    
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    self.label = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark -
#pragma mark Show all contacts
// Called when users tap "Display Picker" in the application. Displays a list of contacts and allows users to select a contact from that list.
// The application only shows the phone, email, and birthdate information of the selected contact.
-(void)showPeoplePickerController
{
    // 查看联系人
	ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
	// Display only a person's phone, email, and birthdate
	NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty], 
                               [NSNumber numberWithInt:kABPersonEmailProperty],
                               [NSNumber numberWithInt:kABPersonBirthdayProperty], nil];
	
	picker.displayedProperties = displayedItems;
	// Show the picker 
	[self presentModalViewController:picker animated:YES];

}


#pragma mark Display and edit a person
// Called when users tap "Display and Edit Contact" in the application. Searches for a contact named "Appleseed" in 
// in the address book. Displays and allows editing of all information associated with that contact if
// the search is successful. Shows an alert, otherwise.
-(void)showPersonViewController
{
	// 得到地址薄
	ABAddressBookRef addressBook = ABAddressBookCreate();
	// 寻找名为“CC”的联系人
	NSArray *people = (__bridge NSArray *)ABAddressBookCopyPeopleWithName(addressBook, CFSTR("CC"));
	// Display "Appleseed" information if found in the address book 
	if ((people != nil) && [people count])
	{
		ABRecordRef person = (__bridge ABRecordRef)[people objectAtIndex:0];
		ABPersonViewController *picker = [[ABPersonViewController alloc] init];
		picker.personViewDelegate = self;
		picker.displayedPerson = person;
		// Allow users to edit the person’s information
		picker.allowsEditing = YES;
		[self.navigationController pushViewController:picker animated:YES];
	}
	else 
	{
		// Show an alert if "Appleseed" is not in Contacts
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
														message:@"Could not find CC in the Contacts application" 
													   delegate:nil 
											  cancelButtonTitle:@"Cancel" 
											  otherButtonTitles:nil];
		[alert show];
	}
	
	CFRelease(addressBook);
}


#pragma mark Create a new person
// Called when users tap "Create New Contact" in the application. Allows users to create a new contact.
-(void)showNewPersonViewController
{
    // 新增联系人
	ABNewPersonViewController *picker = [[ABNewPersonViewController alloc] init];
	picker.newPersonViewDelegate = self;
	
	UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:picker];
	[self presentModalViewController:navigation animated:YES];
		
}


#pragma mark Add data to an existing person
// Called when users tap "Edit Unknown Contact" in the application. 
-(void)showUnknownPersonViewController
{
	ABRecordRef aContact = ABPersonCreate();
	CFErrorRef anError = NULL;
	ABMultiValueRef email = ABMultiValueCreateMutable(kABMultiStringPropertyType);
	bool didAdd = ABMultiValueAddValueAndLabel(email, @"John-Appleseed@mac.com", kABOtherLabel, NULL);
	
	if (didAdd == YES)
	{
		ABRecordSetValue(aContact, kABPersonEmailProperty, email, &anError);
		if (anError == NULL)
		{
			ABUnknownPersonViewController *picker = [[ABUnknownPersonViewController alloc] init];
			picker.unknownPersonViewDelegate = self;
			picker.displayedPerson = aContact;
			picker.allowsAddingToAddressBook = YES;
		    picker.allowsActions = YES;
			picker.alternateName = @"John Appleseed";
			picker.title = @"John Appleseed";
			picker.message = @"Company, Inc";
			
			[self.navigationController pushViewController:picker animated:YES];
		
		}
		else 
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
															message:@"Could not create unknown user" 
														   delegate:nil 
												  cancelButtonTitle:@"Cancel"
												  otherButtonTitles:nil];
			[alert show];
		}
	}	
	CFRelease(email);
	CFRelease(aContact);
}


#pragma mark ABPeoplePickerNavigationControllerDelegate methods
// Displays the information of a selected person
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker 
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    self.label.text = [IIAddressBook getFullName:person];
    //[self dismissModalViewControllerAnimated:YES];
    //return NO;
	return YES;
}


// Does not allow users to perform default actions such as dialing a phone number, when they select a person property.
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person 
								property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
	return NO;
}


// Dismisses the people picker and shows the application when users tap Cancel. 
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker;
{
	[self dismissModalViewControllerAnimated:YES];
}


#pragma mark ABPersonViewControllerDelegate methods
// Does not allow users to perform default actions such as dialing a phone number, when they select a contact property.
- (BOOL)personViewController:(ABPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person 
					property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifierForValue
{
	return NO;
}


#pragma mark ABNewPersonViewControllerDelegate methods
// Dismisses the new-person view controller. 
- (void)newPersonViewController:(ABNewPersonViewController *)newPersonViewController didCompleteWithNewPerson:(ABRecordRef)person
{
	[self dismissModalViewControllerAnimated:YES];
}


#pragma mark ABUnknownPersonViewControllerDelegate methods
// Dismisses the picker when users are done creating a contact or adding the displayed person properties to an existing contact. 
- (void)unknownPersonViewController:(ABUnknownPersonViewController *)unknownPersonView didResolveToPerson:(ABRecordRef)person
{
	[self dismissModalViewControllerAnimated:YES];
}


// Does not allow users to perform default actions such as emailing a contact, when they select a contact property.
- (BOOL)unknownPersonViewController:(ABUnknownPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person 
						   property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
	return NO;
}

// 跳转至教学页面
- (void)code
{
    CodeViewController *controller = [[CodeViewController alloc] initWithNibName:@"CodeViewController" bundle:nil];
    NSString *name = [NSString stringWithUTF8String:object_getClassName(self)];
    controller.className = name;
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
