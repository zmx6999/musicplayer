//
//  PlayingMusicTool.h
//  music player
//
//  Created by zmx on 16/1/6.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface PlayingMusicTool : NSObject

+ (AVAudioPlayer *)playMusicWithFilename:(NSString *)filename;

+ (void)pauseMusicWithFilename:(NSString *)filename;

+ (void)stopMusicWithFilename:(NSString *)filename;

@end