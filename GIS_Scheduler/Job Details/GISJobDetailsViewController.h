//
//  GISJobDetailsViewController.h
//  GIS_Scheduler
//
//  Created by Paradigm on 18/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISPopOverTableViewController.h"
#import "GISAppDelegate.h"
#import "GISLoginDetailsObject.h"
#import "GISChooseRequestDetailsObject.h"
@interface GISJobDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPopoverControllerDelegate,PopOverSelected_Protocol,UITextFieldDelegate,UITextViewDelegate>
{
    GISChooseRequestDetailsObject *chooseRequestDetailsObj;
    IBOutlet UITableView *jobDetails_tableView;
    
    UIPopoverController *popover;
    int btnTag;
    int rowValue;
    BOOL deleteClicked;
    
    NSMutableArray *serviceProvider_Array;
    NSMutableArray *payLevel_Array;
    NSMutableArray *billLevel_Array;
    NSMutableArray *filled_Unfilled_Array;
    NSMutableArray *jobDetails_Array;
    
    GISAppDelegate *appDelegate;

    GISLoginDetailsObject *login_Obj;
    int selected_row;
    NSString *jobDate_temp_string;
    NSString *startTime_temp_string;
    NSString *endTime_temp_string;
    NSString *typeOfservice_temp_string;
    NSString *serviceProvider_temp_string;
    NSString *payType_temp_string;
    BOOL isDelete;
    int currentObjTag_toDelete;
    int currentObjTagCreated;
    IBOutlet UIView *jobChangeHistory_background_UIView;
     IBOutlet UIView *jobChangeHistory_foreground_UIView;
    
    IBOutlet UIView *createJobs_UIVIew;
    IBOutlet UIView *createJobs_Middle_UIVIew;
    IBOutlet UITableView *createJObs_tableView;
    
    IBOutlet UITextField *noOfServiceProviders_TextField;
    IBOutlet UILabel *typeOfServiceProvidersLabel;
    IBOutlet UILabel *payLevel_Label;
    IBOutlet UILabel *billLevel_Label;
    NSMutableDictionary *createJobsCheckDictionary;
    BOOL isAlljobs_Checked;
    IBOutlet UIButton *alljobs_Checked_button;
    NSMutableArray *detail_mut_array;
    
    NSMutableArray *typeOfService_array;
    NSMutableArray *serviceProvider_array_tableView;
    NSMutableArray *payType_array;
    
    IBOutlet UILabel *jobDate_Answer_Label;
    IBOutlet UILabel *serviceProvider_Answer_Label;
    IBOutlet UILabel *filledUnfilled_Answer_Label;
    IBOutlet UILabel *typeOfServiceProviders_Answer_Label;
    IBOutlet UILabel *payLevel_Answer_Label;
    IBOutlet UILabel *billLevel_Answer_Label;
    
    IBOutlet UILabel *startDate_jobHistory_Answer_Label;
    IBOutlet UILabel *endDate_jobHistory_Answer_Label;
    IBOutlet UITextField *user_textField;
    IBOutlet UITextView *jobHistory_textView;
    IBOutlet UIButton *next_button;
    IBOutlet UIButton *create_job_button;
    
    BOOL isEdit_Button_Clicked;
    
    NSString *chooseRequestID_string;
    
    //UITextField *numberOfServiceProviders_Field;

    NSString *numberOfServiceProviders_string;
    
    NSString *serviceProvider_ID_string;
    NSString *filledUnfilled_ID_string;
    NSMutableArray *createJobdate_Array;
    NSString *serviceProvider_selectedString;
}

@property(nonatomic,strong)NSMutableArray *detail_mut_array;
-(IBAction)createJobsButton_Pressed:(id)sender;
-(IBAction)cancelButtonPressed_CreateJobs:(id)sender;
-(IBAction)doneButtonPressed_CreateJobs:(id)sender;
-(IBAction)checkAllJobs_buttonPressed:(id)sender;

-(IBAction)nextButtonPressed:(id)sender;
-(IBAction)pickerButtonPressed:(id)sender;
-(void)editButtonPressed:(id)sender;
-(void)deleteButtonPressed:(id)sender;
-(IBAction)addNewJob_buttonPressed:(id)sender;
-(IBAction)searchButtonPressed:(id)sender;

-(IBAction)jobHistory_TitleButtonPressed:(id)sender;


@end
