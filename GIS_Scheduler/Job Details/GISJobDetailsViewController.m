//
//  GISJobDetailsViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 18/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//


#import "GISJobDetailsViewController.h"
#import "GISJobDetailsCell.h"
#import "GISJSONProperties.h"
#import "GISDatabaseManager.h"
#import "GISJsonRequest.h"
#import "GISServerManager.h"
#import "GISJobDetailsStore.h"
#import "GISStoreManager.h"
#import "GISConstants.h"
#import "GISAddUpdateJobsViewController.h"
#import "GISLoadingView.h"
#import "GISCreateJobs_Cell.h"
#import "GISUtility.h"
#import "GISDatesTimesDetailStore.h"
#import "PCLogger.h"
#import "GISServerManager.h"
#import "GISFonts.h"

@interface GISJobDetailsViewController ()
//-(void)getJobDetails_Data;
-(void)getJobDetails_Data:(NSString *)chooseRequest_idStr :(NSString*)token :(NSString *)serviceProviderID :(NSString *)jobDate :(NSString *)filledUnfilled_str;
@end

@implementation GISJobDetailsViewController

@synthesize detail_mut_array;

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
    //Do any additional setup after loading the view from its nib.
    appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication] delegate];
    detail_mut_array=[[NSMutableArray alloc]init];
    NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
    NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
    login_Obj=[requetId_array lastObject];
    
    serviceProvider_Array=[[NSMutableArray alloc]init];
    jobDetails_Array=[[NSMutableArray alloc]init];
    payLevel_Array=[[NSMutableArray alloc]init];
    billLevel_Array=[[NSMutableArray alloc]init];
    typeOfService_array=[[NSMutableArray alloc]init];
    serviceProvider_array_tableView=[[NSMutableArray alloc]init];
    payType_array=[[NSMutableArray alloc]init];

    filled_Unfilled_Array=[[NSMutableArray alloc]initWithObjects:@"Filled",@"UnFilled", nil];// Keys-- Filled=1, Unfilled =2   If  not anything then 0
    
    selected_row=999999;

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showChangeJobHistoryView) name:@"changeJobHistory" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(craeteJobPressed:) name:@"createNewJob" object:nil];
    
    createJobs_UIVIew.hidden=YES;
    
    jobChangeHistory_background_UIView.hidden=YES;
    jobChangeHistory_foreground_UIView.hidden=YES;
    
    [jobHistory_textView.layer setBorderWidth:0.6];
    [jobHistory_textView.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [jobHistory_textView.layer setCornerRadius:10.0f];
    

    if([appDelegate.chooseRequest_ID_String length] > 0 && ![appDelegate.chooseRequest_ID_String isEqualToString:@"0"]){
        
        chooseRequestID_string=appDelegate.chooseRequest_ID_String;
        
        [self getJobDetails_Data :[GISUtility returningstring:chooseRequestID_string] :login_Obj.token_string:@"":@"":@""];
    }
    
    createJobdate_Array = [[NSMutableArray alloc] init];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectedChooseRequestNumber:) name:kselectedChooseReqNumber object:nil];
    
    NSString *spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO"];
    serviceProvider_Array = [[[GISDatabaseManager sharedDataManager] getServiceProviderArray:spCode_statement] mutableCopy];
    NSString *typeOfService_statement = [[NSString alloc]initWithFormat:@"select * from TBL_TYPE_OF_SERVICE  ORDER BY ID DESC;"];
    typeOfService_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:typeOfService_statement] mutableCopy];
    
    NSString *payType_statement = [[NSString alloc]initWithFormat:@"select * from TBL_PAY_TYPE"];
    payType_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:payType_statement] mutableCopy];
    
    payLevel_Array=[[GISStoreManager sharedManager]getPayLevelObjects];
    
    billLevel_Array=[[GISStoreManager sharedManager]getBillLevelObjects];
    
    //filledUnfilled_ID_string=@"0";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    startDate_jobHistory_Answer_Label.text= [formatter stringFromDate:[NSDate date]];
    
    [formatter setDateFormat:@"hh:mm a"];
    endDate_jobHistory_Answer_Label.text= [formatter stringFromDate:[NSDate date]];
    
    user_textField.text=login_Obj.email_string;
    
    if(!appDelegate.isNewRequest && ([appDelegate.chooseRequest_ID_String length] > 0 && ![appDelegate.chooseRequest_ID_String isEqualToString:@"0"])){
        chooseRequestID_string=appDelegate.chooseRequest_ID_String;
        
        [self getJobDetails_Data :[GISUtility returningstring:chooseRequestID_string] :login_Obj.token_string:@"":@"":@""];

    }
    
    if([createJobdate_Array count]>0)
       [createJobdate_Array removeAllObjects];
    
    billLevel_Answer_Label.text =  NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    typeOfServiceProviders_Answer_Label.text =  NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    payLevel_Answer_Label.text = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    
    serviceProvider_Answer_Label.text =  NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    filledUnfilled_Answer_Label.text =  NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    
    [next_button.layer setCornerRadius:3.0f];
    [[next_button layer] setMasksToBounds:YES];
    [next_button setTitleColor:UIColorFromRGB(0xe8d4a2) forState:UIControlStateNormal];
    
    [create_job_button.layer setCornerRadius:3.0f];
    [[create_job_button layer] setMasksToBounds:YES];
    [create_job_button setTitleColor:UIColorFromRGB(0xe8d4a2) forState:UIControlStateNormal];

}


-(void)getJobDetails_Data:(NSString *)chooseRequest_idStr :(NSString*)token :(NSString *)serviceProviderID :(NSString *)jobDate :(NSString *)filledUnfilled_str
{
    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
    [paramsDict setObject:chooseRequest_idStr forKey:KRequestId];
    [paramsDict setObject:token forKey:kToken];
    [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
    [[GISServerManager sharedManager] getJobDetails_data:self withParams:paramsDict finishAction:@selector(successmethod_getJobDetails_data:) failAction:@selector(failuremethod_getJobDetails_data:)];
}

-(void)selectedChooseRequestNumber:(NSNotification*)notification
{
    NSDictionary *dict=[notification userInfo];
    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
    [paramsDict setObject:[dict valueForKey:@"id"] forKey:kID];

    
    //[paramsDict setObject:@"2701" forKey:KRequestId];
    [paramsDict setObject:login_Obj.token_string forKey:kToken];
    appDelegate.chooseRequest_ID_String=[dict valueForKey:@"id"];
    chooseRequestID_string=appDelegate.chooseRequest_ID_String;
    [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
    
    [self getJobDetails_Data :[GISUtility returningstring:chooseRequestID_string] :login_Obj.token_string:@"":@"":@""];
    
    //[[GISServerManager sharedManager] getJobDetails_data:self withParams:paramsDict finishAction:@selector(successmethod_getJobDetails_data:) failAction:@selector(failuremethod_getJobDetails_data:)];
   
    [[GISServerManager sharedManager] getChooseRequestDetailsData:self withParams:paramsDict finishAction:@selector(successmethod_getChooseRequestDetails:) failAction:@selector(failuremethod_getChooseRequestDetails:)];
    
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults synchronize];
    [userDefaults setValue:[dict valueForKey:@"value"] forKey:kDropDownValue];
    [userDefaults setValue:[dict valueForKey:@"id"] forKey:kDropDownID];
    
}

-(void)successmethod_getChooseRequestDetails:(GISJsonRequest *)response
{
    //[self removeLoadingView];
    NSLog(@"successmethod_getRequestDetails Success---%@",response.responseJson);
    [[GISStoreManager sharedManager]removeChooseRequestDetailsObjects];
    chooseRequestDetailsObj=[[GISChooseRequestDetailsObject alloc]initWithStoreChooseRequestDetailsDictionary:response.responseJson];
    [[GISStoreManager sharedManager]addChooseRequestDetailsObject:chooseRequestDetailsObj];
    
    appDelegate.createdDateString = chooseRequestDetailsObj.createdDate_String_chooseReqParsedDetails;
    appDelegate.createdByString = [NSString stringWithFormat:@"%@ %@", chooseRequestDetailsObj.reqFirstName_String_chooseReqParsedDetails,chooseRequestDetailsObj.reqLastName_String_chooseReqParsedDetails];
    appDelegate.statusString = chooseRequestDetailsObj.requestStatus_String_chooseReqParsedDetails;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:kRequestInfo object:nil];
    
}

