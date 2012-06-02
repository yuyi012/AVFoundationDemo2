//
//  MusicPlayerController.h
//  AVFoundationDemo2
//
//  Created by 刘 大兵 on 12-5-8.
//  Copyright (c) 2012年 中华中等专业学校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MusicPlayerController : UIViewController{
    IBOutlet UIImageView *artworkImageView;
    IBOutlet UIButton *playButton;
    IBOutlet UISlider *volumnSlider;
    IBOutlet UISlider *progressSlider;
    AVAudioPlayer *audioPlayer;
}
@property(nonatomic,retain) NSURL *musicURL;
-(IBAction)playButtonClick:(id)sender;
-(IBAction)volumnChanged:(id)sender;
-(IBAction)progressChanged:(id)sender;
@end
