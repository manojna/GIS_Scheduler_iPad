//
//  GISAddUpdateJobsViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 09/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISAddUpdateJobsViewController.h"
#import "GISAddUpdateJobCell.h"
#import "GISPopOverTableViewController.h"
#import "GISConstants.h"
#import "GISStoreManager.h"
#import "GISDatabaseManager.h"
#import "Constants.h"
#import "GISJSONProperties.h"
#import "GISServerManager.h"
#import "GISLoadingView.h"
#import "GISJsonRequest.h"
#import "GISUtility.h"
@interface GISAddUpdateJobsViewController ()

@end

@implementation GISAddUpdateJobsViewController

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
    appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
    NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
    login_Obj=[requetId_array lastObject];
    history_Clicked = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [addUpdateJobs_tableView reloadData];
    self.navigationItem.hidesBackButton=YES;
    addUpdateObj=[[GISAddUpdateObject alloc]init];
    callInTime_Array=[[NSMutableArray alloc]init];
    payLevel_Array=[[NSMutableArray alloc]init];
    typeOfserviceProvider_Array=[[NSMutableArray alloc]init];
    serviceProvider_ID_Array=[[NSMutableArray alloc]init];
    cancelled_Array=[[NSMutableArray alloc]initWithObjects:@"Timely",@"UnTimely" ,nil];
    payLevel_Array=[[NSMutableArray alloc]init];
    payType_Array=[[NSMutableArray alloc]init];
    parking_Array=[[NSMutableArray alloc]init];
    billAmt_Array=[[NSMutableArray alloc]init];
    mileage_Array=[[NSMutableArray alloc]init];
    invoice_Array=[[NSMutableArray alloc]init];
    amtpaid_Array=[[NSMutableArray alloc]init];
    billDate_Array=[[NSMutableArray alloc]init];
    agencyFee_Array=[[NSMutableArray alloc]init];
    payStatus_Array=[[NSMutableArray alloc]init];
    expStatus_Array=[[NSMutableArray alloc]init];
    billLevel_Array=[[NSMutableArray alloc]init];
    
    //payLevel_Array=[[GISStoreManager sharedManager]getPayLevelObjects];

    
    NSString *payType_statement = [[NSString alloc]initWithFormat:@"select * from TBL_PAY_TYPE"];
    payType_Array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:payType_statement] mutableCopy];
    NSString *spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO"];
    serviceProvider_ID_Array = [[[GISDatabaseManager sharedDataManager] getServiceProviderArray:spCode_statement] mutableCopy];
    
    NSString *typeOfService_statement = [[NSString alloc]initWithFormat:@"select * from TBL_TYPE_OF_SERVICE  ORDER BY ID DESC;"];
    typeOfserviceProvider_Array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:typeOfService_statement] mutableCopy];
    
    payStatus_Array=[[GISStoreManager sharedManager]getPayStatus_ExpStatusObjects];
    expStatus_Array=[[GISStoreManager sharedManager]getPayStatus_ExpStatusObjects];
    payLevel_Array=[[GISStoreManager sharedManager]getPayLevelObjects];
    billLevel_Array=[[GISStoreManager sharedManager]getBillLevelObjects];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISAddUpdateJobCell *cell;
    
    if (indexPath.section==0)
    {
        cell=(GISAddUpdateJobCell *)[tableView dequeueReusableCellWithIdentifier:@"GISAddUpdateJobCell"];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISJobInfoCell" owner:self options:nil] objectAtIndex:0];
        }
        if ([addUpdateObj.jobDate_string length])
            cell.jobDate_answer_label.text=addUpdateObj.jobDate_string;
        if ([addUpdateObj.startTime_string length])
            cell.startTime_answer_label.text=addUpdateObj.startTime_string;
        if ([addUpdateObj.endTime_string length])
            cell.endTime_answer_label.text=addUpdateObj.endTime_string;
        
        if ([addUpdateObj.callInTime_string length])
            cell.callInTime_answer_label.text=addUpdateObj.callInTime_string;
        else
            cell.callInTime_answer_label.text = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
        
        if ([addUpdateObj.payLevel_string length])
            cell.payLevel_answer_label.text=addUpdateObj.payLevel_string;
        else
            cell.payLevel_answer_label.text = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
        
        if ([addUpdateObj.billLevel_string length])
            cell.billLevel_answer_label.text=addUpdateObj.billLevel_string;
        else
            cell.billLevel_answer_label.text = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
        
        if ([addUpdateObj.typeOfServiceProvider_string length])
            cell.typeOfServiceProvider_answer_label.text=addUpdateObj.typeOfServiceProvider_string;
        else
            cell.typeOfServiceProvider_answer_label.text = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
        
        if ([addUpdateObj.serviceProvider_string length])
            cell.serviceProviderId_answer_label.text=addUpdateObj.serviceProvider_string;
        else
            cell.serviceProviderId_answer_label.text = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
        
        if ([addUpdateObj.cancelled_string length])
            cell.cancelled_answer_label.text=addUpdateObj.cancelled_string;
        else
            cell.cancelled_answer_label.text = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
        
        if ([addUpdateObj.payType_string length])
            cell.payType_answer_label.text=addUpdateObj.payType_string;
        else
            cell.payType_answer_label.text = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
        
        if ([addUpdateObj.timely_string length]){
            cell.timely_answer_label.text=addUpdateObj.timely_string;
        }else{
            addUpdateObj.timely_string = @"UnTimely";
            addUpdateObj.timely_ID_string = @"U";
            cell.timely_answer_label.text=addUpdateObj.timely_string;
        }
        
        if (![appDelegate.statusString isEqualToString:@"Approved"]) {
            cell.serviceProviderIdButton.userInteractionEnabled=NO;
            cell.serviceProviderIdtextField.userInteractionEnabled=NO;
            [cell.serviceProviderIdtextField setBackgroundColor:[UIColor lightGrayColor]];
        }else{
            
            cell.serviceProviderIdButton.userInteractionEnabled=YES;
            cell.serviceProviderIdtextField.userInteractionEnabled=YES;
            [cell.serviceProviderIdtextField setBackgroundColor:[UIColor clearColor]];
        }
        

        if ([addUpdateObj.outOfAgency_string length])
        {
            if ([addUpdateObj.outOfAgency_string isEqualToString:@"1"]) {
                cell.yes_outAgency_ImageView.image=[UIImage imageNamed:@"radio_button_filled"];
                cell.no_outAgency_ImageView.image=[UIImage imageNamed:@"radio_button_empty"];
            }
            else
            {
                cell.yes_outAgency_ImageView.image=[UIImage imageNamed:@"radio_button_empty"];
                cell.no_outAgency_ImageView.image=[UIImage imageNamed:@"radio_button_filled"];
            }
            
        }
        if ([addUpdateObj.timelyandHalf_string length])
        {
            if ([addUpdateObj.timelyandHalf_string isEqualToString:@"1"]) {
                cell.yes_timelyAndHalf_ImageView.image=[UIImage imageNamed:@"radio_button_filled"];
                cell.no_timelyAndHalf_ImageView.image=[UIImage imageNamed:@"radio_button_empty"];
            }
            else
            {
                cell.yes_timelyAndHalf_ImageView.image=[UIImage imageNamed:@"radio_button_empty"];
                cell.no_timelyAndHalf_ImageView.image=[UIImage imageNamed:@"radio_button_filled"];
            }
        }
        return cell;
    }
    if (indexPath.section==1)
    {
        GISAddUpdateJobCell *cell=(GISAddUpdateJobCell *)[tableView dequeueReusableCellWithIdentifier:@"GISAddUpdateJobCell"];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISBillingPaymentInfo" owner:self options:nil] objectAtIndex:0];
        }
    
        if ([addUpdateObj.parking_string length])
            cell.parking_textField.text=addUpdateObj.parking_string;
        if ([addUpdateObj.mileage_string length])
            cell.mileage_textField.text=addUpdateObj.mileage_string;
        if ([addUpdateObj.amtPaid_string length])
            cell.amtPaid_textField.text=addUpdateObj.amtPaid_string;
        if ([addUpdateObj.agencyFee_string length])
            cell.agencyFee_textField.text=addUpdateObj.agencyFee_string;
        if ([addUpdateObj.billAmount_string length])
            cell.billAmt_textField.text=addUpdateObj.billAmount_string;
        if ([addUpdateObj.invoice_string length])
            cell.invoice_textField.text=addUpdateObj.invoice_string;
        
        if ([addUpdateObj.billdate_string length])
            cell.billDate_answer_label.text=addUpdateObj.billdate_string;
        else
            cell.billDate_answer_label.text = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
        
        
        if ([addUpdateObj.payStatus_string length])
            cell.payStatus_answer_label.text=addUpdateObj.payStatus_string;
        else
            cell.payStatus_answer_label.text = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
        
        if ([addUpdateObj.expStatus_string length])
            cell.expStatus_answer_label.text=addUpdateObj.expStatus_string;
        else
            cell.expStatus_answer_label.text = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
        
        if ([addUpdateObj.timelyandHalf_BillPayment_string length])
        {
            if ([addUpdateObj.timelyandHalf_BillPayment_string isEqualToString:@"1"]) {
                cell.yes_timelyAndHalf_BillingPayment_ImageView.image=[UIImage imageNamed:@"radio_button_filled"];
                cell.no_timelyAndHalf_BillingPayment_ImageView.image=[UIImage imageNamed:@"radio_button_empty"];
            }
            else
            {
                cell.yes_timelyAndHalf_BillingPayment_ImageView.image=[UIImage imageNamed:@"radio_button_empty"];
                cell.no_timelyAndHalf_BillingPayment_ImageView.image=[UIImage imageNamed:@"radio_button_filled"];
            }
            
        }
        return cell;
    }
    if (indexPath.section==2)
    {
        GISAddUpdateJobCell *cell=(GISAddUpdateJobCell *)[tableView dequeueReusableCellWithIdentifier:@"GISAddUpdateJobCell"];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISNotesHistoryCell" owner:self options:nil] objectAtIndex:0];
        }
        
        cell.history_textView.delegate = self;
        [cell.addHistoryButton addTarget:self action:@selector(addHistory_Clicked) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    
//    GISAddUpdateJobCell *cell=(GISAddUpdateJobCell *)[tableView dequeueReusableCellWithIdentifier:@"GISAddUpdateJobCell"];
//    if (cell==nil) {
//        cell=[[[NSBundle mainBundle]loadNibNamed:@"GISRequestServiceProvidersCell" owner:self options:nil] objectAtIndex:0];
//    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GISAddUpdateJobCell *cell=(GISAddUpdateJobCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.section==0) {
        return cell.frame.size.height;
    }
    else if (indexPath.section==1)
        return 360;
    else if (indexPath.section==2){
        
        if(history_Clicked){
            return 296;
        }
        else{
            return 100;
        }
    }

    return 150;
}

