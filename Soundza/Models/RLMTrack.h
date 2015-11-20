//
//  RLMTrack.h
//  Soundza
//
//  Created by Andrew Friedman on 9/7/15.
//  Copyright (c) 2015 Andrew Friedman. All rights reserved.
//

#import <Realm/Realm.h>

@interface RLMTrack : RLMObject

@property  NSString     *titleString;
@property  NSString     *usernameString;
@property  NSString     *streamURLString;
@property  NSString     *artworkURLString;
@property  NSInteger     duration;
@property  NSDate       *createdAt;

@end

RLM_ARRAY_TYPE(RLMTrack)