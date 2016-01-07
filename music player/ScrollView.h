//
//  ScrollView.h
//  music player
//
//  Created by zmx on 16/1/6.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Music;

@interface ScrollView : UIScrollView

@property (nonatomic, strong) Music *music;

@property (nonatomic, assign) NSTimeInterval currentTime;

@end
