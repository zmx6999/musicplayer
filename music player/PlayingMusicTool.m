//
//  PlayingMusicTool.m
//  music player
//
//  Created by zmx on 16/1/6.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "PlayingMusicTool.h"

static NSMutableDictionary *_players;

@implementation PlayingMusicTool

+ (void)initialize {
    _players = [NSMutableDictionary dictionary];
}

+ (AVAudioPlayer *)playMusicWithFilename:(NSString *)filename {
    AVAudioPlayer *player = _players[filename];
    if (player == nil) {
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:filename ofType:nil]] error:nil];
        _players[filename] = player;
    }
    [player play];
    return player;
}

+ (void)pauseMusicWithFilename:(NSString *)filename {
    AVAudioPlayer *player = [_players valueForKey:filename];
    [player pause];
}

+  (void)stopMusicWithFilename:(NSString *)filename {
    AVAudioPlayer *player = _players[filename];
    [player stop];
    if (player) {
        [_players removeObjectForKey:filename];
    }
}

@end