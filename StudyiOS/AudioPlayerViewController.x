#import <AVFoundation/AVFoundation.h>

// 使用单例初始化,防止重复播放
    AVAudioPlayer *audioPlayer = [IIAVAudioPlayer initWithPath:path];
    // 设置后台播放
    // 打开你的 "XXX-Info.plist"
    // 增加一项 "Required background modes" 默认是数组,在其下增加一个元素 "App plays audio"
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    // 预加载
    [audioPlayer prepareToPlay];
    // 激活播放进度跟踪
    audioPlayer.meteringEnabled = YES;
    // 设定循环次数
    audioPlayer.numberOfLoops = 3;
    // 委托
    audioPlayer.delegate = self;
    // 播放
    [player play];