//
//  GISSummaryViewController.h
//  GIS_Scheduler
//
//  Created by Anand on 18/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISAppDelegate.h"
#import "GISLoginDetailsObject.h"
#import "GISPopOverTableViewController.h"
#import "GISChooseRequestDetailsObject.h"

@interface GISSummaryViewController : UIViewController<UITextViewDelegate,UIPopoverControllerDelegate,PopOverSelected_Protocol>
{
    GISAppDelegate *appDelegate;
    BOOL isCheckMark;
    BOOL isRequestSubmitted;
    GISLoginDetailsObject *loginObJ;
    NSString *serviceRequestData;
    int row_value;
    NSString *nextString;
    BOOL isSubmitClicked;
    NSMutableArray *detail_mut_array;
}

@property (strong, nonatomic) IBOutlet UITableView *summary_tableView;
@property(nonatomic,strong)GISChooseRequestDetailsObject *chooseRequestDetailsObj;
@property (strong, nonatomic) NSString *buildingNameString;
@property (strong, nonatomic) NSArray *buildingNameArray;
@property (strong, nonatomic) NSArray *generalLocationArray;
@property (strong, nonatomic) NSArray *closestMetroArray;
@property (strong, nonatomic) NSString *generalLocationId_string;
@property (strong, nonatomic) NSString *generalLocationValue_string;
@property (strong, nonatomic) NSString *closestMetroId_string;
@property (strong, nonatomic) NSString *closestMetroValue_string;

@property (strong, nonatomic) NSArray *eventTypeArray;
@property (strong, nonatomic) NSArray *dresscodeArray;
@property (strong, nonatomic) NSArray *chooseReqArray;
@property(nonatomic,strong)NSString *choose_req_Id_string;
@property (strong, nonatomic) NSArray *serviceTypeArray;
@property (strong, nonatomic) NSArray *serviceTypeSaveArray;
@property (nonatomic,strong) UIPopoverController *popover;


@end
