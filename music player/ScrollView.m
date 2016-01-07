//
//  ScrollView.m
//  music player
//
//  Created by zmx on 16/1/6.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "ScrollView.h"
#import "LrcLine.h"
#import "LrcCell.h"
#import "LrcLineTool.h"

@interface ScrollView () <UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSArray *lrcLines;

@end

static NSString *ID = @"lrc";

@implementation ScrollView

- (void)setMusic:(Music *)music {
    _music = music;
    
    [LrcLineTool setLrcLineWithMusic:music];
    self.lrcLines = [LrcLineTool lrcLines];
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

- (void)setCurrentTime:(NSTimeInterval)currentTime {
    _currentTime = currentTime;
    
    int i = 0;
    for (; i < self.lrcLines.count - 1; i++) {
        LrcLine *lrc = self.lrcLines[i];
        NSTimeInterval timeIn = lrc.timeInterval;
        LrcLine *nextLrc = self.lrcLines[i + 1];
        NSTimeInterval nextTimeIn = nextLrc.timeInterval;
        if (currentTime >= timeIn && currentTime < nextTimeIn) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            return;
        }
    }
    
    if (currentTime >= [self.lrcLines[i] timeInterval]) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.lrcLines.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    } else {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

- (void)awakeFromNib {
    UITableView *tableView = [[UITableView alloc] init];
    self.tableView = tableView;
    [self addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"LrcCell" bundle:nil] forCellReuseIdentifier:ID];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tableView.frame = CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
    self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.frame.size.height * 0.5, 0, self.tableView.frame.size.height * 0.5, 0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lrcLines.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LrcCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.lrc = [self.lrcLines[indexPath.row] lrc];
    return cell;
}

@end