-(void)failuremethod_getChooseRequestDetails:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"Failure");
    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
}

-(void)successmethod_getJobDetails_data:(GISJsonRequest *)response
{
    NSLog(@"successmethod_getJobDetails_data Success---%@",response.responseJson);
    
    NSDictionary *saveUpdateDict;
    NSArray *responseArray= response.responseJson;
    
    if([responseArray count]>0){
        saveUpdateDict = [responseArray lastObject];
        
        if ([[saveUpdateDict objectForKey:kStatusCode] isEqualToString:@"200"]) {
            
            if([appDelegate.jobDetailsArray count]>0)
                [appDelegate.jobDetailsArray removeAllObjects];
            
            if([jobDetails_Array count]>0)
                [jobDetails_Array removeAllObjects];
            
            [[GISStoreManager sharedManager]removeJobDetailsObjects];
            GISJobDetailsStore *jobDetailsStore;
            jobDetailsStore=[[GISJobDetailsStore alloc]initWithJsonDictionary:response.responseJson];
            
            [jobDetails_Array addObjectsFromArray:[[GISStoreManager sharedManager]getJobDetailsObjects]];
            
            [appDelegate.jobDetailsArray addObjectsFromArray:jobDetails_Array];
            
            [jobDetails_tableView reloadData];
            
            NSMutableDictionary *paramsDict1=[[NSMutableDictionary alloc]init];
            [paramsDict1 setObject:[GISUtility returningstring:chooseRequestID_string] forKey:kID];
            [paramsDict1 setObject:login_Obj.token_string forKey:kToken];
            
            //[[GISServerManager sharedManager] getDateTimeDetails:self withParams:paramsDict1 finishAction:@selector(successmethod_get_Date_Time:) failAction:@selector(failuremethod_get_Date_Time:)];
            
            //GISJobDetailsObject *dobj=[[GISJobDetailsObject alloc]init];
            //[appDelegate.jobDetailsArray insertObject:dobj atIndex:0];
            
            [self removeLoadingView];
        }else{
            [self removeLoadingView];
            [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
        }
    }else{
        
        if([appDelegate.jobDetailsArray count]>0)
            [appDelegate.jobDetailsArray removeAllObjects];
        
        if([jobDetails_Array count]>0)
            [jobDetails_Array removeAllObjects];
        
        [[GISStoreManager sharedManager]removeJobDetailsObjects];
        GISJobDetailsStore *jobDetailsStore;
        jobDetailsStore=[[GISJobDetailsStore alloc]initWithJsonDictionary:response.responseJson];
        
        [jobDetails_Array addObjectsFromArray:[[GISStoreManager sharedManager]getJobDetailsObjects]];
        
        [appDelegate.jobDetailsArray addObjectsFromArray:jobDetails_Array];
        
        [jobDetails_tableView reloadData];

        [self removeLoadingView];
    }
}

-(void)failuremethod_getJobDetails_data:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"Failure");
    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
}


-(void)successmethod_get_Date_Time:(GISJsonRequest *)response
{
    GISDatesTimesDetailStore *store;
    NSLog(@"successmethod_get_Date_Time Success---%@",response.responseJson);
    
    NSDictionary *saveUpdateDict;
    NSArray *responseArray= response.responseJson;
    saveUpdateDict = [responseArray lastObject];
    NSString *str=[NSString stringWithFormat:@"%@",[saveUpdateDict objectForKey:kStatusCode]];
    if ([str isEqualToString:@"200"]) {
        
        
        [[GISStoreManager sharedManager]removeDateTimes_detail_Objects];
        
        store=[[GISDatesTimesDetailStore alloc]initWithStoreDictionary:response.responseJson];
        [detail_mut_array removeAllObjects];
        detail_mut_array= [[GISStoreManager sharedManager]getDateTimes_detail_Objects];
        [self sortTheDatesAndTimes];
        if (detail_mut_array.count>0) {
            [createJObs_tableView reloadData];
        }
        
        
    }
    else if(responseArray.count<1)
    {
        [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"no_data",TABLE, nil)];
    }else{
        
        [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
    }
    [self removeLoadingView];
}