-(IBAction)closeButtonPressed:(id)sender
{
    history_Clicked = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)saveButtonPressed:(id)sender
{
    history_Clicked = NO;
    [currentTextField resignFirstResponder];
   if ([addUpdateObj.jobDate_string isKindOfClass:[NSNull class]] || addUpdateObj.jobDate_string == (NSString*) [NSNull null] || addUpdateObj.jobDate_string == nil) {
        [GISUtility showAlertWithTitle:@"GIS" andMessage:@"Please select Job Date"];
    }
    else if ([addUpdateObj.startTime_string isKindOfClass:[NSNull class]] || addUpdateObj.startTime_string == (NSString*) [NSNull null] || addUpdateObj.startTime_string == nil) {
        [GISUtility showAlertWithTitle:@"GIS" andMessage:@"Please select Start Time"];
    }
    else if ([addUpdateObj.endTime_string isKindOfClass:[NSNull class]] || addUpdateObj.endTime_string == (NSString*) [NSNull null] || addUpdateObj.endTime_string == nil){
        [GISUtility showAlertWithTitle:@"GIS" andMessage:@"Please select End Time"];
    }
    else if ([addUpdateObj.typeOfServiceProvider_string isKindOfClass:[NSNull class]] || addUpdateObj.typeOfServiceProvider_string == (NSString*) [NSNull null] || addUpdateObj.typeOfServiceProvider_string == nil){
        [GISUtility showAlertWithTitle:@"GIS" andMessage:@"Please select Type of Service Provider"];
    }
    else if ([addUpdateObj.payLevel_string isKindOfClass:[NSNull class]] || addUpdateObj.payLevel_string == (NSString*) [NSNull null] || addUpdateObj.payLevel_string == nil){
        [GISUtility showAlertWithTitle:@"GIS" andMessage:@"Please select Pay Level"];
    }
    else if ([addUpdateObj.billLevel_string isKindOfClass:[NSNull class]] || addUpdateObj.billLevel_string == (NSString*) [NSNull null] || addUpdateObj.billLevel_string == nil){
        [GISUtility showAlertWithTitle:@"GIS" andMessage:@"Please select Bill Level"];
    }
    else
    {
        NSMutableDictionary *addJobDict;
        addJobDict=[[NSMutableDictionary alloc]init];
        
        [addJobDict setObject:[GISUtility returningstring:appDelegate.chooseRequest_ID_String] forKey:kRequestID];
        [addJobDict setObject:[GISUtility returningstring:login_Obj.requestorID_string] forKey:kLoginRequestorID];
        [addJobDict setObject:@"" forKey:kSubmitForRequest_JobId];
        [addJobDict setObject:[GISUtility returningstring:addUpdateObj.jobDate_string] forKey:kEditSchedule_JobDate];
        [addJobDict setObject:[GISUtility returningstring:addUpdateObj.startTime_string] forKey:kSearchReq_Result_StartTime];
        [addJobDict setObject:[GISUtility returningstring:addUpdateObj.endTime_string] forKey:kSearchRequest_EndTime];
        [addJobDict setObject:[GISUtility returningstring:addUpdateObj.typeOfServiceProvider_ID_string] forKey:kViewSchedule_SubroleID];
        [addJobDict setObject:[GISUtility returningstring:addUpdateObj.serviceProvider_ID_string] forKey:kViewSchedule_ServiceProviderID];
        [addJobDict setObject:[GISUtility returningstring:addUpdateObj.cancelled_ID_string] forKey:kCancel];
        [addJobDict setObject:[GISUtility returningstring:addUpdateObj.payType_ID_string] forKey:kViewSchedule_PayTypeID];
        [addJobDict setObject:[GISUtility returningstring:addUpdateObj.outOfAgency_string] forKey:kOutToAgency];
        [addJobDict setObject:[GISUtility returningstring:addUpdateObj.timely_ID_string] forKey:kJobDetais_Timely];
        [addJobDict setObject:[GISUtility returningstring:addUpdateObj.parking_string] forKey:kChooseReqDetails_parking];
        [addJobDict setObject:[GISUtility returningstring:addUpdateObj.mileage_string] forKey:kMyJobs_Mileage];
        [addJobDict setObject:[GISUtility returningstring:addUpdateObj.billAmount_string] forKey:kJobDetais_BillAmount];
        [addJobDict setObject:[GISUtility returningstring:addUpdateObj.amtPaid_string] forKey:kAmtPaid];
        [addJobDict setObject:[GISUtility returningstring:addUpdateObj.agencyFee_string ]forKey:kAgencyFee];
        
        [addJobDict setObject:[GISUtility returningstring:addUpdateObj.timelyandHalf_BillPayment_string ] forKey:kOverrideBill];
        
        [addJobDict setObject:[GISUtility returningstring:addUpdateObj.payStatus_ID_string] forKey:kPayStatus];
        [addJobDict setObject:[GISUtility returningstring:addUpdateObj.expStatus_ID_string] forKey:kExpenseStatus];
        [addJobDict setObject:@"" forKey:kViewSchedule_JobNotes];
        [addJobDict setObject:@"" forKey:kBillingLevelID];
        
        [addJobDict setObject:[GISUtility returningstring:addUpdateObj.callInTime_string] forKey:kMyJobs_CallInTime];
        [addJobDict setObject:[GISUtility returningstring:addUpdateObj.payLevel_ID_string] forKey:kPayLevelID];
        
        appDelegate.addNewJob_dictionary=addJobDict;
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"changeJobHistory" object:nil];
        [self performSelector:@selector(closeButtonPressed:) withObject:nil];
    }
}


