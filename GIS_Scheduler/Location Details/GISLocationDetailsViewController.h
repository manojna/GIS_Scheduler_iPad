//
//  GISLocationDetailsViewController.h
//  GIS_Scheduler
//
//  Created by Anand on 17/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISPopOverTableViewController.h"
#import "GISChooseRequestDetailsObject.h"
#import "GISAppDelegate.h"

@interface GISLocationDetailsViewController : UIViewController<UIPopoverControllerDelegate,PopOverSelected_Protocol,UITextFieldDelegate,UITextViewDelegate>
{
    int btn_tag;
    GISAppDelegate *appDelegate;
}

@property (nonatomic, retain) IBOutlet UITableView *locationDetaislTabelView;
@property (strong, nonatomic) NSArray *chooseReqArray;
@property (strong, nonatomic) NSArray *generalLocationArray;
@property (strong, nonatomic) NSArray *closestMetroArray;
@property (strong, nonatomic) NSArray *buildingNameArray;

@property (nonatomic,strong) UIPopoverController *popover;


@property (strong, nonatomic) NSArray *getParkingArray;
@property (strong, nonatomic) NSArray *getParkingOfflocArray;
@property (strong, nonatomic) NSMutableArray *parkingArray;
@property (strong, nonatomic) NSString *chooseRequestData;
@property (strong, nonatomic) NSString *generalLocationdata;
@property (strong, nonatomic) NSString *buildingNamedata;
@property (strong, nonatomic) NSString *closestMetrodata;

@property(nonatomic,strong)NSString *choose_req_Id_string;
@property(nonatomic,strong)NSString *generalLocationId_string;
@property(nonatomic,strong)NSString *buildingname_Id_string;
@property(nonatomic,strong)NSString *closestMetro_Id_string;
@property(nonatomic,strong)NSString *other_string;
@property(nonatomic,strong)NSString *specialProtocol_string;
@property(nonatomic,strong)NSString *room_name_string;
@property(nonatomic,strong)NSString *room_no_string;
@property(nonatomic,strong)NSString *requestID_string;
@property(nonatomic,strong)NSMutableString *parkingstring;
@property(nonatomic,strong)NSString *parking_value_String;
@property(nonatomic,strong)NSString *requestorLocationId_string;
@property(nonatomic,strong)GISChooseRequestDetailsObject *chooseRequestDetailsObj;

@property(nonatomic,strong)NSString *LocationName_string;
@property(nonatomic,strong)NSString *locationName_ID_string;
@property(nonatomic,strong)NSString *locationName_Value_string;
@property(nonatomic,strong)NSString *city_string;
@property(nonatomic,strong)NSString *state_string;
@property(nonatomic,strong)NSString *zip_string;
@property(nonatomic,strong)NSString *address1_string;
@property(nonatomic,strong)NSString *address2_string;
@property(nonatomic,strong)NSString *special_string;
@property(nonatomic,strong)NSString *otherinfo_string;
@property(nonatomic,strong)NSString *transportation_string;
@property(nonatomic,strong)NSString *transportationYes_string;
@property(nonatomic,strong)NSMutableString *fields;
@property(nonatomic,strong)NSMutableArray *locationNames;
@property(nonatomic,retain) NSString * inCompleteTab_string;
@property(nonatomic,retain) NSString * isCompleteRequest;

@end
