//
//  TAAudioPlayer.m
//  TestApp
//
//  Created by Владимир on 29.01.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import "TAAudioPlayer.h"

@interface TAAudioPlayer ()

@end

@implementation TAAudioPlayer

+ (TAAudioPlayer *)sharedPlayer
{
    static TAAudioPlayer *_sharedPlayer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedPlayer = [[TAAudioPlayer alloc] init];
    });
    return _sharedPlayer;
}

- (void)playFile:(NSString *)soundFileName
{
    NSError *error = nil;
    NSURL *url = [NSURL fileURLWithPath:soundFileName];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if(error)
    {
        NSLog(@"Error with player initialization: %@", error.localizedDescription);
    }    
    [_player play];
}

- (void)stopPlaing
{
    [_player stop];
    _player = nil;
}

- (BOOL)isPlaying
{
    return [_player isPlaying];
}

@end