-(IBAction)pickerButtonPressed:(id)sender
{
    [currentTextField resignFirstResponder];
    UIButton *button=(UIButton *)sender;
    GISAddUpdateJobCell *table=(GISAddUpdateJobCell *)[GISUtility findParentTableViewCell:button];//button.superview.superview.superview;
    
    GISPopOverTableViewController *tableViewController1 = [[GISPopOverTableViewController alloc] initWithNibName:@"GISPopOverTableViewController" bundle:nil];
    tableViewController1.popOverDelegate=self;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    
    if([sender tag]==1)
    {
        btnTag=1;
        
        tableViewController1.view_String=@"datestimes";
        tableViewController1.dateTimeMoveUp_string = startDate_temp_String;
        if (![startDate_temp_String length]) {
            tableViewController1.dateTimeMoveUp_string=[formatter stringFromDate:[NSDate date]];
        }
        
    }
    else if([sender tag]==2)
    {
        btnTag=2;
        tableViewController1.view_String=@"timesdates";
        tableViewController1.dateTimeMoveUp_string=startTime_temp_string;
        [formatter setDateFormat:@"hh:mm a"];
        if (![startTime_temp_string length]) {
            tableViewController1.dateTimeMoveUp_string=[formatter stringFromDate:[NSDate date]];
        }

    }
    else if([sender tag]==3)
    {
        btnTag=3;
        tableViewController1.view_String=@"timesdates";
        tableViewController1.dateTimeMoveUp_string=endTime_temp_string;
        [formatter setDateFormat:@"hh:mm a"];
        if (![endTime_temp_string length]) {
            tableViewController1.dateTimeMoveUp_string=[formatter stringFromDate:[NSDate date]];
        }

    }
    else if([sender tag]==4)
    {
        btnTag=4;
        tableViewController1.view_String=@"timesdates";
        tableViewController1.dateTimeMoveUp_string=callIntime_temp_string;
        [formatter setDateFormat:@"hh:mm a"];
        if (![callIntime_temp_string length]) {
            tableViewController1.dateTimeMoveUp_string=[formatter stringFromDate:[NSDate date]];
        }

    }
    else if ([sender tag]==5)
    {
        btnTag=5;
        tableViewController1.popOverArray=payLevel_Array;
    }
    else if ([sender tag]==55)
    {
        btnTag=55;
        tableViewController1.popOverArray=billLevel_Array;
    }
    else if ([sender tag]==6)
    {
        btnTag=6;
        tableViewController1.popOverArray=typeOfserviceProvider_Array;
        
    }
    else if ([sender tag]==7)
    {
        btnTag=7;
        tableViewController1.popOverArray=serviceProvider_ID_Array;
        
    }
    else if([sender tag]==8)
    {
        btnTag=8;
        tableViewController1.popOverArray=cancelled_Array;
    }
    else if([sender tag]==9)
    {
        btnTag=9;
        tableViewController1.popOverArray=payType_Array;
    }
    else if([sender tag]==10)
    {
        btnTag=10;
    }
    else if ([sender tag]==11)
    {
        btnTag=11;
    }
    else if ([sender tag]==12)
    {
        btnTag=12;
    }
    else if ([sender tag]==13)
    {
        btnTag=13;
        
    }
    else if([sender tag]==14)
    {
        btnTag=14;
    }
    else if([sender tag]==15)
    {
        btnTag=15;
        tableViewController1.view_String=@"datestimes";
    }
    else if([sender tag]==16)
    {
        btnTag=16;
    }
    else if ([sender tag]==17)
    {
        btnTag=17;
        tableViewController1.popOverArray=payStatus_Array;
    }
    else if ([sender tag]==18)
    {
        btnTag=18;
        tableViewController1.popOverArray=expStatus_Array;
    }
    else if([sender tag]==118)
    {
        btnTag=118;
        tableViewController1.popOverArray=cancelled_Array;
    }
    
    popover =[[UIPopoverController alloc] initWithContentViewController:tableViewController1];
    
    popover.delegate = self;
    popover.popoverContentSize = CGSizeMake(340, 210);
    [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+128, button.frame.origin.y+22, 1, 1) inView:table.contentView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)sendTheSelectedPopOverData:(NSString *)id_str value:(NSString *)value_str
{
    
    [self performSelector:@selector(dismissPopOverNow) withObject:nil afterDelay:1.0];
    
    if(btnTag==1)
    {
        addUpdateObj.jobDate_string=value_str;
        startDate_temp_String = value_str;
    }
    else if(btnTag==2)
    {
        startTime_temp_string = value_str;
        
        if ([startTime_temp_string length] && [endTime_temp_string length]){
            if ([GISUtility timeComparision :startTime_temp_string :endTime_temp_string])
            {}
            else
            {
                [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"start Time alert", TABLE, nil)];
                startTime_temp_string=@"";
            }
        }
        
        addUpdateObj.startTime_string = startTime_temp_string;

    }
    else if(btnTag==3)
    {
        endTime_temp_string = value_str;
       
        if ([startTime_temp_string length] && [endTime_temp_string length]){
            if ([GISUtility timeComparision :startTime_temp_string :endTime_temp_string])
            {}
            else
            {
                [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"end Time alert", TABLE, nil)];
                endTime_temp_string=@"";
            }
        }
        
        addUpdateObj.endTime_string = endTime_temp_string;



    }
    else if(btnTag==4)
    {
        callIntime_temp_string = value_str;
        
        if ([endTime_temp_string length] && [callIntime_temp_string length]){
            if ([GISUtility timeComparision :endTime_temp_string :callIntime_temp_string])
            {}
            else
            {
                [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"call_in_time_alert", TABLE, nil)];
                callIntime_temp_string=@"";
            }
        }

        addUpdateObj.callInTime_string = callIntime_temp_string;
        if ([addUpdateObj.callInTime_string isEqualToString:@"Timely"])
            addUpdateObj.callInTime_ID_string=@"1";
        else
            addUpdateObj.callInTime_ID_string=@"0";
    }
    else if (btnTag==5)
    {
        addUpdateObj.payLevel_string=value_str;
        addUpdateObj.payLevel_ID_string=id_str;
    }
    else if (btnTag==55)
    {
        addUpdateObj.billLevel_string=value_str;
        addUpdateObj.billLevel_ID_string=id_str;
    }
    else if (btnTag==6)
    {
        addUpdateObj.typeOfServiceProvider_string=value_str;
        addUpdateObj.typeOfServiceProvider_ID_string=id_str;
        [serviceProvider_ID_Array removeAllObjects];
        NSString *spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO WHERE TYPE = '%@' OR ID = '%@'",addUpdateObj.typeOfServiceProvider_string,[NSString stringWithFormat:@"%d",0]];
        if ([addUpdateObj.typeOfServiceProvider_string isEqualToString:@"Any"]) {
            spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO WHERE TYPE = '%@' OR TYPE = '%@' OR ID = '%@'",@"Interpreter",@"Captioner",[NSString stringWithFormat:@"%d",0]];
        }
        serviceProvider_ID_Array = [[[GISDatabaseManager sharedDataManager] getServiceProviderArray:spCode_statement] mutableCopy];
    }
    else if (btnTag==7)
    {
        addUpdateObj.serviceProvider_string=value_str;
        addUpdateObj.serviceProvider_ID_string=id_str;
        
        if([id_str isEqualToString:@"0"])
            addUpdateObj.serviceProvider_string = @"";
    }
    else if(btnTag==8)
    {
        addUpdateObj.cancelled_string=value_str;
        addUpdateObj.cancelled_ID_string=id_str;
    }
    else if(btnTag==9)
    {
        addUpdateObj.payType_string=value_str;
        addUpdateObj.payType_ID_string=id_str;
    }
    else if(btnTag==10)
    {
    }
    else if (btnTag==11)
    {
    }
    else if (btnTag==12)
    {
    }
    else if (btnTag==13)
    {
    }
    else if(btnTag==14)
    {
    }
    else if(btnTag==15)
    {
        addUpdateObj.billdate_string=value_str;
    }
    else if(btnTag==16)
    {
    }
    else if (btnTag==17)
    {
        addUpdateObj.payStatus_string=value_str;
        addUpdateObj.payStatus_ID_string=id_str;
    }
    else if (btnTag==18)
    {
        addUpdateObj.expStatus_string=value_str;
        addUpdateObj.expStatus_ID_string=id_str;
    }
    else if(btnTag == 118)
    {
        addUpdateObj.timely_string=value_str;
        if([value_str isEqualToString:@"Timely"])
            addUpdateObj.timely_ID_string=@"T";
        else
            addUpdateObj.timely_ID_string=@"U";
    }
    [addUpdateJobs_tableView reloadData];
}

