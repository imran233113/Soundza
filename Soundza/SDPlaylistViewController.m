//
//  SDPlaylistViewController.m
//  Soundza
//
//  Created by Andrew Friedman on 9/7/15.
//  Copyright (c) 2015 Andrew Friedman. All rights reserved.
//

#import "SDPlaylistViewController.h"
#import "PlaylistManager.h"
#import "SDPlaylistTableViewCell.h"
#import "PlayerManager.h"

static NSString *const KTableViewReuseIdentitifer = @"Playlist";

@interface SDPlaylistViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tracks;
@end

@implementation SDPlaylistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.navigationItem.title = [PlaylistManager sharedManager].playlist.title;
    
    [self parseTracksReloadTableView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(trackSavedNotification:) name:@"songSaved" object:nil];

}

-(void)trackSavedNotification:(NSNotification *)notification
{
    [self parseTracksReloadTableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tracks.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SDPlaylistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KTableViewReuseIdentitifer];
    SDTrack *track = self.tracks[indexPath.row];
    [cell setupDisplayForTrack:track];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[PlayerManager sharedManager]playPlaylistTracks:self.tracks beginingAtIndex:indexPath.row];
}


#pragma mark - Local Methods

-(void)parseTracksReloadTableView
{
    RLMArray *tracks = [PlaylistManager sharedManager].playlist.tracks;
    [[PlaylistManager sharedManager]parseTracks:tracks withCompletion:^(NSArray *parsedTracks) {
        self.tracks = [parsedTracks mutableCopy];
        self.tableView.hidden = !self.tracks.count;
        [self.tableView reloadData];
    }];

}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
