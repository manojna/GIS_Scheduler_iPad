//
//  GISVIewEditRequestViewController.h
//  GIS_Scheduler
//
//  Created by Anand on 15/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISLoginDetailsObject.h"
#import "GISDropDownStore.h"
#import "GISPopOverTableViewController.h"
#import "GISAppDelegate.h"
#import "GISPopOverTableViewController.h"
#import "GISEventDetailsViewController.h"
#import "GISBaseViewController.h"


@interface GISVIewEditRequestViewController : GISBaseViewController<UITabBarDelegate,UIPopoverControllerDelegate,PopOverSelected_Protocol>
{
    GISLoginDetailsObject *login_Obj;
    GISDropDownStore *dropDownStore;
    NSMutableArray *requestNumbers_mutArray;
    GISAppDelegate *appDelegate;
    NSMutableArray *viewEdit_Array;
}
@property (nonatomic, strong) IBOutlet UILabel *requestID_Label;
@property (nonatomic, strong) IBOutlet UIButton *requestBtn;
@property (nonatomic, strong) IBOutlet UILabel *created_by_Label;
@property (nonatomic, strong) IBOutlet UILabel *created_by_value_Label;
@property (nonatomic, strong) IBOutlet UILabel *created_date_Label;
@property (nonatomic, strong) IBOutlet UILabel *created_date_value_Label;
@property (nonatomic, strong) IBOutlet UILabel *status_Label;
@property (nonatomic, strong) IBOutlet UILabel *status_value_Label;

@property (nonatomic, retain) NSArray *viewControllers;
@property (nonatomic, retain) UIViewController *currentController;
@property (nonatomic,strong) UIPopoverController *popover;

@property (nonatomic, retain) IBOutlet UIView *mainView;
@property (nonatomic, retain) IBOutlet UIView *topView;
@property (nonatomic, retain) IBOutlet UITabBar *mainTabbar;
@property (nonatomic, retain) IBOutlet UITabBarItem *contactItem;
@property (nonatomic, retain) IBOutlet UITabBarItem *eventDetailsItem;
@property (nonatomic, retain) IBOutlet UITabBarItem *attendeesItem;
@property (nonatomic, retain) IBOutlet UITabBarItem *locationdetaislItem;
@property (nonatomic, retain) IBOutlet UITabBarItem *datesItem;
@property (nonatomic, retain) IBOutlet UITabBarItem *jobdetailsItem;
@property (nonatomic, retain) IBOutlet UITabBarItem *summarYItem;
@property (nonatomic, retain) IBOutlet UITabBarItem *commentsItem;


@property (nonatomic, retain) IBOutlet UITabBar *mainnewTabbar;
@property (nonatomic, retain) IBOutlet UITabBarItem *contact_newItem;
@property (nonatomic, retain) IBOutlet UITabBarItem *eventDetails_newItem;
@property (nonatomic, retain) IBOutlet UITabBarItem *attendees_newItem;
@property (nonatomic, retain) IBOutlet UITabBarItem *locationdetais_newItem;
@property (nonatomic, retain) IBOutlet UITabBarItem *dates_newItem;
@property (nonatomic, retain) IBOutlet UITabBarItem *summarY_newItem;
@property (nonatomic, retain) IBOutlet UITabBarItem *comments_newItem;

@property (strong, nonatomic) NSArray *requetDetails;

@end
