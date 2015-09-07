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
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editBarButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *renameBarButton;
@property (strong, nonatomic) RLMArray *RLMTracks;
@property (assign, nonatomic) BOOL editSelected;
- (IBAction)editBarButtonPressed:(id)sender;
- (IBAction)renameBarButtonPressed:(id)sender;
@end

@implementation SDPlaylistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView setEditing:YES];
    self.tableView.allowsSelectionDuringEditing = YES;
    
    self.RLMTracks = [PlaylistManager sharedManager].playlist.tracks;
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

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tracks removeObjectAtIndex:indexPath.row];
        
        RLMRealm *defaultRealm = [RLMRealm defaultRealm];
        [defaultRealm beginWriteTransaction];
        [self.RLMTracks removeObjectAtIndex:indexPath.row];
        [defaultRealm commitWriteTransaction];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.editSelected) {
        return UITableViewCellEditingStyleDelete;
    }
    else {
    return UITableViewCellEditingStyleNone;
    }
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSDictionary *track = [self.tracks objectAtIndex:sourceIndexPath.row];
    [self.tracks removeObjectAtIndex:sourceIndexPath.row];
    [self.tracks insertObject:track atIndex:destinationIndexPath.row];
    
    RLMRealm *defaultRealm = [RLMRealm defaultRealm];
    [defaultRealm beginWriteTransaction];
    RLMTrack *rlmtrack = [self.RLMTracks objectAtIndex:sourceIndexPath.row];
    [self.RLMTracks removeObjectAtIndex:sourceIndexPath.row];
    [self.RLMTracks insertObject:rlmtrack atIndex:destinationIndexPath.row];
    [defaultRealm commitWriteTransaction];
    
    [self.tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableview shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        if (self.editSelected)
            return YES;
        else
            return NO;
    }
    else
        return NO;
}


-(NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if( sourceIndexPath.section != proposedDestinationIndexPath.section )
        return [NSIndexPath indexPathForRow:0 inSection:1];
    else
        return proposedDestinationIndexPath;
}

#pragma mark - Buttons

- (IBAction)editBarButtonPressed:(id)sender
{
    if (self.editSelected) {
        self.editBarButton.title = @"Edit";
        self.editSelected = NO;
        [self.tableView reloadData];
    }
    else{
        self.editBarButton.title = @"Done";
        self.editSelected = YES;
        [self.tableView reloadData];
    }
}

- (IBAction)renameBarButtonPressed:(id)sender
{
    
}

#pragma mark - Local Methods

-(void)parseTracksReloadTableView
{
    RLMArray *tracks = self.RLMTracks;
    [[PlaylistManager sharedManager]parseTracks:tracks withCompletion:^(NSArray *parsedTracks) {
        self.tracks = [parsedTracks mutableCopy];
        self.tableView.hidden = !self.tracks.count;
        self.toolBar.hidden = !self.tracks.count;
        [self.tableView reloadData];
    }];

}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
