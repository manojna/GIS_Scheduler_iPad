//
//  GISLoadingView.m
//  Gallaudet-Interpreting-Service
//
//  Created by Anand on 29/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISLoadingView.h"

@implementation GISLoadingView

static GISLoadingView *loadingView = nil;

+ (id) sharedDataManager
{
    if (loadingView == nil)
    {
        loadingView =  [[super allocWithZone:NULL] init];
    }
    return loadingView;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

-(void)addLoadingAlertView:(NSString *)message{
    
    //a simple alert view with a simple message:
    if(_alertView == nil)
    {
        _alertView = [[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        //a simple activity indicator:
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicator.frame= CGRectMake(50, 10, 37, 37);
        activityIndicator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
        [activityIndicator startAnimating];
        [_alertView setValue:activityIndicator forKey:@"accessoryView"];
        [_alertView setMessage:message];
        [_alertView show];
    }
    //the magic line below,
    //we associate the activity indicator to the alert view: (addSubview is not used)
}

-(void)removeLoadingAlertview{
    if (_alertView)
    {
        [_alertView dismissWithClickedButtonIndex:0 animated:YES];
        _alertView = nil;
    }
    // _alertView = nil;
}

@end
