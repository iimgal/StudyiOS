//
//  PassSlot.h
//  PassSlot
//
//  Created by PassSlot on 01.07.12.
//  Copyright (c) 2012 PassSlot. All rights reserved.
//
//  SDK Version 0.4

#import <Foundation/Foundation.h>

#import <PassSlot/PSPass.h>
#import <PassSlot/PSPassTemplate.h>
#import <PassSlot/PSImage.h>


typedef void (^PSPassBlock)(PSPass* pass);
typedef void (^PSTemplateListBlock)(NSArray* templateList);
typedef void (^PSCompletion)(void);
typedef void (^PSErrorBlock)(NSError *error);


/** This class is the core of PassSlot.
 
 You can start PassSlot using your app key. You can then create passes from templates, change values of passes or add passes to passbook.
 
    [PassSlot start:@"<you app key>"];
 
    NSDictionary *values = [NSDictionary dictionaryWithObjectsAndKeys:
    @"John", @"firstName" ,
    @"Doe", @"lastName",
    @"2012", @"memberSince", nil];
 
    [PassSlot createPassFromTemplateWithName:@"Member Card" withValues:values
        andRequestInstallation:self completion:^{
        NSLog(@"PassSlot is SO EASY!");
    }];

 */
@interface PassSlot : NSObject {
    
}

/** @name Setting up PassSlot */

/** Starts the PassSlot engine
 
 You can get your app key by signing up at [passslot.com](http://developer.passslot.com)
 
 @param appKey Your App Key
 */
+ (void) start:(NSString*)appKey;


/** Gets the current app key
 @return Your app key
 */
+ (NSString*) appKey;


/** @name Creating a pass */

/** Create a pass from a template and request the installation of the pass
 @param template PassTemplate that is used to create the pass
 @param values Placeholder values that will be filled in
 @param viewController The UIViewController that will be used to present the PKAddPassesViewController. If the controller conforms to PKAddPassesViewControllerDelegate it is set as the delegate for the PKAddPassesViewController.
 @param completion A block object to be executed when the pass was added to passbook. This block takes no parameters and has no return value.
 */
+ (void) createPassFromTemplate:(PSPassTemplate*)template withValues:(NSDictionary*)values andRequestInstallation:(UIViewController*)viewController completion:(PSCompletion)completion;

/** Create a pass from a template name and request the installation of the pass
 @param templateName PassTemplate that is used to create the pass
 @param values Placeholder values that will be filled in
 @param viewController The UIViewController that will be used to present the PKAddPassesViewController. If the controller conforms to PKAddPassesViewControllerDelegate it is set as the delegate for the PKAddPassesViewController.
 @param completion A block object to be executed when the pass was added to passbook. This block takes no parameters and has no return value.
 */
+ (void) createPassFromTemplateWithName:(NSString*)templateName withValues:(NSDictionary*)values andRequestInstallation:(UIViewController*)viewController completion:(PSCompletion)completion;

/** Create a pass from a template and request the installation of the pass
 @param template PassTemplate that is used to create the pass
 @param values Placeholder values that will be filled in
 @param images Array of PSImage for the pass
 @param viewController The UIViewController that will be used to present the PKAddPassesViewController. If the controller conforms to PKAddPassesViewControllerDelegate it is set as the delegate for the PKAddPassesViewController.
 @param completion A block object to be executed when the pass was added to passbook. This block takes no parameters and has no return value.
 */
+ (void) createPassFromTemplate:(PSPassTemplate*)template withValues:(NSDictionary*)values withImages:(NSArray*)images andRequestInstallation:(UIViewController*)viewController completion:(PSCompletion)completion;

/** Create a pass from a template name and request the installation of the pass
 @param templateName PassTemplate that is used to create the pass
 @param values Placeholder values that will be filled in
 @param images Array of PSImage for the pass
 @param viewController The UIViewController that will be used to present the PKAddPassesViewController. If the controller conforms to PKAddPassesViewControllerDelegate it is set as the delegate for the PKAddPassesViewController.
 @param completion A block object to be executed when the pass was added to passbook. This block takes no parameters and has no return value.
 */
+ (void) createPassFromTemplateWithName:(NSString*)templateName withValues:(NSDictionary*)values withImages:(NSArray*)images andRequestInstallation:(UIViewController*)viewController completion:(PSCompletion)completion;

/** Create a pass from a template
 @param template PassTemplate that is used to create the pass
 @param values Placeholder values that will be filled in
 @param passBlock A block object to be executed when the pass was created. This block has no return value and takes a single PSPass argument which is the created pass
 */
