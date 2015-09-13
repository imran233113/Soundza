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
#import "SDCreatePlaylistTableViewCell.h"

static NSString *const KTableViewReuseIdentitifer = @"Playlists";
static NSString *const KTableViewNewReuseIdentitifer = @"New";


@interface SDPlaylistsViewController ()
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UITextField *createTextField;
- (IBAction)backBarButtonPressed:(id)sender;

@property (strong, nonatomic) RLMResults *playlists;
@end

@implementation SDPlaylistsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.navBar.tintColor = [UIColor colorWithRed:0.981 green:0.347 blue:0 alpha:1];
    
    RLMResults *playlists = [[RLMPlaylist allObjects]sortedResultsUsingProperty:@"createdAt" ascending:YES];
    self.playlists = playlists;
    
    
}

#pragma mark - UITableView Delegate/Data Source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return 1;
    else
        return self.playlists.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        SDPlaylistsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KTableViewReuseIdentitifer];
        RLMPlaylist *playlist = self.playlists[indexPath.row];
        [cell setupDisplayForPlaylist:playlist];
        return cell;

    }
    else{
        SDCreatePlaylistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KTableViewNewReuseIdentitifer];
        cell.textField.delegate = self;
        cell.textField.tintColor = [UIColor colorWithRed:0.981 green:0.347 blue:0 alpha:1];
        return cell;

    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        SDCreatePlaylistTableViewCell *cell = (SDCreatePlaylistTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        [cell.textField becomeFirstResponder];
    }
    else
    {
        RLMPlaylist *selectedPlaylist = self.playlists[indexPath.row];
        [[PlaylistManager sharedManager]switchCurrentWithPlaylist:selectedPlaylist];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.createTextField resignFirstResponder];
}

#pragma mark - UITextField Delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.createTextField = textField;
    textField.text = nil;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.text = @"New Playlist";
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [[PlaylistManager sharedManager]createNewPlaylistWithTitle:textField.text];
    [textField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
    return YES;
}


#pragma mark - Custom Buttons

- (IBAction)backBarButtonPressed:(id)sender
{
    [self.createTextField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
