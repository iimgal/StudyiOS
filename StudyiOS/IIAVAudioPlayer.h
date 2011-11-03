//
//  IIAVAudioPlayer.h
//  AVAudioPlayer的单例模式
//  Created by ZhangYiCheng on 11-9-22.
//  Copyright 2011 ZhangYiCheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AVAudioPlayer;

@interface IIAVAudioPlayer : NSObject {
    AVAudioPlayer *player;
    NSString *path;
}

@property (nonatomic, retain) AVAudioPlayer *player;
@property (nonatomic, retain) NSString *path;

// 得到单例播放器 入参path:文件路径
+ (AVAudioPlayer *)initWithPath:(NSString *)path;

@end
