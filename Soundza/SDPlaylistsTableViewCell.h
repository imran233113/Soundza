//
//  SDPlaylistsTableViewCell.h
//  Soundza
//
//  Created by Andrew Friedman on 9/9/15.
//  Copyright (c) 2015 Andrew Friedman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "RLMPlaylist.h"

@interface SDPlaylistsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *artworkImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *checkMarkImageView;

-(void)setupDisplayForPlaylist:(RLMPlaylist *)playlist;
@end
