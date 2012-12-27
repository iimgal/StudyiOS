//
//  PSImage.h
//  PassSlot
//
//  Created by Pascal Brogle on 17.11.12.
//  Copyright (c) 2012 PassSlot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PSImageType) {
    PSImageTypeIcon = 1,
    PSImageTypeBackground = 2,
    PSImageTypeLogo = 3,
    PSImageTypeThumbnail = 4,
    PSImageTypeFooter = 5,
    PSImageTypeStrip = 6
};

typedef NS_ENUM(NSUInteger, PSImageResolution) {
    PSImageResolutionNormal = 1,
    PSImageResolutionHigh = 2
};


/** This class represents an Image
 */
@interface PSImage : NSObject

/** @name Creating an Image */

/** Creates and returns an image containing image data 
 
 @param name The name of the file. The methods looks for name.png and name@2x.png in the application’s main bundle.
 @param type  Type of the image
 @return A PSImage with contents of name.png and name@2x.png if available
 */
+ (PSImage*) imageNamed:(NSString *)name ofType:(PSImageType)type;


/** Creates and returns an empty image
 
 @param type  Type of the image
 @return A PSImage
 */
+ (PSImage*) imageOfType:(PSImageType)type;

/** @name Access and modify image*/


/** Returns the image type
 @return The image type
 */
- (PSImageType) type;

/** Sets image data for the image
 
 @param image Image data
 @param resolution Image resolution
 */
- (void) setImage:(UIImage*)image forResolution:(PSImageResolution)resolution;

/** Get image data of the image
 
 @param resolution Image resolution
 @return UIImage if image data for resolution is available, nil otherwise
 */
- (UIImage*) image:(PSImageResolution)resolution;
@end
