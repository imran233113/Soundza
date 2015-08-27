//
//  SDSearchResultsTableViewController.m
//  
//
//  Created by Andrew Friedman on 8/27/15.
//
//

#import "SDSearchResultsTableViewController.h"
#import "SDSearchResultsTableViewCell.h"
#import "SDSoundCloudAPI.h"
#import "SDTrack.h"

static NSString *const KSearchResultsTableViewCellReuseID = @"Results";

@interface SDSearchResultsTableViewController ()
@property (strong, nonatomic) NSArray *searchResults;
@end

@implementation SDSearchResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchResults = [[NSArray alloc]init];
    
    UIRefreshControl *refreshController = [[UIRefreshControl alloc]init];
    [self setRefreshControl:refreshController];
    [refreshController addTarget:self action:@selector(refreshControlActivated:) forControlEvents:UIControlEventValueChanged];
    
    [refreshController beginRefreshing];
    [[SDSoundCloudAPI sharedManager]getTracksForGenre:self.genreString withCompletion:^(NSArray *tracks, BOOL error) {
        if (!error) {
            [[SDSoundCloudAPI sharedManager]parseTracks:tracks withCompletion:^(NSArray *parsedTracks) {
                self.searchResults = parsedTracks;
                [refreshController endRefreshing];
                [self.tableView reloadData];
            }];
        }
    }];
}

-(void)refreshControlActivated:(UIRefreshControl *)refreshControl
{
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResults.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SDSearchResultsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KSearchResultsTableViewCellReuseID forIndexPath:indexPath];
    SDTrack *track = self.searchResults[indexPath.row];
    [cell setDisplayForTrack:track];
    return cell;
}

@end
