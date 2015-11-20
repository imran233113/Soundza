//
//  SAPageRootViewController.m
//  StreamacyBeta
//
//  Created by Andrew Friedman on 5/24/15.
//  Copyright (c) 2015 Andrew Friedman. All rights reserved.
//

#import "SAPageRootViewController.h"
#import "SDQueueViewController.h"
#import "SABaseContentViewController.h"
#import "PlayerManager.h"

@interface SAPageRootViewController ()
@property (strong, nonatomic) NSArray *contentPageRestorationIDs; // NSString
@property (nonatomic, strong) NSNumber *index;
@property (strong, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
- (IBAction)clearButtonPressed:(UIBarButtonItem *)sender;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *clearButton;
- (IBAction)segmentSwitch:(UISegmentedControl *)sender;
@end

@implementation SAPageRootViewController

- (IBAction)clearButtonPressed:(UIBarButtonItem *)sender
{
    [[PlayerManager sharedManager]clearQueue];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"clearQueue" object:nil];
    [self displayClearButton];
}

- (IBAction)segmentSwitch:(UISegmentedControl *)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        [self goToPreviousContentViewController:sender];
        self.clearButton.title = @"";
        self.clearButton.enabled = NO;
    }
    else{
        [self goToNextContentViewController:sender];
        [self displayClearButton];
        }
}


#pragma mark - Setters and Getters

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clearButton.title = @"";
    self.clearButton.enabled = NO;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Player" bundle:nil];
    UIPageViewController *pageViewController = [storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController = pageViewController;
    
    self.index = [[NSNumber alloc]init];
    
    //Open the last index, else open the current as the first view controller
    NSNumber *savedIndex = [[NSUserDefaults standardUserDefaults]
                            objectForKey:@"pageIndex"];
    int index = [savedIndex intValue];
    
    if (index == 0) {
        // Instantiate the first view controller.
        SABaseContentViewController *playerViewController = [storyboard instantiateViewControllerWithIdentifier:@"Player"];
        playerViewController.rootViewController = self;
        
        self.index = [NSNumber numberWithInt:0];
        
        self.segmentedControl.selectedSegmentIndex = 0;
        
        [self.pageViewController setViewControllers:@[playerViewController]
                                          direction:UIPageViewControllerNavigationDirectionForward
                                           animated:NO
                                         completion:^(BOOL finished) {
                                         }];
    }
    else {
        
        SABaseContentViewController *queueViewController = [storyboard instantiateViewControllerWithIdentifier:@"Queue"];
        queueViewController.rootViewController = self;
        
        self.index = [NSNumber numberWithInt:1];
        
        self.segmentedControl.selectedSegmentIndex = 1;
        // Instantiate the first view controller.
        [self.pageViewController setViewControllers:@[queueViewController]
                                          direction:UIPageViewControllerNavigationDirectionReverse
                                           animated:NO
                                         completion:^(BOOL finished) {
                                         }];
    }
    
    // Add the page view controller to this the page root view controller.
    [self addChildViewController:pageViewController];
    [self.view addSubview:pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    [self.view bringSubviewToFront:self.navigationBar];
    
    UIView *border = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 0.5)];
    border.backgroundColor = [UIColor colorWithRed:0.784 green:0.778 blue:0.801 alpha:1];
    [self.view addSubview:border];
    [self.view bringSubviewToFront:border];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    //save the last index to load for later
    [[NSUserDefaults standardUserDefaults] setObject:self.index forKey:@"pageIndex"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [super viewWillDisappear:animated];
}

#pragma mark - Public Methods
- (void)goToPreviousContentViewController:(UISegmentedControl *)sender;
{
    self.index = [NSNumber numberWithInt:0];
    
    sender.enabled = NO;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Player" bundle:nil];
    SABaseContentViewController*playerViewController = [storyboard instantiateViewControllerWithIdentifier:@"Player"];
    playerViewController.rootViewController = self;
    

    [self.pageViewController setViewControllers:@[playerViewController]
                                      direction:UIPageViewControllerNavigationDirectionReverse
                                       animated:YES
                                     completion:^(BOOL finished) {
                                         if (finished) {
                                             sender.enabled = YES;
                                         }
                                     }];
}

- (void)goToNextContentViewController:(UISegmentedControl *)sender;
{
    
    self.index = [NSNumber numberWithInt:1];
    
    sender.enabled = NO;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Player" bundle:nil];
    SDQueueViewController *queueViewController = [storyboard instantiateViewControllerWithIdentifier:@"Queue"];
    queueViewController.rootViewController = self;
    

    [self.pageViewController setViewControllers:@[queueViewController]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:^(BOOL finished) {
                                         if (finished) {
                                             sender.enabled = YES;
                                         }
                                     }];
}

-(void)displayClearButton;
{
    if ([PlayerManager sharedManager].queue.count) {
        self.clearButton.title = @"Clear";
        self.clearButton.enabled = YES;
    }
    else{
        self.clearButton.title = @"";
        self.clearButton.enabled = NO;
    }
}

@end
