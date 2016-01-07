//
//  Music.m
//  music player
//
//  Created by zmx on 16/1/6.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "Music.h"

@implementation Music

+ (instancetype)musicWithDict:(NSDictionary *)dict {
    Music *music = [[self alloc] init];
    [music setValuesForKeysWithDictionary:dict];
    return music;
}

+ (NSArray *)songs {
    NSArray *songs = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Musics.plist" ofType:nil]];
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSDictionary *dict in songs) {
        Music *music = [Music musicWithDict:dict];
        [arrM addObject:music];
    }
    return [arrM copy];
}

@end
