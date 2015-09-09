//
//  SDPlaylistsViewController.m
//  Soundza
//
//  Created by Andrew Friedman on 9/9/15.
//  Copyright (c) 2015 Andrew Friedman. All rights reserved.
//

#import "SDPlaylistsViewController.h"
#import "SDPlaylistsTableViewCell.h"
#import "PlaylistManager.h"

static NSString *const KTableViewReuseIdentitifer = @"Playlists";

@interface SDPlaylistsViewController ()
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)backBarButtonPressed:(id)sender;

@property (strong, nonatomic) RLMResults *playlists;
@end

@implementation SDPlaylistsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.navBar.tintColor = [UIColor colorWithRed:0.981 green:0.347 blue:0 alpha:1];
    
    
    RLMResults *playlists = [[RLMPlaylist allObjects]sortedResultsUsingProperty:@"createdAt" ascending:NO];
    self.playlists = playlists;
    
    
}

#pragma mark - UITableView Delegate/Data Source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.playlists.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SDPlaylistsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KTableViewReuseIdentitifer];
    RLMPlaylist *playlist = self.playlists[indexPath.row];
    cell.titleLabel.text = playlist.title;
    return cell;
}


#pragma mark - Custom Buttons

- (IBAction)backBarButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