-(void)failuremethod_get_Date_Time:(GISJsonRequest *)response
{
    NSLog(@"Failure");
    [self removeLoadingView];
    [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
}

-(void)sortTheDatesAndTimes
{
    [self deleteDuplicates];
    NSDateFormatter *date_formatter=[[NSDateFormatter alloc]init];
    [date_formatter setDateFormat:@"MM/dd/yyyy"];
    NSArray *sortedArray;
    sortedArray = [detail_mut_array sortedArrayUsingComparator:^NSComparisonResult(GISDatesAndTimesObject *a,GISDatesAndTimesObject *b) {
        
        NSDate *first = [date_formatter dateFromString:a.date_String];
        NSDate *second = [date_formatter dateFromString:b.date_String];
        return [first compare:second];
    }];
    [detail_mut_array removeAllObjects];
    detail_mut_array = [sortedArray mutableCopy];
}

-(void)deleteDuplicates
{
    int count=[detail_mut_array count];
    NSMutableArray *duplicates=[[NSMutableArray alloc]init];
    for(int i=0 ;i<count;i++)
    {
        for (int j=i+1; j<count; j++)
        {
            GISDatesAndTimesObject *obj1=[detail_mut_array objectAtIndex:i];
            GISDatesAndTimesObject *obj2=[detail_mut_array objectAtIndex:j];
            if ([obj1.date_String isEqualToString:obj2.date_String])
            {
                if ([obj1.startTime_String isEqualToString:obj2.startTime_String])
                {
                    if ([obj1.endTime_String isEqualToString:obj2.endTime_String])
                    {
                        [duplicates addObject:obj1];
                    }
                }
            }
        }
    }
    [detail_mut_array removeObjectsInArray:duplicates];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==createJObs_tableView) {
        return detail_mut_array.count;
    }
    return jobDetails_Array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==createJObs_tableView) {
        GISCreateJobs_Cell *cell=(GISCreateJobs_Cell *)[tableView dequeueReusableCellWithIdentifier:@"GISCreateJobsCell"];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISCreateJobs_Cell" owner:self options:nil] objectAtIndex:0];
        }
        
        GISDatesAndTimesObject *detailObj;
        @try {
            if([detail_mut_array count] >0)
                detailObj=[detail_mut_array objectAtIndex:indexPath.row];
        }
        @catch (NSException *exception) {
            [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in DatesAndTimesDetailView CellForRowAtIndexPath %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
        }
        cell.check_uncheck_button.tag=indexPath.row;
        
        if ([createJobsCheckDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]])
            [cell.check_uncheck_button setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        else
            [cell.check_uncheck_button setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        
        [cell.check_uncheck_button addTarget:self action:@selector(check_uncheck_createjobsButtonPresses:) forControlEvents:UIControlEventTouchUpInside];
        cell.dateLabel.text=detailObj.date_String;
        cell.dayLabel.text=detailObj.day_String;
        cell.startTime_Label.text=detailObj.startTime_String;
        cell.endTimeLabel.text=detailObj.endTime_String;
        
        return cell;
    }
    
    GISJobDetailsCell *cell=(GISJobDetailsCell *)[tableView dequeueReusableCellWithIdentifier:@"GISJobDetailsCell"];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"GISJobDetailsCell" owner:self options:nil] objectAtIndex:0];
    }
    if (jobDetails_Array.count>0) {
        GISJobDetailsObject *temp_obj_jobDetails=[jobDetails_Array objectAtIndex:indexPath.row];
        cell.job_ID_Label.text=temp_obj_jobDetails.jobNumber_string;
        cell.job_date_Label.text=temp_obj_jobDetails.jobDate_string;
        cell.start_time_Label.text=temp_obj_jobDetails.startTime_string;
        cell.end_time_Label.text=temp_obj_jobDetails.endTime_string;
        cell.typeOf_service_Label.text=temp_obj_jobDetails.typeOfService_string;
        cell.service_provider_Label.text=temp_obj_jobDetails.serviceProvider_string;
        cell.payType_Label.text=temp_obj_jobDetails.payType_string;
        cell.timely_Label.text=temp_obj_jobDetails.timely_string;
        cell.billAmt_Label.text=temp_obj_jobDetails.billAmount_string;
        cell.slots_Label.text=temp_obj_jobDetails.slots_string;
    }

    if (selected_row==indexPath.row && isEdit_Button_Clicked) {
        cell.jobDate_UIView.hidden=NO;
        cell.startTime_UIView.hidden=NO;
        cell.endTime_UIView.hidden=NO;
        cell.typeOf_service_UIView.hidden=NO;
        cell.serviceProvider_UIView.hidden=NO;
        cell.payType_UIView.hidden=NO;
        
        cell.jobDate_EDIT_Label.text=jobDate_temp_string;
        cell.startTime_EDIT_Label.text=startTime_temp_string;
        cell.endTime_EDIT_Label.text=endTime_temp_string;
        cell.typeOf_service_EDIT_Label.text=typeOfservice_temp_string;
        cell.service_provider_EDIT_Label.text=serviceProvider_temp_string;
        cell.payType_EDIT_Label.text=payType_temp_string;
        cell.edit_imageView.image=[UIImage imageNamed:@"check_pressed"];
    }
    else
    {
        cell.jobDate_UIView.hidden=YES;
        cell.startTime_UIView.hidden=YES;
        cell.endTime_UIView.hidden=YES;
        cell.typeOf_service_UIView.hidden=YES;
        cell.serviceProvider_UIView.hidden=YES;
        cell.payType_UIView.hidden=YES;
    }
    
    cell.editButton.tag=indexPath.row;
    cell.deleteButton.tag=indexPath.row;
    
    [cell.editButton addTarget:self action:@selector(editButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deleteButton addTarget:self action:@selector(deleteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

    
    if (![appDelegate.statusString isEqualToString:@"Approved"]) {
        cell.serviceProvider_UIView.userInteractionEnabled=NO;
        cell.payType_UIView.userInteractionEnabled=NO;
        [cell.serviceProviderTextField setBackgroundColor:[UIColor lightGrayColor]];
        [cell.payTypeTextField setBackgroundColor:[UIColor lightGrayColor]];
    }else{
        
        cell.serviceProvider_UIView.userInteractionEnabled=YES;
        cell.payType_UIView.userInteractionEnabled=YES;
        [cell.serviceProviderTextField setBackgroundColor:[UIColor clearColor]];
        [cell.payTypeTextField setBackgroundColor:[UIColor clearColor]];
    }
    return cell;
}


-(IBAction)pickerButtonPressed:(id)sender
{
    [noOfServiceProviders_TextField resignFirstResponder];
    UIButton *button=(UIButton *)sender;

    GISPopOverTableViewController *tableViewController1 = [[GISPopOverTableViewController alloc] initWithNibName:@"GISPopOverTableViewController" bundle:nil];
    tableViewController1.popOverDelegate=self;
    GISJobDetailsCell *jobDetailsCell=(GISJobDetailsCell *)[GISUtility findParentTableViewCell:button];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    if([sender tag]==111)
    {
        btnTag=111;
        tableViewController1.view_String=@"datestimes";
        tableViewController1.dateTimeMoveUp_string=jobDate_Answer_Label.text;
        if (![jobDate_Answer_Label.text length]) {
            tableViewController1.dateTimeMoveUp_string=[formatter stringFromDate:[NSDate date]];
        }
    }
    else if([sender tag]==222)
    {
        btnTag=222;
        tableViewController1.popOverArray=serviceProvider_Array;
    }
    else if([sender tag]==333)
    {
        btnTag=333;
        tableViewController1.popOverArray=filled_Unfilled_Array;
    }
    else if([sender tag]==444)
    {
        // Search Button Action
        [self getJobDetails_Data:[GISUtility returningstring:chooseRequestID_string]:login_Obj.token_string:serviceProvider_Answer_Label.text:jobDate_Answer_Label.text:filledUnfilled_Answer_Label.text];
    }
    else if([sender tag]==1111)//Edit JobDate
    {
        btnTag=1111;
        tableViewController1.view_String=@"datestimes";
    }
    else if([sender tag]==1212)//Edit start time
    {
        btnTag=1212;
        tableViewController1.view_String=@"timesdates";
        [formatter setDateFormat:@"hh:mm a"];
        tableViewController1.dateTimeMoveUp_string=jobDetailsCell.startTime_EDIT_Label.text;
        if (![jobDetailsCell.startTime_EDIT_Label.text length]) {
            tableViewController1.dateTimeMoveUp_string=[formatter stringFromDate:[NSDate date]];
        }
    }
    else if([sender tag]==1313)//Edit end time
    {
        btnTag=1313;
        tableViewController1.view_String=@"timesdates";
        [formatter setDateFormat:@"hh:mm a"];
        tableViewController1.dateTimeMoveUp_string=jobDetailsCell.endTime_EDIT_Label.text;
        if (![jobDetailsCell.endTime_EDIT_Label.text length]) {
            tableViewController1.dateTimeMoveUp_string=[formatter stringFromDate:[NSDate date]];
        }
    }
    else if ([sender tag]==555)
    {
        btnTag=555;
        tableViewController1.popOverArray=typeOfService_array;
    }
    else if ([sender tag]==666)
    {
        btnTag=666;
        NSString *spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO WHERE TYPE = '%@' OR ID = '%@'",typeOfservice_temp_string,[NSString stringWithFormat:@"%d",0]];
        if ([typeOfservice_temp_string isEqualToString:@"Any"]) {
            spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO WHERE TYPE = '%@' OR TYPE = '%@' OR ID = '%@'",@"Interpreter",@"Captioner",[NSString stringWithFormat:@"%d",0]];
        }
        serviceProvider_array_tableView = [[[GISDatabaseManager sharedDataManager] getServiceProviderArray:spCode_statement] mutableCopy];
        tableViewController1.popOverArray=serviceProvider_array_tableView;
        
    }
    else if ([sender tag]==777)
    {
        btnTag=777;
        tableViewController1.popOverArray=payType_array;
        
    }
    else if ([sender tag]==888)// Create Jobs
    {
        btnTag=888;
        tableViewController1.popOverArray=typeOfService_array;
    }
    else if ([sender tag]==999) // Create Jobs
    {
        btnTag=999;
        tableViewController1.popOverArray=payLevel_Array;
        
    }
    else if ([sender tag]==1010) // Create Jobs
    {
        btnTag=1010;
        tableViewController1.popOverArray=billLevel_Array;
        
    }
    else if([sender tag]==4646)//Job Change History Start Time
    {
        btnTag=4646;
        
        tableViewController1.view_String=@"datestimes";
    }
    else if([sender tag]==5656)//Job Change History End Time
    {
        btnTag=5656;
        
        tableViewController1.view_String=@"timesdates";
    }

    popover =[[UIPopoverController alloc] initWithContentViewController:tableViewController1];
    
    popover.delegate = self;
    popover.popoverContentSize = CGSizeMake(340, 210);
    if(([sender tag]==111)||([sender tag]==222)||([sender tag]==333)||([sender tag]==444))
        [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+105, button.frame.origin.y+24, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    if([sender tag]==888 || [sender tag]==999 || [sender tag]==1010)
        [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+306, button.frame.origin.y+20, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    //if(([sender tag]==1111)||([sender tag]==1212)||([sender tag]==1313)||([sender tag]==555)||([sender tag]==666)||([sender tag]==777))
       // [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+105, button.frame.origin.y+24, 1, 1) inView:jobDetailsCell.contentView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
    if([sender tag]==1111)
        [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+105, button.frame.origin.y+30, 1, 1) inView:jobDetailsCell.contentView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    if([sender tag]==1212)
        [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+166, button.frame.origin.y+30, 1, 1) inView:jobDetailsCell.contentView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    if([sender tag]==1313)
        [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+236, button.frame.origin.y+30, 1, 1) inView:jobDetailsCell.contentView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    if([sender tag]==555)
        [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+345, button.frame.origin.y+30, 1, 1) inView:jobDetailsCell.contentView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    if([sender tag]==666)
        [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+436, button.frame.origin.y+30, 1, 1) inView:jobDetailsCell.contentView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    if([sender tag]==777)
        [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+536, button.frame.origin.y+30, 1, 1) inView:jobDetailsCell.contentView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    if(([sender tag]==4646)||([sender tag]==5656))
        [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+175, button.frame.origin.y+30, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)sendTheSelectedPopOverData:(NSString *)id_str value:(NSString *)value_str
{
    
    [self performSelector:@selector(dismissPopOverNow) withObject:nil afterDelay:0.0];

    if(btnTag==111)
    {
        jobDate_Answer_Label.text=value_str;
    }
    else if(btnTag==222)
    {
        serviceProvider_Answer_Label.text=value_str;
        serviceProvider_ID_string=id_str;
        if([id_str isEqualToString:@"0"])
            serviceProvider_ID_string = @"";
    }
    else if(btnTag==333)
    {
        filledUnfilled_Answer_Label.text=value_str;
        
        if ([value_str isEqualToString:@"Filled"]) {
            filledUnfilled_ID_string=@"1";
        }
        else
        {
            filledUnfilled_ID_string=@"2";
        }
    }
    else if(btnTag==444)
    {
        if ([value_str isEqualToString:@"Filled"]) {
            filledUnfilled_ID_string=@"1";
        }
        else
        {
            filledUnfilled_ID_string=@"2";
        }
        [self getJobDetails_Data:[GISUtility returningstring:chooseRequestID_string]:login_Obj.token_string:serviceProvider_ID_string:[GISUtility returningstring:jobDate_Answer_Label.text]:[GISUtility returningstring:filledUnfilled_ID_string]];
    }
    else if (btnTag==1111)
    {
        jobDate_temp_string=value_str;
    }
    else if (btnTag==1212)
    {
        startTime_temp_string=value_str;
        
        if ([startTime_temp_string length] && [endTime_temp_string length]){
            if ([GISUtility dateComparision:startTime_temp_string :endTime_temp_string:YES])
            {}
            else
            {
                [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"start Time alert", TABLE, nil)];
                startTime_temp_string=@"";
            }
        }

    }
    else if (btnTag==1313)
    {
        endTime_temp_string=value_str;
        
        if ([startTime_temp_string length] && [endTime_temp_string length]){
            if ([GISUtility dateComparision:startTime_temp_string :endTime_temp_string:YES])
            {}
            else
            {
                [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"end Time alert", TABLE, nil)];
                startTime_temp_string=@"";
            }
        }
    }
    else if (btnTag==555)
    {
        typeOfservice_temp_string=value_str;
    }
    else if (btnTag==666)
    {
        serviceProvider_temp_string=value_str;
        
        if([id_str isEqualToString:@"0"])
            serviceProvider_temp_string = @"";
    }
    else if (btnTag==777)
    {
        payType_temp_string=value_str;
    }
    else if (btnTag==888)// Create Jobs
    {
        typeOfServiceProviders_Answer_Label.text=value_str;
    }
    else if (btnTag==999) // Create Jobs
    {
        payLevel_Answer_Label.text=value_str;
    }
    else if (btnTag==1010) // Create Jobs
    {
        billLevel_Answer_Label.text=value_str;
    }
    else if (btnTag==4646)
    {
        //5,4,2,1,4 --16  (16+6=22)
        //4 ,9, 1
        startDate_jobHistory_Answer_Label.text=value_str;
    }
    else if (btnTag==5656)
    {
        endDate_jobHistory_Answer_Label.text=value_str;
    }
    if (btnTag==1111||btnTag==1212||btnTag==1313||btnTag==555||btnTag==666||btnTag==777)
        [jobDetails_tableView reloadData];
}

-(void)editButtonPressed:(id)sender
{
    NSLog(@"tag--%d",[sender tag]);
    if(!isEdit_Button_Clicked)
    {
        isEdit_Button_Clicked=YES;
        selected_row=[sender tag];
        GISJobDetailsObject *tempObj=[jobDetails_Array objectAtIndex:[sender tag]];
        jobDate_temp_string=tempObj.jobDate_string;
        startTime_temp_string=tempObj.startTime_string;
        endTime_temp_string=tempObj.endTime_string;
        typeOfservice_temp_string=tempObj.typeOfService_string;
        serviceProvider_temp_string=tempObj.serviceProvider_string;
        payType_temp_string=tempObj.payType_string;
    }
    else if(isEdit_Button_Clicked){
        /*
        GISJobDetailsObject *tempObj=[jobDetails_Array objectAtIndex:[sender tag]];
        tempObj.jobDate_string=jobDate_temp_string;
        tempObj.startTime_string=startTime_temp_string;
        tempObj.endTime_string=endTime_temp_string;
        tempObj.typeOfService_string=typeOfservice_temp_string;
        tempObj.serviceProvider_string=serviceProvider_temp_string;
        tempObj.payType_string=payType_temp_string;
        //[jobDetails_Array replaceObjectAtIndex:[sender tag] withObject:tempObj];
        //Call the Save Update JObs Service here
        */
        if([payType_temp_string length] == 0 && [serviceProvider_temp_string length]>0){
            [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"select_pay_type", TABLE, nil)];
            return;
        }
        jobChangeHistory_background_UIView.hidden=NO;
        jobChangeHistory_foreground_UIView.hidden=NO;
        //[self showChangeJobHistoryView];
        //selected_row=999999;
        isEdit_Button_Clicked=NO;
    }
    
    rowValue = [sender tag];
    
    NSArray *indexPaths = [jobDetails_tableView indexPathsForVisibleRows];
    NSIndexPath *selectedIndexPath = [indexPaths objectAtIndex:[sender tag]];
    
    [jobDetails_tableView beginUpdates];
    [jobDetails_tableView reloadRowsAtIndexPaths:@[selectedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    [jobDetails_tableView endUpdates];
    
    //[jobDetails_tableView reloadData];
}


-(void)deleteButtonPressed:(id)sender
{
    UIAlertView *alertVIew = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) message:NSLocalizedStringFromTable(@"do you want to delete", TABLE, nil) delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alertVIew.tag = [sender tag];
    alertVIew.delegate = self;
    [alertVIew show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        GISJobDetailsObject *jobObj = [jobDetails_Array objectAtIndex:alertView.tag];
        if([jobObj.jobID_string length] == 0)
        {
            currentObjTag_toDelete=alertView.tag;
        }
        else
        {
            NSMutableDictionary *delete_eventdict;
            delete_eventdict=[[NSMutableDictionary alloc]init];
            
            GISJobDetailsObject *tempObj=[jobDetails_Array objectAtIndex:alertView.tag];
            
            [delete_eventdict setObject:tempObj.jobID_string forKey:kJobDetais_JobID];
            [delete_eventdict setObject:@"true" forKey:kJobDetais_deleteJob];
            
            [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
            [[GISServerManager sharedManager] deleteJobs:self withParams:delete_eventdict finishAction:@selector(successmethod_deleteJobs:) failAction:@selector(failuremethod_deleteJobs:)];
            
        }
    }
}

-(void)dismissPopOverNow
{
    [popover dismissPopoverAnimated:YES];
}

-(IBAction)addNewJob_buttonPressed:(id)sender
{
    appDelegate.chooseRequest_ID_String=chooseRequestID_string;
    GISAddUpdateJobsViewController *jobaddUpdate=[[GISAddUpdateJobsViewController alloc]initWithNibName:@"GISAddUpdateJobsViewController" bundle:nil];
    [self presentViewController:jobaddUpdate animated:YES completion:nil];
}


-(IBAction)nextButtonPressed:(id)sender
{
    appDelegate.isFromContacts = YES;
    NSDictionary *infoDict=[NSDictionary dictionaryWithObjectsAndKeys:@"6",@"tabValue",[NSNumber numberWithBool:YES],@"isFromContacts",nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:kTabSelected object:nil userInfo:infoDict];
}

-(IBAction)jobHistory_TitleButtonPressed:(id)sender
{
    [self hideKeyBoard];
    jobChangeHistory_background_UIView.hidden=YES;
    jobChangeHistory_foreground_UIView.hidden=YES;
    if ([sender tag]==1)//Cancel Button
    {
        selected_row=999999;
    }
    else//Done Button
    {
        if (!appDelegate.addNewJob_dictionary.count) {
            GISJobDetailsObject *tempObj=[jobDetails_Array objectAtIndex:selected_row];
            tempObj.jobDate_string=jobDate_temp_string;
            tempObj.startTime_string=startTime_temp_string;
            tempObj.endTime_string=endTime_temp_string;
            tempObj.typeOfService_string=typeOfservice_temp_string;
            tempObj.serviceProvider_string=serviceProvider_temp_string;
            tempObj.payType_string=payType_temp_string;
            [jobDetails_Array replaceObjectAtIndex:selected_row withObject:tempObj];
            
            NSString *typeOfService_ID_temp_String=@"";
            NSString *serviceProvider_ID_temp_String=@"";
            NSString *payType_ID_temp_String=@"";
            
            NSPredicate *predicate_typeOfService=[NSPredicate predicateWithFormat:@"value_String=%@",tempObj.typeOfService_string];
            NSArray *array_typeOfService=[typeOfService_array filteredArrayUsingPredicate:predicate_typeOfService];
            if (array_typeOfService.count>0) {
                GISDropDownsObject *obj=[array_typeOfService lastObject];
                typeOfService_ID_temp_String=obj.id_String;
            }
            
            NSPredicate *predicate_serviceProvider=[NSPredicate predicateWithFormat:@"service_Provider_String=%@",tempObj.serviceProvider_string];
            NSArray *array_serviceProvider=[serviceProvider_Array filteredArrayUsingPredicate:predicate_serviceProvider];
            if (array_serviceProvider.count>0) {
                GISServiceProviderObject *obj=[array_serviceProvider lastObject];
                serviceProvider_ID_temp_String=obj.id_String;
            }
            
            NSPredicate *predicate_payType=[NSPredicate predicateWithFormat:@"value_String=%@",tempObj.payType_string];
            NSArray *array_payType=[payType_array filteredArrayUsingPredicate:predicate_payType];
            if (array_payType.count>0) {
                GISDropDownsObject *obj=[array_payType lastObject];
                payType_ID_temp_String=obj.id_String;
            }
            
            NSMutableDictionary *update_eventdict;
            update_eventdict=[[NSMutableDictionary alloc]init];
            
            [update_eventdict setObject:tempObj.jobID_string forKey:kJobDetais_JobID];
            [update_eventdict setObject:tempObj.startTime_string forKey:kJobDetais_StartTime];
            [update_eventdict setObject:tempObj.endTime_string forKey:kJobDetais_EndTime];
            [update_eventdict setObject:tempObj.jobDate_string forKey:kJobDetais_JobDate];
            [update_eventdict setObject:payType_ID_temp_String forKey:kViewSchedule_PayTypeID];
            [update_eventdict setObject:serviceProvider_ID_temp_String forKey:kViewSchedule_ServiceProviderID];
            [update_eventdict setObject:typeOfService_ID_temp_String forKey:kViewSchedule_SubroleID];
            [update_eventdict setObject:login_Obj.requestorID_string forKey:kLoginRequestorID];
            [update_eventdict setObject:jobHistory_textView.text forKey:kViewSchedule_JobNotes];
            
            [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
            [[GISServerManager sharedManager] updateJobDetails:self withParams:update_eventdict finishAction:@selector(successmethod_updateJobDetails_data:) failAction:@selector(failuremethod_updateJobDetails_data:)];
            //Call the Save Update JObs Service here
        }
        else
        {
            [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
            [[GISServerManager sharedManager] addNewJobDetails:self withParams:appDelegate.addNewJob_dictionary finishAction:@selector(successmethod_AddNewJob_data:) failAction:@selector(failuremethod_AddNewJob_data:)];
            [appDelegate.addNewJob_dictionary removeAllObjects];
        }
    }
}

-(void)showChangeJobHistoryView
{
    {
        if (!appDelegate.addNewJob_dictionary.count) {
            GISJobDetailsObject *tempObj=[jobDetails_Array objectAtIndex:selected_row];
            tempObj.jobDate_string=jobDate_temp_string;
            tempObj.startTime_string=startTime_temp_string;
            tempObj.endTime_string=endTime_temp_string;
            tempObj.typeOfService_string=typeOfservice_temp_string;
            tempObj.serviceProvider_string=serviceProvider_temp_string;
            tempObj.payType_string=payType_temp_string;
            [jobDetails_Array replaceObjectAtIndex:selected_row withObject:tempObj];
            
            NSString *typeOfService_ID_temp_String=@"";
            NSString *serviceProvider_ID_temp_String=@"";
            NSString *payType_ID_temp_String=@"";
            
            NSPredicate *predicate_typeOfService=[NSPredicate predicateWithFormat:@"value_String=%@",tempObj.typeOfService_string];
            NSArray *array_typeOfService=[typeOfService_array filteredArrayUsingPredicate:predicate_typeOfService];
            if (array_typeOfService.count>0) {
                GISDropDownsObject *obj=[array_typeOfService lastObject];
                typeOfService_ID_temp_String=obj.id_String;
            }
            
            NSPredicate *predicate_serviceProvider=[NSPredicate predicateWithFormat:@"service_Provider_String=%@",tempObj.serviceProvider_string];
            NSArray *array_serviceProvider=[serviceProvider_Array filteredArrayUsingPredicate:predicate_serviceProvider];
            if (array_serviceProvider.count>0) {
                GISServiceProviderObject *obj=[array_serviceProvider lastObject];
                serviceProvider_ID_temp_String=obj.id_String;
            }
            
            NSPredicate *predicate_payType=[NSPredicate predicateWithFormat:@"value_String=%@",tempObj.payType_string];
            NSArray *array_payType=[payType_array filteredArrayUsingPredicate:predicate_payType];
            if (array_payType.count>0) {
                GISDropDownsObject *obj=[array_payType lastObject];
                payType_ID_temp_String=obj.id_String;
            }
            
            NSMutableDictionary *update_eventdict;
            update_eventdict=[[NSMutableDictionary alloc]init];
            
            [update_eventdict setObject:tempObj.jobID_string forKey:kJobDetais_JobID];
            [update_eventdict setObject:tempObj.startTime_string forKey:kJobDetais_StartTime];
            [update_eventdict setObject:tempObj.endTime_string forKey:kJobDetais_EndTime];
            [update_eventdict setObject:tempObj.jobDate_string forKey:kJobDetais_JobDate];
            [update_eventdict setObject:payType_ID_temp_String forKey:kViewSchedule_PayTypeID];
            [update_eventdict setObject:serviceProvider_ID_temp_String forKey:kViewSchedule_ServiceProviderID];
            [update_eventdict setObject:typeOfService_ID_temp_String forKey:kViewSchedule_SubroleID];
            [update_eventdict setObject:login_Obj.requestorID_string forKey:kLoginRequestorID];
            [update_eventdict setObject:jobHistory_textView.text forKey:kViewSchedule_JobNotes];
            
            [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
            [[GISServerManager sharedManager] updateJobDetails:self withParams:update_eventdict finishAction:@selector(successmethod_updateJobDetails_data:) failAction:@selector(failuremethod_updateJobDetails_data:)];
            //Call the Save Update JObs Service here
        }
        else
        {
            [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
            [[GISServerManager sharedManager] addNewJobDetails:self withParams:appDelegate.addNewJob_dictionary finishAction:@selector(successmethod_AddNewJob_data:) failAction:@selector(failuremethod_AddNewJob_data:)];
            [appDelegate.addNewJob_dictionary removeAllObjects];
        }
    }
    
    //jobHistory_textView.text = @"";
    //jobChangeHistory_background_UIView.hidden=NO;
    //jobChangeHistory_foreground_UIView.hidden=NO;
}

-(void)successmethod_updateJobDetails_data:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"successmethod_updateScheduledata Success---%@",response.responseJson);
    
    [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"jobs_updated",TABLE, nil)];
    
    NSArray *indexPaths = [jobDetails_tableView indexPathsForVisibleRows];
    NSIndexPath *selectedIndexPath = [indexPaths objectAtIndex:rowValue];

    [jobDetails_tableView beginUpdates];
    [jobDetails_tableView reloadRowsAtIndexPaths:@[selectedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    [jobDetails_tableView endUpdates];
    
}
-(void)failuremethod_updateJobDetails_data:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"Failure");
    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
}

-(void)successmethod_AddNewJob_data:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSDictionary *saveUpdateDict;
    NSArray *responseArray= response.responseJson;
    saveUpdateDict = [responseArray lastObject];
    NSLog(@"successmethod_AddNewJob_data Success---%@",response.responseJson);
    
    if ([[[saveUpdateDict objectForKey:kStatusCode] stringValue] isEqualToString:@"200"]) {
        
        [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"jobs_successed",TABLE, nil)];
        [self getJobDetails_Data :[GISUtility returningstring:chooseRequestID_string] :login_Obj.token_string:@"":@"":@""];
        
    }
    
}
-(void)failuremethod_AddNewJob_data:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"Failure");
    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
}

-(void)hideKeyBoard
{
    [jobHistory_textView resignFirstResponder];
    [user_textField resignFirstResponder];
}

-(IBAction)checkAllJobs_buttonPressed:(id)sender
{
    if (isAlljobs_Checked) {
        isAlljobs_Checked=NO;
        [createJobsCheckDictionary removeAllObjects];
        [createJobdate_Array removeAllObjects];

        [alljobs_Checked_button setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    }
    else
    {
        [alljobs_Checked_button setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        
        isAlljobs_Checked=YES;
        [createJobsCheckDictionary removeAllObjects];
        [createJobdate_Array removeAllObjects];
        for (int i=0; i<detail_mut_array.count; i++)
        {
            [createJobsCheckDictionary setObject:[NSString stringWithFormat:@"%ld",(long)i] forKey:[NSString stringWithFormat:@"%ld",(long)i]];
            [createJobdate_Array addObject:[NSString stringWithFormat:@"%ld",(long)i]];
        }
        
    }
    [createJObs_tableView reloadData];
}

-(IBAction)createJobsButton_Pressed:(id)sender
{
    billLevel_Answer_Label.text =  NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    typeOfServiceProviders_Answer_Label.text =  NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    payLevel_Answer_Label.text = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    
    noOfServiceProviders_TextField.text = @"";
    
    appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([appDelegate.chooseRequest_ID_String isEqualToString:@"-- Select --"]){
        [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"select_choose_request", TABLE, nil)]; return;
    }
    else
    {
    NSMutableDictionary *paramsDict1=[[NSMutableDictionary alloc]init];
    [paramsDict1 setObject:[GISUtility returningstring:chooseRequestID_string] forKey:kID];
    [paramsDict1 setObject:login_Obj.token_string forKey:kToken];
        [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
    [[GISServerManager sharedManager] getDateTimeDetails:self withParams:paramsDict1 finishAction:@selector(successmethod_get_Date_Time:) failAction:@selector(failuremethod_get_Date_Time:)];
    
    [noOfServiceProviders_TextField resignFirstResponder];
    isAlljobs_Checked=NO;
    createJobsCheckDictionary=[[NSMutableDictionary alloc]init];
    createJobdate_Array = [[NSMutableArray alloc] init];
    createJobs_UIVIew.hidden=NO;
    [createJobs_Middle_UIVIew.layer setCornerRadius:10.0f];
    [createJobs_Middle_UIVIew.layer setBorderWidth:0.3f];
        [createJObs_tableView reloadData];
    }
}

-(IBAction)cancelButtonPressed_CreateJobs:(id)sender
{
    createJobs_UIVIew.hidden=YES;
}


-(IBAction)doneButtonPressed_CreateJobs:(id)sender
{
    if (![numberOfServiceProviders_string length])
       [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"number_of_service_providers", TABLE, nil)];
    else if (![typeOfServiceProviders_Answer_Label.text length])
        [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"select_Type_of_service_providers", TABLE, nil)];
    else if (![payLevel_Answer_Label.text length])
        [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"select_pay_level", TABLE, nil)];
    else if (![billLevel_Answer_Label.text length])
        [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"select_bill_level", TABLE, nil)];
    else if (createJobsCheckDictionary.count<1)
        [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"select_one_job", TABLE, nil)];
    else
    {
        [self sendCreateJObs_data];
    }
    
}

