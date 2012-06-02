//
//  MusicListController.m
//  AVFoundationDemo2
//
//  Created by 刘 大兵 on 12-5-8.
//  Copyright (c) 2012年 中华中等专业学校. All rights reserved.
//

#import "MusicListController.h"
#import <AVFoundation/AVFoundation.h>
#import "MusicPlayerController.h"

@implementation MusicListController
-(void)loadView{
    UIView *container = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 416)];
    self.view = container;
    [container release];
    
    DataTable = [[UITableView alloc]initWithFrame:self.view.bounds];
    DataTable.delegate = self;
    DataTable.dataSource = self;
    [self.view addSubview:DataTable];
}

- (void)dealloc {
    [DataTable release];
    [musicArray release];
    [super dealloc];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    musicArray = [[NSMutableArray alloc]init];
    //资源目录
    NSString *resoucePath = [[NSBundle mainBundle]resourcePath];
    NSLog(@"resoucePath:%@",resoucePath);
    //取出资源目录下所有mp3文件
//    NSArray *fileArray = [[NSBundle mainBundle]pathsForResourcesOfType:@"mp3" inDirectory:resoucePath];
    NSArray *mp3Array = [NSBundle pathsForResourcesOfType:@"mp3" inDirectory:[[NSBundle mainBundle]resourcePath]];
    for (NSString *filePath in mp3Array) {
        //NSLog(@"filePath:%@",filePath);
        //fileURLWithPath是初始化文件路径url得，urlWithPath是初始化网络链接得
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
        //初始化urlAsset，options中可以指定要求准确播放时长
        AVURLAsset *avURLAsset = [AVURLAsset URLAssetWithURL:fileURL options:nil];
        [musicArray addObject:avURLAsset];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return musicArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *musicCell = [DataTable dequeueReusableCellWithIdentifier:@"musicCell"];
    if (musicCell==nil) {
        musicCell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                           reuseIdentifier:@"musicCell"]autorelease];
    }
    //取出每一行对应得AVURLAsset
    AVURLAsset *mp3Asset = [musicArray objectAtIndex:indexPath.row];
    NSLog(@"mp3Asset:%@",[[[mp3Asset URL]absoluteString]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
    //取出url并取消百分号utf8转码
    NSString *mp3FilePath = [[[mp3Asset URL]absoluteString]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //取最后一个/后面得路径
    NSString *musicTitle = [mp3FilePath lastPathComponent];
    //去掉.mp3得到歌曲名称
    musicTitle = [musicTitle substringToIndex:[musicTitle rangeOfString:@"."].location];
    musicCell.textLabel.text = musicTitle;
    for (NSString *format in [mp3Asset availableMetadataFormats]) {
        NSLog(@"-------format:%@",format);
        for (AVMetadataItem *metadataItem in [mp3Asset metadataForFormat:format]) {
            NSLog(@"commonKey:%@",metadataItem.commonKey);
            if ([metadataItem.commonKey isEqualToString:@"artwork"]) {
                //取出封面artwork，从data转成image显示
                musicCell.imageView.image = [UIImage imageWithData:[(NSDictionary*)metadataItem.value objectForKey:@"data"]];
            }
//            if ([metadataItem.commonKey isEqualToString:@"title"]) {
////                NSString *titleStr = [NSString stringWithCString:(const char *)metadataItem.value encoding:NSASCIIStringEncoding];
//                CFStringRef titleStrRef = CFStringCreateWithCString(CFAllocatorGetDefault(), (const char *)metadataItem.value, kCFStringEncodingASCII);
//                musicCell.textLabel.text = (NSString*)titleStrRef;
//            }
        }
    }
    return musicCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AVURLAsset *mp3Asset = [musicArray objectAtIndex:indexPath.row];
    //mp3文件路径得url
    NSURL *mp3URL = mp3Asset.URL;
    MusicPlayerController *musicPlayerController = [[MusicPlayerController alloc]
                                                    init];
    musicPlayerController.musicURL = mp3URL;
    [self.navigationController pushViewController:musicPlayerController animated:YES];
    [musicPlayerController release];
}
@end
