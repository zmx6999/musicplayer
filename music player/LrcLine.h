//
//  LrcLine.h
//  music player
//
//  Created by zmx on 16/1/6.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LrcLine : NSObject

@property (nonatomic, copy) NSString *timeStr;

@property (nonatomic, copy) NSString *lrc;

@property (nonatomic, assign) NSTimeInterval timeInterval;

@end
