//
//  PlaylistManager.h
//  Soundza
//
//  Created by Andrew Friedman on 9/7/15.
//  Copyright (c) 2015 Andrew Friedman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "SDTrack.h"
#import "RLMPlaylist.h"
#import "RLMTrack.h"

@interface PlaylistManager : NSObject

+(PlaylistManager *)sharedManager;

@property (strong, nonatomic) RLMPlaylist *playlist;

-(void)parseTracks:(RLMArray *)tracks withCompletion:(void(^)(NSArray *parsedTracks))completion;


-(void)createNewPlaylistWithTitle:(NSString *)title;
-(void)saveTrack:(SDTrack *)track;

-(void)switchCurrentWithPlaylist:(RLMPlaylist *)playlist;
-(void)renameCurrentPlaylist:(NSString *)title;

@end
