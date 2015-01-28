//
//  GISViewEditListViewController.h
//  GIS_Scheduler
//
//  Created by Anand on 16/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFEvent.h"
#import "GISAppDelegate.h"
#import "FFBlueButton.h"

@interface GISViewEditListViewController : UITableViewController
{
    GISAppDelegate *appDelegate;
}

@property (nonatomic,strong) NSMutableArray *eventArray;
@property (nonatomic, strong) FFEvent *testEvent;
@property (nonatomic, strong) FFBlueButton *eventButton;

@end
