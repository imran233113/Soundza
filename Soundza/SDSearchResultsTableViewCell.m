//
//  SDSearchResultsTableViewCell.m
//  
//
//  Created by Andrew Friedman on 8/27/15.
//
//

#import "SDSearchResultsTableViewCell.h"

@implementation SDSearchResultsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setDisplayForTrack:(SDTrack *)track
{
    
    self.longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onSelfLongPressDetected:)];
    self.longPressGesture.minimumPressDuration = .8;
    [self addGestureRecognizer:self.longPressGesture];
    
    self.titleLabel.text = track.titleString;
    self.usernameLabel.text = track.usernameString;
    
    
    NSURL *albumArtURLString = [NSURL URLWithString:track.artworkURLString];
    __weak SDSearchResultsTableViewCell *weakSelf = self;
    
    
    [self.albumArtImageView sd_setImageWithURL:albumArtURLString placeholderImage:nil options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (cacheType == SDImageCacheTypeNone) {
            weakSelf.albumArtImageView.alpha = 0;
            [UIView animateWithDuration:0.4 animations:^{
                weakSelf.albumArtImageView.alpha = 1;
            }];
        } else {
            weakSelf.albumArtImageView.alpha = 1;
        }

    }];
}

-(void)onSelfLongPressDetected:(UILongPressGestureRecognizer *)longPressGestRec
{
    if (longPressGestRec.state == UIGestureRecognizerStateBegan) {
        [self.searchDelegate longPressOnCell:self];
    }
}
@end
