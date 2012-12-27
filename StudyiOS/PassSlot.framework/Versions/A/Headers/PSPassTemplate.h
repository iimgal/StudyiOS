//
//  PSPassTemplate.h
//  PassSlot
//
//  Created by PassSlot on 01.07.12.
//  Copyright (c) 2012 PassSlot. All rights reserved.
//

#import <UIKit/UIKit.h>

/** This class represents a Pass Template
 */
@interface PSPassTemplate : NSObject

/** @name Creating a Pass */

/** Returns the pass template id
 @return The pass template id
 */
- (NSNumber*) passTemplateId;

/** Returns the pass template placeholder
 @return A NSArray containing all placeholder names as NSString
 */
- (NSArray*) placeholder;

@end
