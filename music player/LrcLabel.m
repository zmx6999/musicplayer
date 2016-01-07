//
//  LrcLabel.m
//  music player
//
//  Created by zmx on 16/1/6.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "LrcLabel.h"
#import "LrcLine.h"
#import "LrcLineTool.h"

@interface LrcLabel ()

@property (nonatomic, assign) CGFloat scale;

@end

@implementation LrcLabel

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [[UIColor greenColor] set];
    rect.size.width *= self.scale;
    UIRectFillUsingBlendMode(rect, kCGBlendModeSourceIn);
}

- (void)setCurrentTime:(NSTimeInterval)currentTime {
    _currentTime = currentTime;
    
    NSArray *lrcLines = [LrcLineTool lrcLines];
    
    int i = 0;
    for (; i < lrcLines.count - 1; i++) {
        LrcLine *lrc = lrcLines[i];
        NSTimeInterval timeIn = lrc.timeInterval;
        LrcLine *nextLrc = lrcLines[i + 1];
        NSTimeInterval nextTimeIn = nextLrc.timeInterval;
        
        if (currentTime >= timeIn && currentTime < nextTimeIn) {
            self.text = lrc.lrc;
            self.scale = (currentTime - timeIn) / (nextTimeIn - timeIn);
            [self setNeedsDisplay];
            return;
        }
    }
    
    if (currentTime >= [lrcLines[i] timeInterval]) {
        self.text = @"";
    } else {
        self.text = [lrcLines[i] lrc];
    }
}

@end