+ (void) passFromTemplate:(PSPassTemplate*)template withValues:(NSDictionary*)values pass:(PSPassBlock)passBlock;

/** Create a pass from a template
 @param template PassTemplate that is used to create the pass
 @param values Placeholder values that will be filled in
 @param images Array of PSImage for the pass
 @param passBlock A block object to be executed when the pass was created. This block has no return value and takes a single PSPass argument which is the created pass
 */
+ (void) passFromTemplate:(PSPassTemplate*)template withValues:(NSDictionary*)values withImages:(NSArray*)images pass:(PSPassBlock)passBlock;


/** Create a pass from a template name
 @param templateName PassTemplate that is used to create the pass
 @param values Placeholder values that will be filled in
 @param passBlock A block object to be executed when the pass was created. This block has no return value and takes a single PSPass argument which is the created pass
 */
+ (void) passFromTemplateWithName:(NSString*)templateName withValues:(NSDictionary*)values pass:(PSPassBlock)passBlock;

/** Create a pass from a template name
 @param templateName PassTemplate that is used to create the pass
 @param values Placeholder values that will be filled in
 @param images Array of PSImage for the pass
 @param passBlock A block object to be executed when the pass was created. This block has no return value and takes a single PSPass argument which is the created pass
 */
+ (void) passFromTemplateWithName:(NSString*)templateName withValues:(NSDictionary*)values withImages:(NSArray*)images pass:(PSPassBlock)passBlock;


/** @name Modifing a pass instance*/

/** Update the values of an existing pass
 @param values Placeholder values that will be filled in
 @param pass Existing PSPass that should be updated
 @param passBlock A block object to be executed when the pass was updated. This block has no return value and takes a single PSPass argument which is the updated pass
 */
+ (void) setValues:(NSDictionary*)values forPass: (PSPass*)pass updatedPass:(PSPassBlock)passBlock;

/** Get the values of an existing pass
 @param pass PSPass for which the placeholder values should be retrieved
 @param passBlock A block object to be executed when the pass values were retrieved. This block has no return value and takes a single PSPass argument with the retrieved values
 */
+ (void) valuesForPass:(PSPass*)pass pass:(PSPassBlock)passBlock;

/** Update the images of an existing pass
 @param images NSArray of PSImage that will be used for the pass
 @param pass Existing PSPass that should be updated
 @param passBlock A block object to be executed when the pass was updated. This block has no return value and takes a single PSPass argument which is the updated pass
 */
+ (void) setImages:(NSArray*)images forPass:(PSPass*)pass updatedPass:(PSPassBlock)passBlock;

/** Get the images of an existing pass
 @param pass PSPass for which the images should be retrieved
 @param passBlock A block object to be executed when the pass values were retrieved. This block has no return value and takes a single PSPass argument with the retrieved values
 */
+ (void) imagesForPass:(PSPass*)pass pass:(PSPassBlock)passBlock;


/** @name Downloading Passes */

/** Download an existing pass
 @param pass PSPass which should be downloaded
 @param passBlock A block object to be executed when the pass file was downloaded. This block has no return value and takes a single PSPass argument with the downloaded pass file attached
 */
+ (void) downloadPass:(PSPass*)pass pass:(PSPassBlock)passBlock;

/** @name Adding Passes to Passbook */

/** Add an existing pass to Passbook
 
 If the pass file was not downloaded yet, this is done before adding the pass to passbook
 
 @param pass PSPass which should be added
 @param viewController The UIViewController that will be used to present the PKAddPassesViewController. If the controller conforms to PKAddPassesViewControllerDelegate it is set as the delegate for the PKAddPassesViewController.
 @param completion A block object to be executed when the pass was added to passbook. This block takes no parameters and has no return value.
 */
+ (BOOL) requestPassInstallation:(PSPass*)pass inViewController:(UIViewController*)viewController completion:(PSCompletion)completion;


/** @name Managing Pass Templates */

/** List all available pass templates
 
 @param templates A block object to be executed when the pass templates were retrieved. This block has no return value and takes a single NSArray argument containing all available PSPassTemplate 
 */
+ (void) listTemplates:(PSTemplateListBlock)templates;

/** @name Error handling */

/** Sets the error handler
 
 @param errorHandler A block object that handles errors
*/
+ (void) setErrorHandler:(PSErrorBlock)errorHandler;



@end