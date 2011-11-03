//
//  XMLViewController.h
//  StudyiOS
//
//  Created by  on 11-10-18.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDataXMLNode.h"

@interface XMLViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *levelField;
@property (strong, nonatomic) IBOutlet UITextField *classField;

- (IBAction)networkXML:(id)sender;
- (IBAction)localXML:(id)sender;
- (IBAction)saveXML:(id)sender;
@end
