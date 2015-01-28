//
//  GISDatesAndTimesViewController.h
//  GIS_Scheduler
//
//  Created by Paradigm on 15/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISPopOverTableViewController.h"
#import "GISAppDelegate.h"
#import "GISLoginDetailsObject.h"
#import "GISCreateJobsViewController.h"
#import "GISChooseRequestDetailsObject.h"
@interface GISDatesAndTimesViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIPopoverControllerDelegate,PopOverSelected_Protocol,CreateJobsProtocol,UITextFieldDelegate>
{
    GISAppDelegate *appDelegate;
    GISChooseRequestDetailsObject *chooseRequestDetailsObj;
    
    IBOutlet UITableView *datesTimes_tableView;

    IBOutlet UILabel *startDate_Label;
    IBOutlet UITextField *startDate_TextField;
    
    IBOutlet UILabel *endDate_Label;
    IBOutlet UITextField *endDate_TextField;
    
    IBOutlet UILabel *startTime_Label;
    IBOutlet UITextField *startTime_TextField;
    
    IBOutlet UILabel *endTime_Label;
    IBOutlet UITextField *endTime_TextField;
    
    IBOutlet UILabel *weekDays_Label;
    IBOutlet UILabel *monday_Label;
    IBOutlet UILabel *tuesday_Label;
    IBOutlet UILabel *wednesday_Label;
    IBOutlet UILabel *thursday_Label;
    IBOutlet UILabel *friday_Label;
    IBOutlet UILabel *saturday_Label;
    IBOutlet UILabel *sunday_Label;
    
    IBOutlet UIButton *create_DateTime_Button;
    IBOutlet UIButton *create_Jobs_Button;
    IBOutlet UIButton *next_Button;

    IBOutlet UIView *weekDays_UIView;

    IBOutlet UIButton *monday_Button;
    IBOutlet UIButton *tuesday_Button;
    IBOutlet UIButton *wednesday_Button;
    IBOutlet UIButton *thursday_Button;
    IBOutlet UIButton *friday_Button;
    IBOutlet UIButton *saturday_Button;
    IBOutlet UIButton *sunday_Button;
    
    IBOutlet UIImageView *monday_ImageView;
    IBOutlet UIImageView *tuesday_ImageView;
    IBOutlet UIImageView *wednesday_ImageView;
    IBOutlet UIImageView *thursday_ImageView;
    IBOutlet UIImageView *friday_ImageView;
    IBOutlet UIImageView *saturday_ImageView;
    IBOutlet UIImageView *sunday_ImageView;
    
    IBOutlet UILabel *dateLabel;
    IBOutlet UILabel *dayLabel;
    IBOutlet UILabel *startTime_Header_Label;
    IBOutlet UILabel *endTime_header_Label;
    IBOutlet UILabel *editALL_Label;

    
    __weak IBOutlet UILabel *createDatesTimes_Label;
    __weak IBOutlet UILabel *viewEditDatesTimes_Label;
    UIPopoverController *popover;
    int btnTag;
    
    NSMutableDictionary *weekDays_dictionary_here;
    NSMutableArray *createDateTimes_mutArray;
    NSMutableArray *detail_mut_array;
    
    NSDateFormatter *dateformatter;
    NSDateFormatter *timeformatter;
    BOOL isDelete;
    int currentObjTag_toDelete;

    GISLoginDetailsObject *login_Obj;
    int selected_row;
    GISPopOverTableViewController *tableViewController;
    
    NSString *date_temp_string;
    NSString *endTime_temp_string;
    NSString *startTime_temp_string;
    NSString *day_temp_string;
    
    BOOL isDateTimeDataAvailable;
    
    GISCreateJobsViewController *createJobs;
    
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
    
    ///////
    NSString *numberOfServiceProviders_string;
    IBOutlet UILabel *typeOfServiceProviders_Answer_Label;
    IBOutlet UILabel *payLevel_Answer_Label;
    IBOutlet UILabel *billLevel_Answer_Label;
    
    //NSMutableArray *serviceProvider_Array;
    NSMutableArray *payLevel_Array;
    NSMutableArray *billLevel_Array;
    NSMutableArray *typeOfServiceProvider_Array;
    
    BOOL isUpdated;
    
}
@property(nonatomic,strong) IBOutlet UIButton *cancelBtn_createJobs;
@property(nonatomic,strong) IBOutlet UIButton *doneBtn_createJobs;
@property(nonatomic,retain) NSString * inCompleteTab_string;
@property(nonatomic,retain) NSString * isCompleteRequest;

@property(nonatomic,strong)  NSMutableArray *createDateTimes_mutArray;
@property(nonatomic,strong)NSMutableArray *detail_mut_array;

-(IBAction)weekDays_ButtonPressed:(id)sender;
-(IBAction)createDateTimeButtonPressed:(id)sender;

-(IBAction)dateButton_Edit_Pressed:(id)sender;
-(IBAction)startTimeButton_Edit_Pressed:(id)sender;
-(IBAction)endTimeButton_Edit_Pressed:(id)sender;

-(IBAction)saveButton_Edit_Pressed:(id)sender;
-(IBAction)cancelButton_Edit_Pressed:(id)sender;
-(IBAction)nextButtonPressed:(id)sender;
-(IBAction)createJobsButton_Pressed:(id)sender;

-(IBAction)cancelButtonPressed_CreateJobs:(id)sender;
-(IBAction)doneButtonPressed_CreateJobs:(id)sender;

-(IBAction)checkAllJobs_buttonPressed:(id)sender;


-(IBAction)pickerButtonPressed:(id)sender;

-(void)clearDateTimes_Data;
@end