-(IBAction)craeteJobPressed:(id)sender{
    
    [self sendCreateJObs_data];
}

-(void)sendCreateJObs_data
{
    NSString *typeOfService_ID_temp_String=@"";
    NSString *payLevel_ID_temp_String=@"";
    NSString *billLevel_ID_temp_String=@"";

    
    NSPredicate *predicate_typeOfService=[NSPredicate predicateWithFormat:@"value_String=%@",typeOfServiceProviders_Answer_Label.text];
    NSArray *array_typeOfService=[typeOfService_array filteredArrayUsingPredicate:predicate_typeOfService];
        if (array_typeOfService.count>0) {
        GISServiceProviderObject *obj=[array_typeOfService lastObject];
        typeOfService_ID_temp_String=obj.id_String;
    }
    
    NSPredicate *predicate_payType=[NSPredicate predicateWithFormat:@"value_String=%@",payLevel_Answer_Label.text];
    NSArray *array_payType=[payLevel_Array filteredArrayUsingPredicate:predicate_payType];
    if (array_payType.count>0) {
        GISDropDownsObject *obj=[array_payType lastObject];
        payLevel_ID_temp_String=obj.id_String;
    }
    
    
    NSPredicate *predicate_billLevel=[NSPredicate predicateWithFormat:@"value_String=%@",billLevel_Answer_Label.text];
    NSArray *array_billLevel=[billLevel_Array filteredArrayUsingPredicate:predicate_billLevel];
    if (array_billLevel.count>0) {
        GISDropDownsObject *obj=[array_billLevel lastObject];
        billLevel_ID_temp_String=obj.id_String;
    }
    
    
    NSMutableDictionary *mainDict=[[NSMutableDictionary alloc]init];
    NSMutableArray *requestor_array=[[NSMutableArray alloc]init];
    NSMutableDictionary *requestor_Dict=[[NSMutableDictionary alloc]init];
    
    NSMutableArray *materialDetails_Array=[[NSMutableArray alloc]init];
    NSMutableDictionary *materialDetails_Listdict;
        int count=0;
    if ([numberOfServiceProviders_string length]) {
        count=[numberOfServiceProviders_string intValue];
    }
   
    for (int i=0;i<[createJobdate_Array count];i++)
    {
        if([[createJobsCheckDictionary objectForKey:[NSString stringWithFormat:@"%@",[createJobdate_Array objectAtIndex:i]]] length]>0){
            
            GISDatesAndTimesObject *dobj=[detail_mut_array objectAtIndex:[[createJobsCheckDictionary objectForKey:[NSString stringWithFormat:@"%@", [createJobdate_Array objectAtIndex:i]]]intValue]];
            
            NSLog(@"dict value %@",[createJobsCheckDictionary objectForKey:[NSString stringWithFormat:@"%@",[createJobdate_Array objectAtIndex:i]]] );
            
            for (int j=0; j<count; j++) {
                
                materialDetails_Listdict=[[NSMutableDictionary alloc]init];
                
                [materialDetails_Listdict  setObject:[GISUtility returningstring:dobj.dateTime_ID_String] forKey:kDateTime_Detail_DateTimeId];
                [materialDetails_Listdict  setObject:[GISUtility returningstring:dobj.date_String] forKey:kSearchReq_Result_JobDate];
                [materialDetails_Listdict  setObject:[GISUtility returningstring:dobj.startTime_String] forKey:kSearchReq_SP_StartTime];
                [materialDetails_Listdict  setObject:[GISUtility returningstring:dobj.endTime_String] forKey:kSearchReq_SP_EndTime];
                [materialDetails_Listdict  setObject:typeOfService_ID_temp_String forKey:kViewSchedule_SubroleID];
                [materialDetails_Listdict  setObject:payLevel_ID_temp_String forKey:kPayLevelID];
                [materialDetails_Listdict  setObject:billLevel_ID_temp_String forKey:kBillingLevelID];
                
                [materialDetails_Array addObject:materialDetails_Listdict];
            }
        }
    }
    
    appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication] delegate];
    [requestor_Dict setValue:[GISUtility returningstring:login_Obj.requestorID_string] forKey:kLoginRequestorID];
    [requestor_Dict setValue:[GISUtility returningstring:chooseRequestID_string] forKey:kSearchReq_SP_RequestID];
    
    [requestor_array addObject:requestor_Dict];
    [mainDict setObject:requestor_array forKey:kORequest];
    [mainDict setObject:materialDetails_Array forKey:koJobs];
    
    [[GISServerManager sharedManager] createJObs_JobDetails:self withParams:mainDict finishAction:@selector(successmethod_createJObs_JobDetails:) failAction:@selector(failuremethod_createJObs_JobDetails:)];
}

