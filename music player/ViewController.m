//
//  ViewController.m
//  music player
//
//  Created by zmx on 16/1/6.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "ViewController.h"
#import "Music.h"
#import "MusicCell.h"
#import "MusicController.h"
#import "MusicTool.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *songs;

@property (nonatomic, strong) MusicController *mc;

@end

@implementation ViewController

- (NSArray *)songs {
    if (_songs == nil) {
        _songs = [MusicTool songs];
    }
    return _songs;
}

- (MusicController *)mc {
    if (_mc == nil) {
        _mc = [[MusicController alloc] init];
    }
    return _mc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 68;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.songs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"music";
    MusicCell *cell = (MusicCell *)[tableView dequeueReusableCellWithIdentifier:ID];
    cell.music = self.songs[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [MusicTool setPlayingMusic:self.songs[indexPath.row]];
    [self presentViewController:self.mc animated:YES completion:nil];
}

@end
