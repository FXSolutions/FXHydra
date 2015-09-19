//
//  AFSoundPlayback.m
//  AFSoundManager-Demo
//
//  Created by Alvaro Franco on 21/01/15.
//  Copyright (c) 2015 AlvaroFranco. All rights reserved.
//

#import "AFSoundPlayback.h"
#import "AFSoundManager.h"
#import "NSTimer+AFSoundManager.h"

@interface AFSoundPlayback ()

-(void)setUpItem:(AFSoundItem *)item;

@property (nonatomic, strong) NSTimer *feedbackTimer;

@end

@implementation AFSoundPlayback

NSString * const AFSoundPlaybackStatus = @"status";
NSString * const AFSoundStatusDuration = @"duration";
NSString * const AFSoundStatusTimeElapsed = @"timeElapsed";

NSString * const AFSoundPlaybackFinishedNotification = @"kAFSoundPlaybackFinishedNotification";

-(id)initWithItem:(AFSoundItem *)item {
    
    if (self == [super init]) {
        
        _currentItem = item;
        [self setUpItem:item];
        
        _status = AFSoundStatusNotStarted;
    }
    
    return self;
}

-(void)setUpItem:(AFSoundItem *)item {
    
    
    _qPlayer = [[AVQueuePlayer alloc] init];

    
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:item.URL options:nil];
        NSArray *keys     = [NSArray arrayWithObject:@"playable"];
        
        [asset loadValuesAsynchronouslyForKeys:keys completionHandler:^() {
            [_qPlayer insertItem:[AVPlayerItem playerItemWithAsset:asset] afterItem:nil];
        }];
        
        [_qPlayer play];
        _qPlayer.actionAtItemEnd = AVPlayerActionAtItemEndPause;
        
        _status = AFSoundStatusPlaying;
        
        _currentItem = item;
        _currentItem.duration = (int)CMTimeGetSeconds(_qPlayer.currentItem.asset.duration);
        
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        
    });
    
}

-(void)listenFeedbackUpdatesWithBlock:(feedbackBlock)block andFinishedBlock:(finishedBlock)finishedBlock {
    
    CGFloat updateRate = 1;
    
    if (_qPlayer.rate > 0) {
        
        updateRate = 1 / _qPlayer.rate;
    }
    
    _feedbackTimer = [NSTimer scheduledTimerWithTimeInterval:updateRate block:^{
        
        _currentItem.timePlayed = (int)CMTimeGetSeconds(_qPlayer.currentTime);
        
        if (block) {

            block(_currentItem);
        }
        
        if (self.statusDictionary[AFSoundStatusDuration] == self.statusDictionary[AFSoundStatusTimeElapsed]) {
            
            [_feedbackTimer pauseTimer];
            
            _status = AFSoundStatusFinished;
            
            if (finishedBlock) {
                
                finishedBlock();
            }
        }
    } repeats:YES];
}

-(NSDictionary *)playingInfo {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setValue:[NSNumber numberWithDouble:CMTimeGetSeconds(_qPlayer.currentItem.currentTime)] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
    [dict setValue:@(_qPlayer.rate) forKey:MPNowPlayingInfoPropertyPlaybackRate];
    
    return dict;
}

-(void)play {
    
    [_qPlayer play];
    [_feedbackTimer resumeTimer];
    [[MPRemoteCommandCenter sharedCommandCenter] playCommand];
    
    _status = AFSoundStatusPlaying;
}

-(void)pause {
    
    [_qPlayer pause];
    [_feedbackTimer pauseTimer];
    [[MPRemoteCommandCenter sharedCommandCenter] pauseCommand];
    
    _status = AFSoundStatusPaused;
}

-(void)restart {
    
    [_qPlayer seekToTime:CMTimeMake(0, 1)];
}

-(void)playAtSecond:(NSInteger)second {
    
    [_qPlayer seekToTime:CMTimeMake(second, 1)];
}

-(void)remoteControlReceivedWithEvent:(UIEvent *)receivedEvent {
    
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        
        switch (receivedEvent.subtype) {
                
            case UIEventSubtypeRemoteControlTogglePlayPause:
                [self play];
                break;
                
            default:
                break;
        }
    }
}

-(NSDictionary *)statusDictionary {
    
    return @{AFSoundStatusDuration: @((int)CMTimeGetSeconds(_qPlayer.currentItem.asset.duration)),
             AFSoundStatusTimeElapsed: @((int)CMTimeGetSeconds(_qPlayer.currentItem.currentTime)),
             AFSoundPlaybackStatus: @(_status)};
}

@end
