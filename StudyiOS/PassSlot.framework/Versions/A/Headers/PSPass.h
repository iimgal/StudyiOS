//
//  PSPass.h
//  PassSlot
//
//  Created by PassSlot on 01.07.12.
//  Copyright (c) 2012 PassSlot. All rights reserved.
//

#import <UIKit/UIKit.h>

/** This class represents a Pass
 */
@interface PSPass : NSObject

/** @name Creating a Pass */

/** Creates and returns a pass with the given pass type and serial number
 
 The pass with the given pass type id and serial number must already exist on the server. If you want to create a pass use [PassSlot passFromTemplate:withValues:pass:]
 
 @param passTypeIdentifier An existing Pass Type ID
 @param serialNumber An existing pass serial number
 @return A PSPass with the given pass type and serial number
 */
+ (PSPass*) passWithPassType:(NSString*) passTypeIdentifier serialNumber:(NSString*) serialNumber;

/** @name Accessing Pass Attributes */

/** Returns the serial number
 @return The serial number of the pass
 */
- (NSString*) serialNumber;

/** Returns the pass type id
 @return The pass type id of the pass
 */
- (NSString*) passTypeIdentifier;

/** Returns the placeholder values
 
 If you create a pass using passWithPassType:serialNumber: you first have to retrieve the values from the server using [PassSlot valuesForPass:pass:] otherwise this method will return nil
 
 
 @return The place holder values which are used to describe the pass or nil if they were not yet retrieved from the server
 */
- (NSDictionary*) values;

/** Returns the images
 
 If you create a pass using passWithPassType:serialNumber: you first have to retrieve the images from the server using [PassSlot imagesForPass:pass:] otherwise this method will return nil
 
 
 @return An NSArray of PSImage of the pass or nil if they were not yet retrieved from the server
 */
- (NSArray*) images;

@end