-(void)dismissPopOverNow
{
    [popover dismissPopoverAnimated:YES];
}

-(IBAction)radioButton_Pressed:(id)sender
{
    [currentTextField resignFirstResponder];
    UIButton *button=(UIButton *)sender;
    if (button.tag==1 || button.tag==2) {
        if (button.tag==1)
            addUpdateObj.outOfAgency_string=@"1";
        else
            addUpdateObj.outOfAgency_string=@"0";
    }
    else if (button.tag==3 || button.tag==4) {
        if (button.tag==3)
            addUpdateObj.timelyandHalf_string=@"1";
        else
            addUpdateObj.timelyandHalf_string=@"0";
    }
    else if (button.tag==5 || button.tag==6) {
        if (button.tag==5)
            addUpdateObj.timelyandHalf_BillPayment_string=@"1";
        else
            addUpdateObj.timelyandHalf_BillPayment_string=@"0";
    }
    [addUpdateJobs_tableView reloadData];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag==1)
        addUpdateObj.parking_string=textField.text;
    else if (textField.tag==2)
        addUpdateObj.mileage_string=textField.text;
    else if (textField.tag==3)
        addUpdateObj.amtPaid_string=textField.text;
    else if (textField.tag==4)
        addUpdateObj.agencyFee_string=textField.text;
    
}

