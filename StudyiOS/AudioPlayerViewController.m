//
//  AudioPlayerViewController.m
//  StudyiOS
//
//  Created by  on 11-11-9.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "AudioPlayerViewController.h"
#import "IIAVAudioPlayer.h"

@interface AudioPlayerViewController()
- (void) prepAudio;
- (void)playAudio;
- (void)pauseAudio;
- (NSString *) formatTime: (int) num;
- (void) updateMeters ;
- (void)back;
@end

@implementation AudioPlayerViewController
@synthesize player;
@synthesize timer;
@synthesize timeLabel;
@synthesize timeSlider;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle
- (void)dealloc
{
    NSLog(@"dealloc");
}

- (void)viewDidUnload
{
    self.player = nil;
    self.timer = nil;
    [self setTimeLabel:nil];
    [self setTimeSlider:nil];
    
    [super viewDidUnload];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [timer invalidate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 增加Code按钮，可跳转至教学页面
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Code" style:UIBarButtonItemStyleBordered target:self action:@selector(code)];
    self.navigationItem.rightBarButtonItem = item;

    
    [self prepAudio];
}

- (void)back
{
    [timer invalidate];
    [self.navigationController popViewControllerAnimated:YES];
}

// 加载音频
- (void) prepAudio
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"18" ofType:@"mp3"];
    
    // 使用单例初始化,防止重复播放
    AVAudioPlayer *audioPlayer = [IIAVAudioPlayer initWithPath:path];
    
    // 设置后台播放
    // 打开你的 "XXX-Info.plist"
    // 增加一项 "Required background modes" 默认是数组,在其下增加一个元素 "App plays audio"
    //[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    // 预加载
    [audioPlayer prepareToPlay];
    // 激活播放进度跟踪
    audioPlayer.meteringEnabled = YES;
    // 设定循环次数
    audioPlayer.numberOfLoops = 3;
    // 委托
    audioPlayer.delegate = self;
    
    self.player = audioPlayer;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateMeters) userInfo:nil repeats:YES];
}

- (void)playAudio
{
    // 播放
    [player play];
}

- (void)pauseAudio
{
    // 暂停
    [player pause];
}

- (void) updateMeters 
{
    NSLog(@"updateMeters");
	[player updateMeters];
	
    self.timeLabel.text = [NSString stringWithFormat:@"%@ of %@", [self formatTime:self.player.currentTime], [self formatTime:self.player.duration]];
        
    self.timeSlider.value = (self.player.currentTime / self.player.duration);
    
}

- (NSString *) formatTime: (int) num 
{
	int secs = num % 60;
	int min = num / 60;
	
	if (num < 60) return [NSString stringWithFormat:@"0:%02d", num];
	
	return	[NSString stringWithFormat:@"%d:%02d", min, secs];
}

- (IBAction)playPressed:(id)sender 
{
    [self playAudio];
}

- (IBAction)pausePressed:(id)sender 
{
    [self pauseAudio];
}

- (IBAction)sliderValueChanged:(id)sender 
{
    // Calculate the new current time
	self.player.currentTime = self.timeSlider.value * self.player.duration;
}

/* audioPlayerDidFinishPlaying:successfully: is called when a sound has finished playing. This method is NOT called if the player is stopped due to an interruption. */
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"audioPlayerDidFinishPlaying");
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
