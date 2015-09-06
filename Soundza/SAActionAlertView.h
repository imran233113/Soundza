//
//  SAActionAlertView.h
//  StreamacyBeta
//
//  Created by Andrew Friedman on 6/28/15.
//  Copyright (c) 2015 Andrew Friedman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAActionAlertView : UIView
@property (strong, nonatomic) IBOutlet UILabel *actionAlertText;
@property (strong, nonatomic) UIView *view;
@property (strong, nonatomic) IBOutlet UIImageView *checkMarkImage;
-(id)initWithTitle:(NSString *)title view:(UIView *)view;;
-(void)animate;
@end
