//
//  SDSoundCloudAPI.h
//  Soundza
//
//  Created by Andrew Friedman on 8/27/15.
//  Copyright (c) 2015 Andrew Friedman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>

@interface SDSoundCloudAPI : NSObject

@property (strong, nonatomic) AFHTTPRequestOperationManager *operationManager;

+(SDSoundCloudAPI *)sharedManager;

-(void)getTracksForGenre:(NSString *)genre withCompletion:(void(^)(NSArray *tracks, BOOL error))completion;
+(NSArray *)listOfGenres;


-(void)parseTracks:(NSArray *)tracks withCompletion:(void(^)(NSArray *parsedTracks))compltion;
@end
