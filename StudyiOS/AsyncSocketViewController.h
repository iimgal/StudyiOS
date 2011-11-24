//
//  ViewController.h
//  Socket
//
//  Created by  on 11-11-15.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AsyncSocket;

@interface AsyncSocketViewController : UIViewController

@property (retain, nonatomic) AsyncSocket *client;
@property (retain, nonatomic) AsyncSocket *server;

- (IBAction)connectPressed:(id)sender;
- (IBAction)sendPressed:(id)sender;
@end
