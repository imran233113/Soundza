//
//  SDQueueViewController.m
//  
//
//  Created by Andrew Friedman on 8/28/15.
//
//

#import "SDQueueViewController.h"
#import "SDQueueTableViewCell.h"
#import "PlayerManager.h"

static NSString *const KTableViewReuseIdentitifer = @"Queue";

@interface SDQueueViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *queueArray;
@end

@implementation SDQueueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self setupDisplay];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(songQueuedNotification:) name:@"songQueued" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playerUpdatedNotification:) name:@"updatedPlayer" object:nil];
    
}

#pragma mark - Table View Delegate / Data Source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.queueArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SDQueueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KTableViewReuseIdentitifer];
    SDTrack *track = self.queueArray[indexPath.row];
    cell.queueCountLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)indexPath.row+1];
    [cell setupDisplayForTrack:track];
    return cell;
}



#pragma mark - NSNotification Center


-(void)playerUpdatedNotification:(NSNotification *)notification
{
    [self setupDisplay];
}

-(void)songQueuedNotification:(NSNotification *)notification
{
    [self setupDisplay];
}

#pragma mark - Private Methods

-(void)setupDisplay
{
    self.queueArray = [PlayerManager sharedManager].queue;
    self.tableView.hidden = !self.queueArray.count;
    [self.tableView reloadData];
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
