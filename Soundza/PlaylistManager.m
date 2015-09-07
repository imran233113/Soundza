//
//  PlaylistManager.m
//  Soundza
//
//  Created by Andrew Friedman on 9/7/15.
//  Copyright (c) 2015 Andrew Friedman. All rights reserved.
//

#import "PlaylistManager.h"
#import "RLMTrack.h"

@implementation PlaylistManager

+(PlaylistManager *)sharedManager;
{
    static dispatch_once_t _once;
    static PlaylistManager *sharedManager = nil;
    dispatch_once(&_once, ^{
        sharedManager = [[PlaylistManager alloc] init];
    });
    return sharedManager;
}

-(void)createNewPlaylistWithTitle:(NSString *)title;
{
    RLMPlaylist *playlist = [[RLMPlaylist alloc]init];
    playlist.title = title;
    playlist.createdAt = [NSDate date];
    
    RLMRealm *defaultRealm = [RLMRealm defaultRealm];
    [defaultRealm beginWriteTransaction];
    [defaultRealm addObject:playlist];
    [defaultRealm commitWriteTransaction];

}

-(void)saveTrack:(SDTrack *)track
{
    RLMTrack *savedTrack = [[RLMTrack alloc]init];
    savedTrack.titleString = track.titleString;
    savedTrack.usernameString = track.usernameString;
    savedTrack.artworkURLString = track.artworkURLString;
    savedTrack.duration = [track.duration integerValue];
    savedTrack.streamURLString = track.streamURLString;
    savedTrack.createdAt = [NSDate date];
    
    RLMRealm *defaultRealm = [RLMRealm defaultRealm];
    [defaultRealm beginWriteTransaction];
    [self.playlist.tracks addObject:savedTrack];
    [defaultRealm commitWriteTransaction];
}

@end
