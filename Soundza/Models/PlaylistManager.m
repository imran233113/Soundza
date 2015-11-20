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
    playlist.isCurrent = YES;
    
    
    RLMRealm *defaultRealm = [RLMRealm defaultRealm];
    [defaultRealm beginWriteTransaction];
    [defaultRealm addObject:playlist];
    [defaultRealm commitWriteTransaction];
    
    self.playlist = playlist;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"playlistUpdated" object:nil];
}

-(void)saveTrack:(SDTrack *)track
{
    RLMTrack *savedTrack = [[RLMTrack alloc]init];
    savedTrack.titleString = track.titleString;
    savedTrack.usernameString = track.usernameString;
    savedTrack.artworkURLString = track.artworkURLString ? track.artworkURLString : [NSString stringWithFormat:@""];
    savedTrack.duration = [track.duration integerValue];
    savedTrack.streamURLString = track.streamURLString;
    savedTrack.createdAt = [NSDate date];
    
    RLMRealm *defaultRealm = [RLMRealm defaultRealm];
    [defaultRealm beginWriteTransaction];
    [self.playlist.tracks addObject:savedTrack];
    [defaultRealm commitWriteTransaction];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"songSaved" object:nil];
}

-(void)switchCurrentWithPlaylist:(RLMPlaylist *)playlist;
{
    RLMRealm *defaultRealm = [RLMRealm defaultRealm];
    [defaultRealm beginWriteTransaction];
    self.playlist.isCurrent = NO;
    playlist.isCurrent = YES;
    [defaultRealm commitWriteTransaction];
    self.playlist = playlist;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"playlistUpdated" object:nil];

}

-(void)renameCurrentPlaylist:(NSString *)title;
{
    RLMRealm *defaultRealm = [RLMRealm defaultRealm];
    [defaultRealm beginWriteTransaction];
    self.playlist.title = title;
    [defaultRealm commitWriteTransaction];
}

-(void)parseTracks:(RLMArray *)tracks withCompletion:(void(^)(NSArray *parsedTracks))completion;
{
    NSMutableArray *result = [[NSMutableArray alloc]init];
    for (RLMTrack *trk in tracks) {
        SDTrack *track = [[SDTrack alloc]init];
        
        track.streamURLString = trk.streamURLString;
        track.artworkURLString = trk.artworkURLString;
        track.titleString = trk.titleString;
        track.usernameString = trk.usernameString;
        track.duration = [NSNumber numberWithInteger:trk.duration];
        track.isSaved = YES;
        
        [result addObject:track];
    }
    
    if (completion) {
        completion(result);
    }
}

@end
