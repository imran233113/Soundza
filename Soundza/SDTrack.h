//
//  SDTrack.h
//  Soundza
//
//  Created by Andrew Friedman on 8/27/15.
//  Copyright (c) 2015 Andrew Friedman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDTrack : NSObject
@property (strong, nonatomic) NSString *titleString;
@property (strong, nonatomic) NSString *usernameString;
@property (strong, nonatomic) NSString *streamURLString;
@property (strong, nonatomic) NSString *artworkURLString;
@property (strong, nonatomic) NSNumber *duration;
@property (assign, nonatomic) BOOL isSaved;

-(id)initWithTrack:(NSDictionary *)track;

@end
