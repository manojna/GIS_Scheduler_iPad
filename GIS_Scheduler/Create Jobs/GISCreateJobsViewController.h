//
//  GISCreateJobsViewController.h
//  GIS_Scheduler
//
//  Created by Paradigm on 08/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CreateJobsProtocol <NSObject>

@optional
-(void)cancelButtonPressed:(id)sender;
-(void)doneButtonPressed:(id)sender;
@end

@interface GISCreateJobsViewController : UIViewController

@property(nonatomic,strong) id <CreateJobsProtocol> delegate;

-(IBAction)cancelButtonPressed:(id)sender;
-(IBAction)doneButtonPressed:(id)sender;

@end
