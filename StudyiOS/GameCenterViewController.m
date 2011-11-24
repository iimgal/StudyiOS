//
//  GameCenterViewController.m
//  StudyiOS
//
//  Created by  on 11-11-21.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "GameCenterViewController.h"

//Leaderboard Category ID
#define kEasyLeaderboardID @"01"

//Achievement ID
#define kAchievementGotOneTap @"01"

@interface GameCenterViewController()
- (void) updateCurrentScore;
- (void) checkAchievements;
@end

@implementation GameCenterViewController
@synthesize score1;
@synthesize score2;
@synthesize highestName;
@synthesize score3;

@synthesize currentLeaderBoard;
@synthesize gameCenterManager;
@synthesize label1;
@synthesize label2;
@synthesize label3;
@synthesize label4;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - View lifecycle
- (void)dealloc
{
    NSLog(@"GameCenterViewController dealloc");
}

- (void)viewDidUnload
{
    self.currentLeaderBoard = nil;
    self.gameCenterManager = nil;
    self.highestName = nil;
    [self setLabel1:nil];
    [self setLabel2:nil];
    [self setLabel3:nil];
    [self setLabel4:nil];
    [super viewDidUnload];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 增加Code按钮，可跳转至教学页面
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Code" style:UIBarButtonItemStyleBordered target:self action:@selector(code)];
    self.navigationItem.rightBarButtonItem = item;

    self.currentLeaderBoard = kEasyLeaderboardID;
	
	self.score1= 0;
    self.label1.text = @"0";
	
    // 判断GameCenter是否可用，并初始化管理器
	if([GameCenterManager isGameCenterAvailable])
	{
		self.gameCenterManager= [[GameCenterManager alloc] init];
		[self.gameCenterManager setDelegate: self];
		[self.gameCenterManager authenticateLocalUser];
		
		[self updateCurrentScore];
        //[self.gameCenterManager reloadHighScoresForCategory: self.currentLeaderBoard];
	}
	else
	{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Center Support Required!" message:@"The current device does not support Game Center, which this sample requires." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
	}
}


// 更新当前分数
- (void) updateCurrentScore
{
	[self checkAchievements];
}

// 检查是否达成成就
- (void) checkAchievements
{
	NSString* identifier= NULL;
	double percentComplete= 0;
	switch(self.score1)
	{
		case 1:
		{
			identifier= kAchievementGotOneTap;
			percentComplete= 100.0;
			break;
		}
	}
	if(identifier!= NULL)
	{
        // 提交成就
		[self.gameCenterManager submitAchievement: identifier percentComplete: percentComplete];
	}
}

