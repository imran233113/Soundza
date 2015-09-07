//
//  SAActionAlertView.m
//  StreamacyBeta
//
//  Created by Andrew Friedman on 6/28/15.
//  Copyright (c) 2015 Andrew Friedman. All rights reserved.
//

#import "SAActionAlertView.h"

@implementation SAActionAlertView

-(id)initWithTitle:(NSString *)title view:(UIView *)view;
{
    self = [super init];
    if (self){
        
        self = [[[NSBundle mainBundle]loadNibNamed:@"ActionAlertView" owner:self options:nil]objectAtIndex:0];
        
        self.actionAlertText.text = title;
        self.view = view;
        
    }
    return self;
}

-(void)animate;
{
    [self.view addSubview:self];
    self.center = self.superview.center;
    self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.20 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){
        [UIView animateWithDuration:.2 delay:1.25 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.alpha = .25;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            self.alpha = 1;
        }];
    }];
}

@end
