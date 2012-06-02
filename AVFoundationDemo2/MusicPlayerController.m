//
//  MusicPlayerController.m
//  AVFoundationDemo2
//
//  Created by 刘 大兵 on 12-5-8.
//  Copyright (c) 2012年 中华中等专业学校. All rights reserved.
//

#import "MusicPlayerController.h"

@implementation MusicPlayerController
#pragma mark - View lifecycle
@synthesize musicURL;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:musicURL error:NULL];
    [audioPlayer play];
}

- (void)dealloc {
    [audioPlayer release];
    [super dealloc];
}

-(IBAction)playButtonClick:(id)sender{
    
}
-(IBAction)volumnChanged:(id)sender{
    
}
-(IBAction)progressChanged:(id)sender{
    
}
@end