-(void)addLoadViewWithLoadingText:(NSString*)title
{
    [[GISLoadingView sharedDataManager] addLoadingAlertView:title];
    
}

-(void)removeLoadingView
{
    [[GISLoadingView sharedDataManager] removeLoadingAlertview];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSLog(@"textViewShouldBeginEditing:");
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    NSLog(@"textViewDidBeginEditing:");
    
    [self moveAction:YES viewHeight:-300];
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    NSLog(@"textViewShouldEndEditing:");
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"textViewDidEndEditing:");
    
    [self moveAction:YES viewHeight:0];
    
    [textView resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSCharacterSet *doneButtonCharacterSet = [NSCharacterSet newlineCharacterSet];
    NSRange replacementTextRange = [text rangeOfCharacterFromSet:doneButtonCharacterSet];
    NSUInteger location = replacementTextRange.location;
    
    if (textView.text.length + text.length > 540){
        if (location != NSNotFound){
            [textView resignFirstResponder];
        }
        return NO;
    }
    else if (location != NSNotFound){
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)moveAction:(BOOL)isMove viewHeight:(int)viewHeight{
    
    if(isMove)
    {
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration:1.0];
        
        CGRect frame=self.view.frame;
        frame.origin.x=viewHeight;
        self.view.frame=frame;
        [UIView commitAnimations];
    }
    else
    {
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration:0.2];
        CGRect frame=self.view.frame;
        frame.origin.x=0;
        self.view.frame=frame;
        
        [UIView commitAnimations];
    }
    
}

-(void) addHistory_Clicked{
    
    history_Clicked = YES;
    [addUpdateJobs_tableView reloadData];
    
    [addUpdateJobs_tableView setContentOffset:(CGPoint){0, addUpdateJobs_tableView.contentSize.height - addUpdateJobs_tableView.bounds.size.height} animated:YES];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
