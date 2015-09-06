//
//  SDSearchResultsTableViewCell.h
//  
//
//  Created by Andrew Friedman on 8/27/15.
//
//

#import <UIKit/UIKit.h>
#import "SDTrack.h"
#import <SDWebImage/UIImageView+WebCache.h>

@protocol SDSearchCellDelegate <NSObject>
@optional
-(void)longPressOnCell:(UITableViewCell *)cell;
@end

@interface SDSearchResultsTableViewCell : UITableViewCell

@property (weak, nonatomic) id searchDelegate;

@property (strong, nonatomic) IBOutlet UIImageView *albumArtImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;

@property (strong, nonatomic) UILongPressGestureRecognizer *longPressGesture;

-(void)setDisplayForTrack:(SDTrack *)track;

@end
