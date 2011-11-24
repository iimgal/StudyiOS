#import <MediaPlayer/MediaPlayer.h>

// 创建视频播放器
    MPMoviePlayerController* theMovie = [[MPMoviePlayerController alloc] initWithContentURL:url];
    // 设置文件类型
    [theMovie setMovieSourceType:MPMovieSourceTypeFile];
    // 设置UI
    CGRect viewInsetRect = CGRectInset ([self.view bounds], 0, 40);
    theMovie.view.frame = viewInsetRect;
    [self.view addSubview:theMovie.view];
    // 开始播放
    [theMovie play];