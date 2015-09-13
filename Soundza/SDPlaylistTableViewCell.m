//
//  SDPlaylistTableViewCell.m
//  Soundza
//
//  Created by Andrew Friedman on 9/7/15.
//  Copyright (c) 2015 Andrew Friedman. All rights reserved.
//

#import "SDPlaylistTableViewCell.h"

@implementation SDPlaylistTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupDisplayForTrack:(SDTrack *)track;
{
    self.titleLabel.text = track.titleString;
    self.usernameLabel.text = track.usernameString;
    
    NSURL *albumArtURLString = [NSURL URLWithString:track.artworkURLString];
    [self.artworkImageView sd_setImageWithURL:albumArtURLString placeholderImage:nil options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];

}

@end
