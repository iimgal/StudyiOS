//
//  GameCenterViewController.h
//  StudyiOS
//
//  Created by  on 11-11-21.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import "GameCenterManager.h"

@interface GameCenterViewController : UIViewController <GKLeaderboardViewControllerDelegate, GKAchievementViewControllerDelegate, GameCenterManagerDelegate>

@property (nonatomic, assign) int64_t score1;//用户当前分
@property (nonatomic, assign) int64_t score2; //用户最高分
@property (nonatomic, retain) NSString *highestName; //排名第一的用户名
@property (nonatomic, assign) int64_t score3; //排名第一的分数
@property (nonatomic, retain) NSString* currentLeaderBoard; // 排行ID
@property (nonatomic, retain) GameCenterManager *gameCenterManager;

@property (strong, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UILabel *label2;
@property (strong, nonatomic) IBOutlet UILabel *label3;
@property (strong, nonatomic) IBOutlet UILabel *label4;

- (IBAction) addOne;
- (IBAction) submitHighScore;
- (IBAction) resetAchievements;
- (IBAction) showLeaderboard;
- (IBAction) showAchievements;

@end
