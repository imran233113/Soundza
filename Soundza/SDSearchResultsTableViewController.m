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

static NSString *const KSearchResultsTableViewCellReuseID = @"Results";

@interface SDSearchResultsTableViewController ()
@property (strong, nonatomic) NSArray *searchResults;
@end

@implementation SDSearchResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIRefreshControl *refreshController = [[UIRefreshControl alloc]init];
    [self setRefreshControl:refreshController];
    [refreshController addTarget:self action:@selector(refreshControlActivated:) forControlEvents:UIControlEventValueChanged];
    
    [refreshController beginRefreshing];
    [[SDSoundCloudAPI sharedManager]getTracksForGenre:self.genreString withCompletion:^(NSArray *tracks, BOOL error) {
        if (!error) {
            [refreshController endRefreshing];
            self.searchResults = tracks;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
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
    
    return cell;
}

@end
