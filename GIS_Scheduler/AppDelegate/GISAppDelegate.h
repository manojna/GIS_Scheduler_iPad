//
//  AppDelegate.h
//  GIS_Scheduler
//
//  Created by Paradigm on 08/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISContactAndBillingObject.h"

@interface GISAppDelegate : UIResponder <UIApplicationDelegate,UISplitViewControllerDelegate>

@property (nonatomic) SEL finishAction_chooseRequestNumber;
@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic) UISplitViewController *spiltViewController;

@property (strong, nonatomic) UINavigationController *navigationcontroller;

@property(nonatomic,strong)id detailViewController;

@property (readwrite, nonatomic) BOOL isLogout;
@property (readwrite, nonatomic) BOOL isContact;

@property (readwrite, nonatomic) BOOL isFromContacts;
@property (readwrite, nonatomic) BOOL isNewRequest;
@property (readwrite, nonatomic) BOOL isAttendees;
@property (readwrite, nonatomic) BOOL isFromViewEditService;
@property (readwrite, nonatomic) BOOL isNoofAttendees;
@property (readwrite, nonatomic) BOOL isShowfromDashboard;
@property (readwrite, nonatomic) BOOL isHidefromDashboard;
@property (readwrite, nonatomic) BOOL isfilled;
@property (readwrite, nonatomic) BOOL isRefreshIndex;
@property (readwrite, nonatomic) BOOL isShowfromSPRequestedJobs;


@property(nonatomic,strong) GISContactAndBillingObject *contact_billingObject;
@property(nonatomic,strong) NSString *chooseRequest_ID_String;
@property(nonatomic,strong) NSString *chooseRequest_Value_String;

@property (strong, nonatomic) NSString *createdByString;
@property (strong, nonatomic) NSString *createdDateString;
@property (strong, nonatomic) NSString *statusString;

@property (strong, nonatomic) NSMutableArray *attendeesArray;
@property (strong, nonatomic) NSMutableArray *datesArray;
@property (strong, nonatomic) NSMutableArray *detailArray;
@property (strong, nonatomic) NSMutableArray *jobEventsArray;
@property (strong, nonatomic) NSMutableArray *jobDetailsArray;
@property (strong, nonatomic) NSMutableArray *payTypeArray;
@property (strong, nonatomic) NSMutableArray *serviceTypeArray;
@property (strong, nonatomic) NSMutableArray *monthEventsArray;
@property (strong, nonatomic) NSMutableArray *showEventsArray;

@property (readwrite, nonatomic) BOOL isFromAttendees;
@property (readwrite, nonatomic) BOOL isFromlocation;

@property (readwrite, nonatomic) BOOL isDateView;
@property (readwrite, nonatomic) BOOL isWeekView;
@property (readwrite, nonatomic) BOOL isMonthView;
@property (readwrite, nonatomic) BOOL isoneEvent;
@property (readwrite, nonatomic) BOOL islatestEvent;


@property (strong, nonatomic) NSMutableDictionary *addNewJob_dictionary;

@end
