//
//  SDSearchTableViewController.m
//  Soundza
//
//  Created by Andrew Friedman on 8/27/15.
//  Copyright (c) 2015 Andrew Friedman. All rights reserved.
//

#import "SDSearchTableViewController.h"
#import "SDSoundCloudAPI.h"
#import "SDSearchResultsTableViewController.h"

static NSString *const KTableViewReuseIdentitifer = @"Cell";

@interface SDSearchTableViewController ()
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet ADBannerView *adBannerView;
@property (strong, nonatomic) NSArray *generes;
@property (assign ,nonatomic) BOOL fromSearch;
@end

@implementation SDSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.generes = [SDSoundCloudAPI listOfGenres];
    self.searchBar.delegate = self;
    
    self.adBannerView.delegate = self;
  }


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.generes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KTableViewReuseIdentitifer];
    NSString *genre = self.generes[indexPath.row];
    cell.textLabel.text = genre;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *genreSelected = self.generes[indexPath.row];
    self.fromSearch = NO;
    [self performSegueWithIdentifier:@"toResultsVC" sender:genreSelected];
}

#pragma mark - Search Bar Delegate / Data Source

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = NO;
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.fromSearch = YES;
    [searchBar resignFirstResponder];
    [self performSegueWithIdentifier:@"toResultsVC" sender:searchBar.text];
}


#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toResultsVC"]) {
        SDSearchResultsTableViewController *resultsVC = segue.destinationViewController;
        if (self.fromSearch) {
            resultsVC.searchString = sender;
            resultsVC.genreString = nil;
        }
        else{
            resultsVC.genreString = sender;
            resultsVC.searchString = nil;
        }
    }
}

#pragma mark - ADBannerViewDelegate

-(void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    NSLog(@"Banner Did Load");
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (error) {
        NSLog(@"iAd Banner Error");
    }
}

@end
