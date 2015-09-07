//
//  SDTabBarViewController.m
//  Soundza
//
//  Created by Andrew Friedman on 8/27/15.
//  Copyright (c) 2015 Andrew Friedman. All rights reserved.
//

#import "SDTabBarViewController.h"
#import "SAActionAlertView.h"

@interface SDTabBarViewController ()
@property (strong, nonatomic) SAActionAlertView *alertView;
@property (strong, nonatomic) SAActionAlertView *saveAlert;
@end

@implementation SDTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *viewControllers = [[NSMutableArray alloc]initWithCapacity:3];
    [viewControllers addObject:[[UIStoryboard storyboardWithName:@"Search" bundle:nil] instantiateInitialViewController]];
    [viewControllers addObject:[[UIStoryboard storyboardWithName:@"Player" bundle:nil] instantiateInitialViewController]];
    [viewControllers addObject:[[UIStoryboard storyboardWithName:@"Playlist" bundle:nil] instantiateInitialViewController]];

    [self setViewControllers:viewControllers];
    
    UIViewController *searchVC = viewControllers[0];
    UIImage *tab1Image = [UIImage imageNamed:@"Search.png"];
    UITabBarItem *item1 = [[UITabBarItem alloc]initWithTitle:nil image:tab1Image selectedImage:nil];
    item1.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    searchVC.tabBarItem = item1;
    
    UIViewController *playerVC = viewControllers[1];
    UIImage *tab2Image = [UIImage imageNamed:@"StreamBlack.png"];
    UITabBarItem *item2 = [[UITabBarItem alloc]initWithTitle:nil image:tab2Image selectedImage:nil];
    item2.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    playerVC.tabBarItem = item2;

    UIViewController *playlistVC = viewControllers[2];
    UIImage *tab3Image = [UIImage imageNamed:@"Playlists.png"];
    UITabBarItem *item3 = [[UITabBarItem alloc]initWithTitle:nil image:tab3Image selectedImage:nil];
    item3.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    playlistVC.tabBarItem = item3;

    //Set the tint color to the SoundCloud orange
    [self.tabBar setTintColor:[UIColor colorWithRed:0.981 green:0.347 blue:0 alpha:1]];
    
    self.alertView = [[SAActionAlertView alloc]initWithTitle:@"Song Queued" view:self.view];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(songQueuedNotification:) name:@"songQueued" object:nil];
    self.saveAlert = [[SAActionAlertView alloc]initWithTitle:@"Song Saved" view:self.view];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(songSavedNotification:) name:@"songSaved" object:nil];

}
-(void)songSavedNotification:(NSNotification *)note
{
    [self.saveAlert animate];
}

-(void)songQueuedNotification:(NSNotification *)note
{
    [self.alertView animate];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
