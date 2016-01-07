//
//  LrcCell.m
//  music player
//
//  Created by zmx on 16/1/6.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "LrcCell.h"

@interface LrcCell ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation LrcCell

- (void)setLrc:(NSString *)lrc {
    _lrc = lrc;
    
    self.label.text = lrc;
}

@end
