//
//  LrcLineTool.m
//  music player
//
//  Created by zmx on 16/1/6.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "LrcLineTool.h"
#import "LrcLine.h"
#import "Music.h"

static NSArray *_lrcLines;

@implementation LrcLineTool

+ (void)setLrcLineWithMusic:(Music *)music {
    NSString *lrc = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:music.lrcname ofType:nil] encoding:NSUTF8StringEncoding error:nil];
    NSArray *lrcs = [lrc componentsSeparatedByString:@"\n"];
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSString *str in lrcs) {
        if (![str hasPrefix:@"[0"]) {
            continue;
        }
        LrcLine *lrcLine = [[LrcLine alloc] init];
        lrcLine.timeStr = [str substringWithRange:NSMakeRange(1, 8)];
        lrcLine.lrc = [str substringFromIndex:10];
        [arrM addObject:lrcLine];
    }
    _lrcLines = [arrM copy];
}

+ (NSArray *)lrcLines {
    return _lrcLines;
}

@end
