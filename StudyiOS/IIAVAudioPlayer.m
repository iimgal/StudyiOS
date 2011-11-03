//
//  IIAVAudioPlayer.m
//
//  AVAudioPlayer的单例模式
//  Created by ZhangYiCheng on 11-9-22.
//  Copyright 2011 ZhangYiCheng. All rights reserved.
//

#import "IIAVAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>

@implementation IIAVAudioPlayer

@synthesize player;
@synthesize path;

static IIAVAudioPlayer *me = nil;

+ (AVAudioPlayer *)initWithPath:(NSString *)path {
    if (me == nil) {
        me = [[IIAVAudioPlayer alloc] init];
    }
    
    if ([me.path isEqual:path]) {
        return me.player;
    }
    
    if (me.player == nil) {
        me.player = [[AVAudioPlayer alloc] 
                     initWithContentsOfURL:[NSURL fileURLWithPath:path] 
                     error:nil];
        me.path = path;
    }else {
        if ([me.player isPlaying]) {
            [me.player pause];
            [me.player stop];
        }
        me.player = nil;
        me.player = [[AVAudioPlayer alloc] 
                     initWithContentsOfURL:[NSURL fileURLWithPath:path] 
                     error:nil];
        me.path = path;
    }
    
    return me.player;
}

@end
