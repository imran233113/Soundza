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

@protocol SDPlaylistCellDelegate <NSObject>
@optional
-(void)longPressOnCell:(UITableViewCell *)cell;
@end

@interface SDPlaylistTableViewCell : UITableViewCell

@property (weak, nonatomic) id playlistDelegate;

@property (strong, nonatomic) IBOutlet UIImageView *artworkImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;

@property (strong, nonatomic) UILongPressGestureRecognizer *longPressGesture;

-(void)setupDisplayForTrack:(SDTrack *)track;

@end
