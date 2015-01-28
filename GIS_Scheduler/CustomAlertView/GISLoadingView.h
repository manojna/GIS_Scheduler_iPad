//
//  GISLoadingView.h
//  Gallaudet-Interpreting-Service
//
//  Created by Anand on 29/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface GISLoadingView : UIAlertView

@property (nonatomic,strong) IBOutlet  UIAlertView *alertView;
+ (id) sharedDataManager;
-(void)addLoadingAlertView:(NSString *)message;
-(void)removeLoadingAlertview;

@end
