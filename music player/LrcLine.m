//
//  LrcLine.m
//  music player
//
//  Created by zmx on 16/1/6.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "LrcLine.h"

@implementation LrcLine

- (NSTimeInterval)timeInterval {
    int minute = [[self.timeStr substringToIndex:2] intValue];
    double second = [[self.timeStr substringFromIndex:3] doubleValue];
    return minute * 60.0 + second;
}

@end
