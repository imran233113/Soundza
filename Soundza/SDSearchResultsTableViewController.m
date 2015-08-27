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
@property (strong, nonatomic) UIRefreshControl *refreshController;
@end

@implementation SDSearchResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchResults = [[NSArray alloc]init];
    
    self.refreshController = [[UIRefreshControl alloc]init];
    [self setRefreshControl:self.refreshController];
    [self.refreshController addTarget:self action:@selector(refreshControlActivated:) forControlEvents:UIControlEventValueChanged];
    
    [self populateDataSource];
}

-(void)refreshControlActivated:(UIRefreshControl *)refreshControl
{
    [self populateDataSource];
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

-(void)populateDataSource
{
    
    //if the user is searching by genre, else, search by search text field
    if (self.genreString) {
        [self.refreshController beginRefreshing];
        [[SDSoundCloudAPI sharedManager]getTracksForGenre:self.genreString withCompletion:^(NSArray *tracks, BOOL error) {
            if (!error) {
                [[SDSoundCloudAPI sharedManager]parseTracks:tracks withCompletion:^(NSArray *parsedTracks) {
                    self.searchResults = parsedTracks;
                    [self.refreshController endRefreshing];
                    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
                }];
            }
        }];
    }
    else{
        
    }
    
}

@end
