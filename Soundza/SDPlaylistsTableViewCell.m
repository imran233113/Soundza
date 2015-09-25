//
//  SDPlaylistsTableViewCell.m
//  Soundza
//
//  Created by Andrew Friedman on 9/9/15.
//  Copyright (c) 2015 Andrew Friedman. All rights reserved.
//

#import "SDPlaylistsTableViewCell.h"
#import "PlaylistManager.h"

@implementation SDPlaylistsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setupDisplayForPlaylist:(RLMPlaylist *)playlist;
{
    
    self.titleLabel.text = playlist.title;
    
    RLMTrack *firstTrack = playlist.tracks.firstObject;
    NSString *artworkURLString = firstTrack.artworkURLString;
    NSURL *artworkURL = [NSURL URLWithString:artworkURLString];
    
    [self.artworkImageView sd_setImageWithURL:artworkURL];
    
    self.checkMarkImageView.hidden = ![playlist isEqualToObject:[PlaylistManager sharedManager].playlist];

}
@end
