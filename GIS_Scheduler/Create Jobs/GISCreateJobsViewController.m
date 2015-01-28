//
//  GISCreateJobsViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 08/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISCreateJobsViewController.h"

@interface GISCreateJobsViewController ()

@end

@implementation GISCreateJobsViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)cancelButtonPressed:(id)sender
{
    [self.delegate cancelButtonPressed:sender];
}

-(IBAction)doneButtonPressed:(id)sender
{
    [self.delegate doneButtonPressed:sender];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
