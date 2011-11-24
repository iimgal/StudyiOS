//
//  AudioPlayerViewController.h
//  StudyiOS
//
//  Created by  on 11-11-9.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioPlayerViewController : UIViewController <AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioPlayer *player;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UISlider *timeSlider;

- (IBAction)playPressed:(id)sender;
- (IBAction)pausePressed:(id)sender;
- (IBAction)sliderValueChanged:(id)sender;

@end