// 显示警告
- (void) showAlertWithTitle: (NSString*) title message: (NSString*) message
{
	UIAlertView* alert= [[UIAlertView alloc] initWithTitle: title message: message 
                                                   delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
	[alert show];
}

#pragma mark Action Methods
// 增加分数
- (IBAction) addOne
{
	self.score1 = self.score1 + 1;
    self.label1.text = [NSString stringWithFormat:@"%d", self.score1];
	[self updateCurrentScore];
}

// 提交分数
- (IBAction) submitHighScore
{
	if(self.score1 > 0)
	{
		[self.gameCenterManager reportScore: self.score1 forCategory: self.currentLeaderBoard];
	}
}

// 显示排行
- (IBAction) showLeaderboard
{
	GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
	if (leaderboardController != NULL) 
	{
		leaderboardController.category = self.currentLeaderBoard;
		leaderboardController.timeScope = GKLeaderboardTimeScopeAllTime;
		leaderboardController.leaderboardDelegate = self; 
		[self presentModalViewController: leaderboardController animated: YES];
	}
}

// 显示成就
- (IBAction) showAchievements
{
	GKAchievementViewController *achievements = [[GKAchievementViewController alloc] init];
	if (achievements != NULL)
	{
		achievements.achievementDelegate = self;
		[self presentModalViewController: achievements animated: YES];
	}
}

// 重置成就
- (IBAction) resetAchievements
{
	[gameCenterManager resetAchievements];
}

#pragma mark GameCenterManagerDelegate Methods
// 登陆GameCenter后回调
- (void) processGameCenterAuth: (NSError*) error
{
	if(error == NULL)
	{
        // 获得分数
		[self.gameCenterManager reloadHighScoresForCategory: self.currentLeaderBoard];
	}
	else
	{
		UIAlertView* alert= [[UIAlertView alloc] 
                             initWithTitle: @"Game Center Account Required" 
                             message: [NSString stringWithFormat: @"Reason: %@", [error localizedDescription]] 
                             delegate: nil 
                             cancelButtonTitle: @"Try Again..." 
                             otherButtonTitles: nil];
		[alert show];
	}
}

// 获得用户排名后回调
- (void) reloadScoresComplete: (GKLeaderboard*) leaderBoard error: (NSError*) error
{
	if(error == NULL)
	{
		int64_t personalBest= leaderBoard.localPlayerScore.value;
		self.score2 = personalBest;
        self.label2.text = [NSString stringWithFormat:@"%d", personalBest];
        
		if([leaderBoard.scores count] >0)
		{
			GKScore* allTime= [leaderBoard.scores objectAtIndex: 0];
			self.score3 = allTime.value;
            self.label3.text = [NSString stringWithFormat:@"%d", allTime.value];
            // 获得用户信息
			[gameCenterManager mapPlayerIDtoPlayer: allTime.playerID];
		}
        
        //[self updateUI];
	}
	else
	{
		
        UIAlertView *alert = [[UIAlertView alloc] 
                              initWithTitle:@"Score Reload Failed!" 
                              message:[NSString stringWithFormat: @"Reason: %@", [error localizedDescription]] 
                              delegate:nil 
                              cancelButtonTitle:@"OK" 
                              otherButtonTitles: nil];
        [alert show];
	}
}

// 获得用户信息后回调
- (void) mappedPlayerIDToPlayer: (GKPlayer*) player error: (NSError*) error
{
	if((error == NULL) && (player != NULL))
	{
		self.highestName = player.alias;
        self.label4.text = player.alias;
    }
	else
	{
		self.highestName = @"-";
	}
    
    //[self updateUI];
}
// 提交分数后回调
- (void) scoreReported: (NSError*) error
{
	if(error == NULL)
	{
		[self.gameCenterManager reloadHighScoresForCategory: self.currentLeaderBoard];
		[self showAlertWithTitle: @"High Score Reported!"
						 message: [NSString stringWithFormat: @"", [error localizedDescription]]];
	}
	else
	{
		[self showAlertWithTitle: @"Score Report Failed!"
						 message: [NSString stringWithFormat: @"Reason: %@", [error localizedDescription]]];
	}
}

// 提交成就后回调
- (void) achievementSubmitted: (GKAchievement*) ach error:(NSError*) error
{
	if((error == NULL) && (ach != NULL))
	{
		if(ach.percentComplete == 100.0)
		{
			[self showAlertWithTitle: @"Achievement Earned!"
                             message: [NSString stringWithFormat: @"Great job!  You earned an achievement: \"%@\"", NSLocalizedString(ach.identifier, NULL)]];
		}
		else
		{
			if(ach.percentComplete > 0)
			{
				[self showAlertWithTitle: @"Achievement Progress!"
                                 message: [NSString stringWithFormat: @"Great job!  You're %.0f\%% of the way to: \"%@\"",ach.percentComplete, NSLocalizedString(ach.identifier, NULL)]];
			}
		}
	}
	else
	{
		[self showAlertWithTitle: @"Achievement Submission Failed!"
                         message: [NSString stringWithFormat: @"Reason: %@", [error localizedDescription]]];
	}
}

// 成就重置后回调
- (void) achievementResetResult: (NSError*) error
{
	self.score1= 0;
	if(error != NULL)
	{
		[self showAlertWithTitle: @"Achievement Reset Failed!"
                         message: [NSString stringWithFormat: @"Reason: %@", [error localizedDescription]]];
	}
}

#pragma mark GKLeaderboardViewControllerDelegate Methods
// 排行结束
- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	[self dismissModalViewControllerAnimated: YES];
}

#pragma mark GKAchievementViewControllerDelegate Methods
// 成就结束
- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	[self dismissModalViewControllerAnimated: YES];
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
