//
//  SDSoundCloudAPI.m
//  Soundza
//
//  Created by Andrew Friedman on 8/27/15.
//  Copyright (c) 2015 Andrew Friedman. All rights reserved.
//

#import "SDSoundCloudAPI.h"
#import <SCAPI.h>
#import "SDTrack.h"

NSString *const ClientID = @"40da707152150e8696da429111e3af39";

@implementation SDSoundCloudAPI


+(SDSoundCloudAPI *)sharedManager {
    
    static dispatch_once_t _once;
    static SDSoundCloudAPI *sharedManager = nil;
    dispatch_once(&_once, ^{
        sharedManager = [[SDSoundCloudAPI alloc] init];
    });
    return sharedManager;
}

-(void)getTracksForGenre:(NSString *)genre withCompletion:(void(^)(NSArray *tracks, BOOL error))completion;
{
    
    NSString *appendedInput = [genre stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *appendInput2 = [appendedInput stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
    NSString *path = [NSString stringWithFormat:@"https://api.soundcloud.com/tracks?genres=%@&limit=35&client_id=%@",appendInput2, ClientID];
    
    //Used the shared operation manager to prevent crashing. This allows the operation to be canceled at any time. Prevents crashes from popping/dismissing view controllers during an async request. It may be best to use the shared operation manager for all of my operations, but for now it is only needed for getting tracks for genre.
    self.operationManager = [AFHTTPRequestOperationManager manager];
    [self.operationManager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *responseArray = [responseObject mutableCopy];
        NSMutableIndexSet *indexesToDelete = [NSMutableIndexSet indexSet];
        NSUInteger currentIndex = 0;
        for (NSDictionary *track in responseArray) {
            if ([track objectForKey:@"streamable"] == [NSNumber numberWithBool:false]) {
                [indexesToDelete addIndex:currentIndex];
            }
            currentIndex++;
        }
        [responseArray removeObjectsAtIndexes:indexesToDelete];
        
        if (completion) {
            completion((NSArray *) responseArray, (BOOL) NO);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (completion) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"networkError" object:nil];
            completion((NSArray *) nil, (BOOL) YES);
        }
    }];
}

-(void)parseTracks:(NSArray *)tracks withCompletion:(void(^)(NSArray *parsedTracks))compltion;
{
    NSMutableArray *result = [[NSMutableArray alloc]init];
    for (NSDictionary *trk in tracks) {
        SDTrack *track = [[SDTrack alloc]initWithTrack:trk];
        [result addObject:track];
    }
    
    if (compltion) {
        compltion(result);
    }
}

+(NSArray *)listOfGenres
{
    NSArray *listOfGenres = [[NSArray alloc]initWithObjects:
                             @"Alternative Rock",
                             @"Ambient",
                             @"Classical",
                             @"Country",
                             @"Dance",
                             @"Deep House",
                             @"Disco",
                             @"Drum & Bass",
                             @"Dubstep",
                             @"Electronic",
                             @"Folk",
                             @"Hip Hop",
                             @"House",
                             @"Indie",
                             @"Jazz",
                             @"Latin",
                             @"Metal",
                             @"Piano",
                             @"Pop",
                             @"R&B",
                             @"Rap",
                             @"Reggae",
                             @"Rock",
                             @"Techno",
                             @"Trance",
                             @"Trap",
                             @"Trip Hop",
                             @"World",
                             nil];
    return listOfGenres;
}


@end
