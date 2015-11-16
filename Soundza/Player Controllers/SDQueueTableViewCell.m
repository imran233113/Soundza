//
//  SDQueueTableViewCell.m
//  Soundza
//
//  Created by Andrew Friedman on 9/5/15.
//  Copyright (c) 2015 Andrew Friedman. All rights reserved.
//

#import "SDQueueTableViewCell.h"

@implementation SDQueueTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


-(void)setupDisplayForTrack:(SDTrack *)track;
{
    
    self.titleLabel.text = track.titleString;
    self.usernameLabel.text = track.usernameString;
    
    NSURL *albumArtURLString = [NSURL URLWithString:track.artworkURLString];
    __weak SDQueueTableViewCell *weakSelf = self;
    
    [self.artworkImageView sd_setImageWithURL:albumArtURLString placeholderImage:nil options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (cacheType == SDImageCacheTypeNone) {
            weakSelf.artworkImageView.alpha = 0;
            [UIView animateWithDuration:0.2 animations:^{
                weakSelf.artworkImageView.alpha = 1;
            }];
        } else {
            weakSelf.artworkImageView.alpha = 1;
        }
        
    }];

}


@end
