//
//  ViewController.h
//  shejiao
//
//  Created by Steven on 12-11-17.
//  Copyright (c) 2012年 Steven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface SocialViewController : BaseViewController

@property (retain, nonatomic) IBOutlet UIButton *twitterButton;
@property (retain, nonatomic) IBOutlet UIButton *facebookButton;
@property (retain, nonatomic) IBOutlet UIButton *weiboButton;

- (IBAction)sendtotwitter:(id)sender;
- (IBAction)sendtoWeibo:(id)sender;
- (IBAction)sendtoFacebook:(id)sender;

@end
