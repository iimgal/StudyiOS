要使用GameCenter需先去官网激活，并添加排名和成就，得到排名ID和成就ID才能在代码里使用

#import <GameKit/GameKit.h>
#import "GameCenterManager.h"
实现委托<GKLeaderboardViewControllerDelegate, GKAchievementViewControllerDelegate, GameCenterManagerDelegate>

// 判断GameCenter是否可用，并初始化管理器
if([GameCenterManager isGameCenterAvailable])
    {
	self.gameCenterManager= [[GameCenterManager alloc] init];
	[self.gameCenterManager setDelegate: self];
	[self.gameCenterManager authenticateLocalUser];
	[self updateCurrentScore];
    }
    
// 提交分数
[self.gameCenterManager reportScore: self.score1 forCategory: self.currentLeaderBoard];
// 提交成就
[self.gameCenterManager submitAchievement: identifier percentComplete: percentComplete];

// 获得分数
[self.gameCenterManager reloadHighScoresForCategory: self.currentLeaderBoard];
// 获得用户信息
[gameCenterManager mapPlayerIDtoPlayer: allTime.playerID];

#pragma mark GameCenterManagerDelegate Methods
// 登陆GameCenter后回调
- (void) processGameCenterAuth: (NSError*) error
// 获得用户排名后回调
- (void) reloadScoresComplete: (GKLeaderboard*) leaderBoard error: (NSError*) error;
// 获得用户信息后回调
- (void) mappedPlayerIDToPlayer: (GKPlayer*) player error: (NSError*) error;
// 提交分数后回调
- (void) scoreReported: (NSError*) error
// 提交成就后回调
- (void) achievementSubmitted: (GKAchievement*) ach error:(NSError*) error
