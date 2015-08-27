//
//  SDSearchResultsTableViewCell.h
//  
//
//  Created by Andrew Friedman on 8/27/15.
//
//

#import <UIKit/UIKit.h>

@interface SDSearchResultsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *albumArtImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;

@end