-(void)successmethod_createJObs_JobDetails:(GISJsonRequest *)response
{
    NSDictionary *saveUpdateDict;
    NSArray *responseArray= response.responseJson;
    saveUpdateDict = [responseArray lastObject];
    NSLog(@"successmethod_createJObs_JobDetails Success---%@",saveUpdateDict);
    
    if ([[[saveUpdateDict objectForKey:kStatusCode] stringValue] isEqualToString:@"200"]) {
        
        [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"jobs_successed",TABLE, nil)];
        
        if ([appDelegate.chooseRequest_ID_String length] > 0 && ![appDelegate.chooseRequest_ID_String isEqualToString:@"0"]) {
            
            [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
            
            NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
            [paramsDict setObject:appDelegate.chooseRequest_ID_String forKey:kID];
            [paramsDict setObject:login_Obj.token_string forKey:kToken];
            [[GISServerManager sharedManager] getChooseRequestDetailsData:self withParams:paramsDict finishAction:@selector(successmethod_getRequestDetails:) failAction:@selector(failuremethod_getRequestDetails:)];
            
        }
        
        [self getJobDetails_Data :[GISUtility returningstring:chooseRequestID_string] :login_Obj.token_string:@"":@"":@""];
        
    }else{
        
        [self removeLoadingView];
        [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
    }
     createJobs_UIVIew.hidden=YES;
}

-(void)failuremethod_createJObs_JobDetails:(GISJsonRequest *)response
{
    createJobs_UIVIew.hidden=YES;
    [self removeLoadingView];
    NSLog(@"Failure");
    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
}

-(void)check_uncheck_createjobsButtonPresses:(id)sender
{
    if ([createJobsCheckDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]]) {
        [createJobsCheckDictionary removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
        [createJobdate_Array removeObject:[NSString stringWithFormat:@"%d",[sender tag]]];
    }
    else
    {
        [createJobsCheckDictionary setObject:[NSString stringWithFormat:@"%ld",(long)[sender tag]] forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
        [createJobdate_Array addObject:[NSString stringWithFormat:@"%d",[sender tag]]];
    }
    [createJObs_tableView reloadData];
}


-(void)addLoadViewWithLoadingText:(NSString*)title
{
    [[GISLoadingView sharedDataManager] addLoadingAlertView:title];
    
}

-(void)removeLoadingView
{
    [[GISLoadingView sharedDataManager] removeLoadingAlertview];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    numberOfServiceProviders_string=textField.text;
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSLog(@"textViewShouldBeginEditing:");
    textView.text = @"";
    [GISUtility moveemailView:YES viewHeight:-150 view:self.view];
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    NSLog(@"textViewDidBeginEditing:");
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    jobHistory_textView.text = @"Job History Notes";
    [GISUtility moveemailView:NO viewHeight:0 view:self.view];
    [textView resignFirstResponder];
}

-(IBAction)searchButtonPressed:(id)sender{
    
    if([serviceProvider_ID_string length] == 0)
        serviceProvider_ID_string = @"";
    if([filledUnfilled_ID_string length] == 0)
        filledUnfilled_ID_string = @"";
    
    NSMutableDictionary *paramsDict1=[[NSMutableDictionary alloc]init];
    [paramsDict1 setObject:[GISUtility returningstring:chooseRequestID_string] forKey:kSearchReq_Result_RequestId];
    [paramsDict1 setObject:login_Obj.token_string forKey:kToken];
    [paramsDict1 setObject:jobDate_Answer_Label.text forKey:kJobDetais_JobDate];
    [paramsDict1 setObject:serviceProvider_ID_string forKey:kJobDetais_ServiceProvider];
    [paramsDict1 setObject:filledUnfilled_ID_string forKey:kJobDetais_FilledUnFilled];
    [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
    [[GISServerManager sharedManager] filterJobsDetails:self withParams:paramsDict1 finishAction:@selector(successmethod_filter_JobDetails:) failAction:@selector(failuremethod_filter_JobDetails:)];

}

-(void)successmethod_filter_JobDetails:(GISJsonRequest *)response
{
    NSDictionary *saveUpdateDict;
    NSArray *responseArray= response.responseJson;
    saveUpdateDict = [responseArray lastObject];
    NSLog(@"successmethod_filter_JobDetails Success---%@",saveUpdateDict);
    
    serviceProvider_Answer_Label.text =  NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    filledUnfilled_Answer_Label.text =  NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    jobDate_Answer_Label.text = @"";
    serviceProvider_ID_string = @"";
    filledUnfilled_ID_string = @"";
    
    
    if (responseArray.count<1) {
        
        if([jobDetails_Array count] >0)
           [jobDetails_Array removeAllObjects];
        [jobDetails_tableView reloadData];
        
        [self removeLoadingView];

        //[GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"no_data",TABLE, nil)];
        return;
    }
    
    if ([[saveUpdateDict objectForKey:kStatusCode] isEqualToString:@"200"]) {
        
        [self removeLoadingView];
        [[GISStoreManager sharedManager]removeJobDetailsObjects];
        GISJobDetailsStore *jobDetailsStore;
        jobDetailsStore=[[GISJobDetailsStore alloc]initWithJsonDictionary:response.responseJson];
        
        jobDetails_Array=[[NSMutableArray alloc] init];
        jobDetails_Array =[[GISStoreManager sharedManager]getJobDetailsObjects];
        
        [jobDetails_tableView reloadData];

        
    }else{
        
        [self removeLoadingView];
        [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
    }
    createJobs_UIVIew.hidden=YES;
}

-(void)failuremethod_filter_JobDetails:(GISJsonRequest *)response
{
    createJobs_UIVIew.hidden=YES;
    [self removeLoadingView];
    NSLog(@"Failure");
    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
}

-(void)successmethod_getRequestDetails:(GISJsonRequest *)response
{
    NSLog(@"successmethod_getRequestDetails Success---%@",response.responseJson);
    [self removeLoadingView];

    NSDictionary *saveUpdateDict;
    NSArray *responseArray= response.responseJson;
    saveUpdateDict = [responseArray lastObject];
    if ([[saveUpdateDict objectForKey:kStatusCode] isEqualToString:@"200"]) {
        
        chooseRequestDetailsObj=[[GISChooseRequestDetailsObject alloc]initWithStoreChooseRequestDetailsDictionary:response.responseJson];
        [[GISStoreManager sharedManager]addChooseRequestDetailsObject:chooseRequestDetailsObj];
        appDelegate.createdDateString = chooseRequestDetailsObj.createdDate_String_chooseReqParsedDetails;
        appDelegate.createdByString = [NSString stringWithFormat:@"%@ %@", chooseRequestDetailsObj.reqFirstName_String_chooseReqParsedDetails,chooseRequestDetailsObj.reqLastName_String_chooseReqParsedDetails];
        appDelegate.statusString = chooseRequestDetailsObj.requestStatus_String_chooseReqParsedDetails;
        
         [[NSNotificationCenter defaultCenter]postNotificationName:kRequestInfo object:nil];
        
    }else{
        
        [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
    }

    
}

-(void)failuremethod_getRequestDetails:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"Failure");
    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
}

-(void)successmethod_deleteJobs:(GISJsonRequest *)response
{
    [self removeLoadingView];
     NSLog(@"successmethod_updateScheduledata Success---%@",response.responseJson);
    
    NSDictionary *saveUpdateDict;
    NSArray *responseArray= response.responseJson;
    saveUpdateDict = [responseArray lastObject];
    NSString *respnseCode = [[saveUpdateDict objectForKey:kStatusCode] stringValue];
    if ([respnseCode isEqualToString:@"200"]) {
        
         [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"jobs_deleted",TABLE, nil)];
        
        [self getJobDetails_Data :[GISUtility returningstring:appDelegate.chooseRequest_ID_String] :login_Obj.token_string:@"":@"":@""];

    }
}
-(void)failuremethod_deleteJobs:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"Failure");
    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kselectedChooseReqNumber object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"changeJobHistory" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"createNewJob" object:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
