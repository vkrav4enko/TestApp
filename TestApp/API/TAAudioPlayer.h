//
//  TAAudioPlayer.h
//  TestApp
//
//  Created by Владимир on 29.01.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface TAAudioPlayer : NSObject
@property (nonatomic, strong) NSMutableDictionary *audioFiles;
@property (nonatomic, copy) NSString *currentFile;

+(TAAudioPlayer *) sharedPlayer;

- (void)playFile:(NSString*)soundFileName;
- (void)stopPlaing;
- (BOOL)isPlaying;

@end
