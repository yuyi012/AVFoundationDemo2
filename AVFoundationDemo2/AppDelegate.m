//
//  AppDelegate.m
//  AVFoundationDemo2
//
//  Created by 刘 大兵 on 12-5-8.
//  Copyright (c) 2012年 中华中等专业学校. All rights reserved.
//

#import "AppDelegate.h"
#import "MusicListController.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    MusicListController *muisController = [[MusicListController alloc]init];
    UINavigationController *musicNav = [[UINavigationController alloc]initWithRootViewController:muisController];
    self.window.rootViewController = musicNav;
    [musicNav release];
    [muisController release];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}
@end
