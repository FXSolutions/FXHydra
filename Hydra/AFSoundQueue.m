//
//  AFSoundQueue.m
//  AFSoundManager-Demo
//
//  Created by Alvaro Franco on 21/01/15.
//  Copyright (c) 2015 AlvaroFranco. All rights reserved.
//

#import "AFSoundQueue.h"
#import "AFSoundManager.h"
#import "NSTimer+AFSoundManager.h"

#import <objc/runtime.h>

@interface AFSoundQueue ()

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) NSTimer *feedbackTimer;

@end

@implementation AFSoundQueue

-(id)initWithItems:(NSArray *)items {
    
    if (self == [super init]) {
        
        if (items) {
            
            _items = [NSMutableArray arrayWithArray:items];
            
            _queuePlayer = [[AFSoundPlayback alloc] initWithItem:items.firstObject];
            
            [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        }
    }
    
    return self;
}

-(void)listenFeedbackUpdatesWithBlock:(feedbackBlock)block andFinishedBlock:(itemFinishedBlock)finishedBlock {
    
    CGFloat updateRate = 1;
    
    if (_queuePlayer.qPlayer.rate > 0) {
        
        updateRate = 1 / _queuePlayer.qPlayer.rate;
    }

    _feedbackTimer = [NSTimer scheduledTimerWithTimeInterval:updateRate block:^{
        
        if (block) {
            
            _queuePlayer.currentItem.timePlayed = (int)CMTimeGetSeconds(_queuePlayer.qPlayer.currentTime);
            
            AVPlayerItem *item = _queuePlayer.qPlayer.items.firstObject;
            
            _queuePlayer.currentItem.duration = (int)CMTimeGetSeconds(item.duration);
            
            if (self.queuePlayer.currentItem.timePlayed > 0) {
                
                
                //NSLog(@"time played = %ld",(long)_queuePlayer.currentItem.timePlayed);
                //NSLog(@"time duration = %ld",(long)_queuePlayer.currentItem.duration);
                block(_queuePlayer.currentItem);
            }
            
        }
        
        if (_queuePlayer.currentItem.timePlayed != 0 && _queuePlayer.currentItem.timePlayed == _queuePlayer.currentItem.duration) {
            
            if (finishedBlock) {
                
                if ([self indexOfCurrentItem] + 1 < _items.count) {
                    
                    finishedBlock(_items[[self indexOfCurrentItem] + 1]);
                } else {
                    
                    finishedBlock(nil);
                }
            }
            
            [_feedbackTimer pauseTimer];
            
            //[self playNextItem];
        }
    } repeats:YES];
}

-(void)addItem:(AFSoundItem *)item {
    
    [self addItem:item atIndex:_items.count];
}

-(void)addItem:(AFSoundItem *)item atIndex:(NSInteger)index {
    
    [_items insertObject:item atIndex:(_items.count >= index) ? _items.count : index];
}

-(void)removeItem:(AFSoundItem *)item {
    
    if ([_items containsObject:item]) {
        
        [self removeItemAtIndex:[_items indexOfObject:item]];
    }
}

-(void)removeItemAtIndex:(NSInteger)index {

    if (_items.count >= index) {
        
        AFSoundItem *item = _items[index];
        [_items removeObject:item];
        
        if (_queuePlayer.currentItem == item) {
            
            [self playNextItem];
            
            [_feedbackTimer resumeTimer];
        }
    }
}

-(void)clearQueue {
    
    [_queuePlayer pause];
    [_items removeAllObjects];
    [_feedbackTimer pauseTimer];
}

-(void)playCurrentItem {
    
    [_queuePlayer play];
    [[MPRemoteCommandCenter sharedCommandCenter] playCommand];
    
    [_feedbackTimer resumeTimer];
}

-(void)pause {
    
    [_queuePlayer pause];
    [[MPRemoteCommandCenter sharedCommandCenter] pauseCommand];
    
    [_feedbackTimer pauseTimer];
}

-(void)playNextItem {
        
    if ([_items containsObject:_queuePlayer.currentItem]) {
        
        [self playItemAtIndex:([_items indexOfObject:_queuePlayer.currentItem] + 1)];
        [[MPRemoteCommandCenter sharedCommandCenter] nextTrackCommand];
        
        [_feedbackTimer resumeTimer];
    }
}

-(void)playPreviousItem {
    
    if ([_items containsObject:_queuePlayer.currentItem] && [_items indexOfObject:_queuePlayer.currentItem] > 0) {
        
        [self playItemAtIndex:([_items indexOfObject:_queuePlayer.currentItem] - 1)];
        [[MPRemoteCommandCenter sharedCommandCenter] previousTrackCommand];
    }
}

-(void)playItemAtIndex:(NSInteger)index {
    
    if (_items.count > index) {
        
        [self playItem:_items[index]];
    }
}

-(void)playItem:(AFSoundItem *)item {
    
    if ([_items containsObject:item]) {
        
        if (_queuePlayer.status == AFSoundStatusNotStarted || _queuePlayer.status == AFSoundStatusPaused || _queuePlayer.status == AFSoundStatusFinished) {
            
//            [_feedbackTimer resumeTimer];
        }

        _queuePlayer = [[AFSoundPlayback alloc] initWithItem:item];
        [_queuePlayer play];
        [[MPRemoteCommandCenter sharedCommandCenter] playCommand];
        
    }
}

-(AFSoundItem *)getCurrentItem {
    
    return _queuePlayer.currentItem;
}

-(NSInteger)indexOfCurrentItem {
    
    AFSoundItem *currentItem = [self getCurrentItem];
    
    if ([_items containsObject:currentItem]) {
        
        return [_items indexOfObject:currentItem];
    }
    
    return NAN;
}

@end
