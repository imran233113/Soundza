//
//  SDSearchResultsTableViewController.h
//  
//
//  Created by Andrew Friedman on 8/27/15.
//
//

#import <UIKit/UIKit.h>
#import "SDSearchResultsTableViewCell.h"

@interface SDSearchResultsTableViewController : UITableViewController <SDSearchCellDelegate>
@property (strong, nonatomic) NSString *genreString;
@property (strong, nonatomic) NSString *searchString;
@end
