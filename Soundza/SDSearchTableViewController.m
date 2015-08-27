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
@property (strong, nonatomic) NSArray *generes;
@end

@implementation SDSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.generes = [SDSoundCloudAPI listOfGenres];
    
    
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
    [self performSegueWithIdentifier:@"toResultsVC" sender:genreSelected];
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toResultsVC"]) {
        SDSearchResultsTableViewController *resultsVC = segue.destinationViewController;
        resultsVC.genreString = sender;
    }
}

@end
