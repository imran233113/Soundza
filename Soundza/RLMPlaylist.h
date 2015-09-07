//
//  RLMPlaylist.h
//  Soundza
//
//  Created by Andrew Friedman on 9/7/15.
//  Copyright (c) 2015 Andrew Friedman. All rights reserved.
//

#import "RLMObject.h"
#import <Realm/Realm.h>
#import "RLMTrack.h"

@interface RLMPlaylist : RLMObject

@property NSString              *title;
@property NSDate                *createdAt;
@property RLMArray <RLMTrack>   *tracks;

@end
