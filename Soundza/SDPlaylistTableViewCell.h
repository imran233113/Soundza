//
//  SDPlaylistTableViewCell.h
//  Soundza
//
//  Created by Andrew Friedman on 9/7/15.
//  Copyright (c) 2015 Andrew Friedman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDTrack.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SDPlaylistTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *artworkImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;

-(void)setupDisplayForTrack:(SDTrack *)track;

@end
