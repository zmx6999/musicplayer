//
//  MusicTool.h
//  music player
//
//  Created by zmx on 16/1/6.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Music;

@interface MusicTool : NSObject

+ (void)next;

+ (void)prev;

+ (void)setPlayingMusic:(Music *)music;

+ (Music *)playingMusic;

+ (NSArray *)songs;

@end
