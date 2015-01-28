//
//  GISEventDetailsViewController.h
//  GIS_Scheduler
//
//  Created by Anand on 15/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISBaseViewController.h"
#import "GISPopOverTableViewController.h"
#import "GISChooseRequestDetailsObject.h"
#import "GISLoginDetailsObject.h"

@interface GISEventDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPopoverControllerDelegate,PopOverSelected_Protocol,UITextViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>

{
    NSString *eventTypedata;
    NSString *dresscodeData;
    NSString *otherServicesdata;
    NSString *captionData;
    NSString *viewingTypeData;
    NSString *evevntNamedata;
    NSString *courseIdData;
    NSString *descriptionData;
    NSString *noOfUsersData;
    
    int btn_tag;
    BOOL broadCastSelected;
    GISAppDelegate *appDelegate;
    GISChooseRequestDetailsObject *chooseRequest_Detailed_DetailsObj;
    NSMutableArray *otherTechStr;
    NSMutableArray *material_types_Array;
    NSData *imgData;
    NSString *imageName;
    GISLoginDetailsObject *login_Obj;
    
    NSInteger responseCode;
    NSMutableData *responseData;
    NSString *unitString;
    NSString *newValueString;

    
}

@property (nonatomic, retain) IBOutlet UITableView *eventDetaislTabelView;
@property (strong, nonatomic) NSArray *eventTypeArray;
@property (strong, nonatomic) NSArray *dresscodeArray;
@property (strong, nonatomic) NSArray *otherServicesArray;
@property (strong, nonatomic) NSArray *captionTypeArray;
@property (strong, nonatomic) NSArray *viewingTypeArray;
@property (nonatomic,strong) UIPopoverController *popover;
@property(nonatomic,retain) IBOutlet UIView * alertCustomView;
@property(nonatomic,strong)NSMutableString *fields;
@property (strong, nonatomic) NSArray *otherTechArray;
@property (strong, nonatomic) NSArray *requetDetails;

@property(nonatomic,strong)NSString *choose_req_Id_string;
@property(nonatomic,strong)NSString *eventTypeId_string;
@property(nonatomic,strong)NSString *dressCode_Id_string;
@property(nonatomic,strong)NSString *open_toPublicStr;
@property(nonatomic,strong)NSString *re_broadcastStr;
@property(nonatomic,strong)NSString *on_goingStr;
@property(nonatomic,strong)NSString *otherServices_Str;
@property(nonatomic,strong)NSString *captioningType_Str;
@property(nonatomic,strong)NSString *viewingType_Str;
@property(nonatomic,strong)NSString *blackboard_accessStr;
@property(nonatomic,strong)NSString *websiteStr;
@property(nonatomic,strong)NSString *other_Str;
@property(nonatomic,strong)NSString *broadcastType_Str;
@property(nonatomic,strong)NSMutableString *othertechvalueStr;
@property(nonatomic,strong)NSString *eventdetails_unitIdStr;
@property(nonatomic,strong)NSString *eventdetails_statusStr;
@property(nonatomic,strong)NSString *eventdetails_viewOptions;
@property(nonatomic,strong)NSString *outsideAgencyStr;

@property (strong, nonatomic) IBOutlet UILabel *doumentLabel;
@property (strong, nonatomic) IBOutlet UILabel *blackBoardLabe;
@property (strong, nonatomic) IBOutlet UILabel *websiteLabel;
@property (strong, nonatomic) IBOutlet UILabel *otherLabel;
@property(nonatomic,strong)NSString *document_Str;


- (IBAction)previousVersionBtnTap:(id)sender;
- (IBAction)showPopoverDetails:(id)sender;


@end
