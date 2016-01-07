//
//  MusicController.m
//  music player
//
//  Created by zmx on 16/1/6.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "MusicController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "Music.h"
#import <AVFoundation/AVFoundation.h>
#import "MusicTool.h"
#import "PlayingMusicTool.h"
#import "LrcLabel.h"
#import "ScrollView.h"

#define maxWidth (self.totalView.frame.size.width - self.slideBtn.frame.size.width)

@interface MusicController () <UIScrollViewDelegate, AVAudioPlayerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageVIew;

@property (weak, nonatomic) IBOutlet UIButton *playOrPauseBtn;

@property (weak, nonatomic) IBOutlet UIView *totalView;

@property (weak, nonatomic) IBOutlet UIView *currentView;

@property (weak, nonatomic) IBOutlet UIButton *slideBtn;

@property (weak, nonatomic) IBOutlet UILabel *timeView;

@property (weak, nonatomic) IBOutlet UILabel *singerView;

@property (weak, nonatomic) IBOutlet UILabel *nameView;

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *currentViewWidth;

@property (weak, nonatomic) IBOutlet LrcLabel *lrcView;

@property (weak, nonatomic) IBOutlet ScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UILabel *hidenLabel;

@property (nonatomic, strong) Music *music;

@property (nonatomic, strong) AVAudioPlayer *player;

@property (nonatomic, strong) CADisplayLink *timer;

@property (nonatomic, assign) CGPoint point;

@end

@implementation MusicController

- (IBAction)back:(id)sender {
    [self removeTimer];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)playOrPause:(UIButton *)sender {
    if (sender.selected) {
        [PlayingMusicTool pauseMusicWithFilename:self.music.filename];
        [self removeTimer];
    } else {
        [PlayingMusicTool playMusicWithFilename:self.music.filename];
        [self addTimer];
    }
    sender.selected = !sender.selected;
}

- (IBAction)next:(id)sender {
    [self stopMusic];
    [MusicTool next];
    [self playMusic];
}

- (IBAction)prev:(id)sender {
    [self stopMusic];
    [MusicTool prev];
    [self playMusic];
}

- (IBAction)onTap:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self.totalView];
    
    CGFloat dx = point.x - self.slideBtn.frame.size.width * 0.5;
    
    if (dx > maxWidth) {
        dx = maxWidth;
    }
    
    if (dx < 0) {
        dx = 0;
    }
    
    self.player.currentTime = self.player.duration / maxWidth * dx;
}

- (IBAction)onPan:(UIPanGestureRecognizer *)sender {
    CGPoint p = [sender translationInView:self.totalView];
    CGFloat dx = p.x - self.point.x;
    self.point = p;
    self.currentViewWidth.constant += dx;
    
    NSTimeInterval currentTime = self.player.duration / maxWidth * self.currentViewWidth.constant;
    NSString *timeStr = [self getStringFromTimeInterval:currentTime];
    [self.slideBtn setTitle:timeStr forState:UIControlStateNormal];
    self.hidenLabel.text = timeStr;
    
    if (self.currentViewWidth.constant > maxWidth) {
        self.currentViewWidth.constant = maxWidth;
    }
    
    if (self.currentViewWidth.constant < 0) {
        self.currentViewWidth.constant = 0;
    }
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self removeTimer];
        self.hidenLabel.hidden = NO;
    }
    
    if (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled) {
        [self addTimer];
        self.hidenLabel.hidden = YES;
        self.player.currentTime = currentTime;
        self.point = CGPointZero;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    if (self.music == [MusicTool playingMusic]) {
        [self addTimer];
    } else {
        [self stopMusic];
        [self playMusic];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, 0);
}

- (void)playMusic {
    self.music = [MusicTool playingMusic];
    self.player = [PlayingMusicTool playMusicWithFilename:self.music.filename];
    self.player.delegate = self;
    
    self.backgroundImageVIew.image = [UIImage imageNamed:self.music.icon];
    self.timeView.text = [self getStringFromTimeInterval:self.player.duration];
    self.lrcView.text = @"";
    self.singerView.text = self.music.singer;
    self.nameView.text = self.music.name;
    self.iconView.image = [UIImage imageNamed:self.music.icon];
    self.scrollView.music = self.music;
    
    self.playOrPauseBtn.selected = YES;
    
    [self addTimer];
    
    [self lockScreen];
}

- (void)stopMusic {
    [PlayingMusicTool stopMusicWithFilename:self.music.filename];
    [self removeTimer];
}

- (void)updateData {
    self.currentViewWidth.constant = maxWidth / self.player.duration * self.player.currentTime;
    [self.slideBtn setTitle:[self getStringFromTimeInterval:self.player.currentTime] forState:UIControlStateNormal];
    self.lrcView.currentTime = self.player.currentTime;
    self.scrollView.currentTime = self.player.currentTime;
}

- (void)addTimer {
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateData)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (NSString *)getStringFromTimeInterval:(NSTimeInterval)timeInterval {
    int minute = timeInterval / 60;
    int second = (int)timeInterval % 60;
    return [NSString stringWithFormat:@"%02d:%02d", minute, second];
}

- (void)lockScreen {
    MPNowPlayingInfoCenter *center = [MPNowPlayingInfoCenter defaultCenter];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[MPMediaItemPropertyAlbumArtist] = self.music.singer;
    dict[MPMediaItemPropertyTitle] = self.music.name;
    dict[MPMediaItemPropertyArtwork] = [[MPMediaItemArtwork alloc] initWithImage:[UIImage imageNamed:self.music.icon]];
    dict[MPMediaItemPropertyPlaybackDuration] = [self getStringFromTimeInterval:self.player.duration];
    dict[MPNowPlayingInfoPropertyElapsedPlaybackTime] = [self getStringFromTimeInterval:self.player.currentTime];
    center.nowPlayingInfo = dict;
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    [self becomeFirstResponder];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    switch (event.subtype) {
        case UIEventSubtypeRemoteControlPlay:
            [self playOrPause:self.playOrPauseBtn];
            break;
            
        case UIEventSubtypeRemoteControlPause:
            [self playOrPause:self.playOrPauseBtn];
            break;
            
        case UIEventSubtypeRemoteControlNextTrack:
            [self next:nil];
            break;
            
        case UIEventSubtypeRemoteControlPreviousTrack:
            [self prev:nil];
            break;
            
        default:
            break;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scale = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.lrcView.hidden = (scale > 0.5);
    self.containerView.alpha = 1 - scale * 0.8;
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    [self next:nil];
}

- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player {
    [self playOrPause:self.playOrPauseBtn];
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player {
    [self playOrPause:self.playOrPauseBtn];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
