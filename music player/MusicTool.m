//
//  MusicTool.m
//  music player
//
//  Created by zmx on 16/1/6.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "MusicTool.h"
#import "Music.h"

static NSArray *_songs;

static Music *_music;

@implementation MusicTool

+ (void)initialize {
    _songs = [Music songs];
}

+ (void)next {
    NSInteger index = [_songs indexOfObject:_music];
    if (index < _songs.count - 1) {
        index++;
    } else {
        index = 0;
    }
    _music = _songs[index];
}

+ (void)prev {
    NSInteger index = [_songs indexOfObject:_music];
    if (index > 0) {
        index--;
    } else {
        index = _songs.count - 1;
    }
    _music = _songs[index];
}

+ (void)setPlayingMusic:(Music *)music {
    _music = music;
}

+ (Music *)playingMusic {
    return _music;
}

+ (NSArray *)songs {
    return _songs;
}

@end
