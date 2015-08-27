//
//  SDTrack.m
//  Soundza
//
//  Created by Andrew Friedman on 8/27/15.
//  Copyright (c) 2015 Andrew Friedman. All rights reserved.
//

#import "SDTrack.h"

static NSString *const KTrackTitleString = @"title";
static NSString *const KTrackUserString = @"user";
static NSString *const KUserUsernameString = @"username";
static NSString *const KTrackArtworkURLString = @"artwork_url";


@implementation SDTrack

-(id)initWithTrack:(NSDictionary *)track;
{
    self = [super init];
    if (self) {
        self.titleString = track[KTrackTitleString];
        self.usernameString = track[KTrackUserString][KUserUsernameString];
        
        if (![track[KTrackArtworkURLString] isEqual:[NSNull null]]) {
            self.artworkURLString = track[KTrackArtworkURLString];
        }
    }
    
    return self;
}
@end
