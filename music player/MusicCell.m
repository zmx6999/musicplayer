//
//  MusicCell.m
//  music player
//
//  Created by zmx on 16/1/6.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "MusicCell.h"
#import "Music.h"

@interface MusicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *nameView;

@property (weak, nonatomic) IBOutlet UILabel *singerView;

@end

@implementation MusicCell

- (void)awakeFromNib {
    self.iconView.layer.cornerRadius = 24;
    self.iconView.layer.masksToBounds = YES;
    self.iconView.layer.borderColor = [[UIColor purpleColor] CGColor];
    self.iconView.layer.borderWidth = 3;
}

- (void)setMusic:(Music *)music {
    _music = music;
    
    self.iconView.image = [UIImage imageNamed:music.singerIcon];
    self.nameView.text = music.name;
    self.singerView.text = music.singer;
}

@end
