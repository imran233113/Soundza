//
//  SAPageRootViewController.h
//  StreamacyBeta
//
//  Created by Andrew Friedman on 5/24/15.
//  Copyright (c) 2015 Andrew Friedman. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDPlayerViewController;
@class SDQueueTableViewController;

@interface SAPageRootViewController : UIViewController
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) SDPlayerViewController *playerViewController;
@property (strong, nonatomic) SDQueueTableViewController *queueViewController;
@end
