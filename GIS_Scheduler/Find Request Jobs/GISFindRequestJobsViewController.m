//
//  GISFindRequestJobsViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 04/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISFindRequestJobsViewController.h"
#import "GISConstants.h"
#import "GISFindRequestJobs_Cell.h"
#import "GISJobAssignmentViewController.h"
#import "GISDatabaseManager.h"
#import "GISServerManager.h"
#import "GISJsonRequest.h"
#import "GISJSONProperties.h"
#import "GISUtility.h"
#import "GISLoadingView.h"
#import "GISStoreManager.h"
#import "GISSchedulerSPJobsStore.h"

@interface GISFindRequestJobsViewController ()

@end

@implementation GISFindRequestJobsViewController

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
     requestId_label.text=NSLocalizedStringFromTable(@"Request_ID", TABLE, nil);
    self.title=NSLocalizedStringFromTable(@"Find_Requests_Jobs", TABLE, nil);
    
    findReqObj=[[GISFindRequestJobsObject alloc]init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    findReqObj.startDate_JobData_string=[formatter stringFromDate:[NSDate date]];//@"08/25/2012";
    findReqObj.endDate_JobData_string=[formatter stringFromDate:[NSDate date]];//@"08/27/2012";
    
    findReqObj.weekDays_dictionary=[[NSMutableDictionary alloc]init];
    
    requestorType_array=[[NSMutableArray alloc]init];
    requestor_array=[[NSMutableArray alloc]init];
    registeredConsumers_array=[[NSMutableArray alloc]init];
    generalLocation_array=[[NSMutableArray alloc]init];
    eventType_array=[[NSMutableArray alloc]init];
    payLevel_array=[[NSMutableArray alloc]init];
    primaryAudience_array=[[NSMutableArray alloc]init];
    model_array=[[NSMutableArray alloc]init];
    serviceProviderType_array=[[NSMutableArray alloc]init];
    serviceProvider_array=[[NSMutableArray alloc]init];
    payType_array=[[NSMutableArray alloc]init];
    billLevel_array=[[NSMutableArray alloc]init];
    chooseRequest_mutArray=[[NSMutableArray alloc]init];
    createdBy_mutArray=[[NSMutableArray alloc]init];
    
    NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
    NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
    login_Obj=[requetId_array lastObject];
    
    
    
    NSString *registeredConsumers_statement = [[NSString alloc]initWithFormat:@"select * from TBL_REGISTERED_CONSUMERS;"];
    registeredConsumers_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:registeredConsumers_statement] mutableCopy];
    NSString *requestor_statement = [[NSString alloc]initWithFormat:@"select * from TBL_REQUESTORS;"];
    requestor_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:requestor_statement] mutableCopy];
    
    NSString *createdBy_statement = [[NSString alloc]initWithFormat:@"select * from TBL_CREATED_BY;"];
    createdBy_mutArray = [[[GISDatabaseManager sharedDataManager] getDropDownArray:createdBy_statement] mutableCopy];
    NSString *mode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_MODE_JOBASSIGNMENT;"];
    model_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:mode_statement] mutableCopy];
    NSString *requestorType_statement = [[NSString alloc]initWithFormat:@"select * from TBL_REQUESTOR_TYPE;"];
    requestorType_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:requestorType_statement] mutableCopy];
    
    
    
     self.days_MutableStr = [[NSMutableString alloc] init];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [findReqJobs_tableView reloadData];
    self.navigationItem.hidesBackButton=YES;
    
    self.navigationItem.title = NSLocalizedStringFromTable(@"Find_Requests_Jobs", TABLE, nil);
    
    NSString *generalLocation_statement = [[NSString alloc]initWithFormat:@"select * from TBL_GENERAL_LOCATION  ORDER BY ID DESC;"];
    generalLocation_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:generalLocation_statement] mutableCopy];
    
    NSString *eventCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_EVENT_TYPE;"];
    eventType_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:eventCode_statement] mutableCopy];
    
    payLevel_array=[[GISStoreManager sharedManager]getPayLevelObjects];
    billLevel_array=[[GISStoreManager sharedManager]getBillLevelObjects];
    NSString *spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO"];
    serviceProvider_array = [[[GISDatabaseManager sharedDataManager] getServiceProviderArray:spCode_statement] mutableCopy];
    NSString *typeOfService_statement = [[NSString alloc]initWithFormat:@"select * from TBL_TYPE_OF_SERVICE  ORDER BY ID DESC;"];
    serviceProviderType_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:typeOfService_statement] mutableCopy];
    NSString *payType_statement = [[NSString alloc]initWithFormat:@"select * from TBL_PAY_TYPE"];
    payType_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:payType_statement] mutableCopy];
    
    NSString *primaryAudience_statement = [[NSString alloc]initWithFormat:@"select * from TBL_PRIMARY_AUDIENCE;"];
    primaryAudience_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:primaryAudience_statement] mutableCopy];
    
    NSString *requetDetails_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SEARCH_CHOOSE_REQUEST ORDER BY ID DESC;"];
    chooseRequest_mutArray = [[[GISDatabaseManager sharedDataManager] getDropDownArray:requetDetails_statement] mutableCopy];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
    
        GISFindRequestJobs_Cell *cell=(GISFindRequestJobs_Cell *)[tableView dequeueReusableCellWithIdentifier:@"GISFindReqJobs_ReqDataCell"];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISFindReqJobs_ReqDataCell" owner:self options:nil] objectAtIndex:0];
        }
        cell.startDate_Answer_label_.text=[GISUtility returningstring:findReqObj.startDate_string];
        cell.endDate_Answer_label_.text=[GISUtility returningstring:findReqObj.endDate_string];
        cell.startTime_Answer_label_.text=[GISUtility returningstring:findReqObj.startTime_string];
        cell.endTime_Answer_label_.text=[GISUtility returningstring:findReqObj.endTime_string];
        
        if ([findReqObj.requestorType_string length])
            cell.requestorType_Answer_label_.text = [GISUtility returningstring:findReqObj.requestorType_string];
        else
            cell.requestorType_Answer_label_.text = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
        
        if ([findReqObj.requestor_string length])
            cell.requestor_Answer_label_.text=[GISUtility returningstring:findReqObj.requestor_string];
        else
            cell.requestor_Answer_label_.text = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
        
        if ([findReqObj.registeredConsumers_string length])
            cell.registeredConsumer_Answer_label_.text = [GISUtility returningstring:findReqObj.registeredConsumers_string];
        else
            cell.registeredConsumer_Answer_label_.text = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
        
        if ([findReqObj.generalLocation_string length])
            cell.generalLocation_Answer_label_.text = [GISUtility returningstring:findReqObj.generalLocation_string];
        else
           cell.generalLocation_Answer_label_.text = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
        
        if ([findReqObj.evenyType_string length])
            cell.eventType_Answer_label_.text = [GISUtility returningstring:findReqObj.evenyType_string];
        else
            cell.eventType_Answer_label_.text = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);

        if ([findReqObj.payLevel_string length])
            cell.payLevel_Answer_label_.text = [GISUtility returningstring:findReqObj.payLevel_string];
        else
            cell.payLevel_Answer_label_.text = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
        
        if ([findReqObj.primaryAudience_string length])
            cell.primaryAudience_Answer_label_.text = [GISUtility returningstring:findReqObj.primaryAudience_string];
        else
            cell.primaryAudience_Answer_label_.text =  NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);

        if ([findReqObj.model_string length])
            cell.model_Answer_label_.text = [GISUtility returningstring:findReqObj.model_string];
        else
            cell.model_Answer_label_.text = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);

        
        if ([findReqObj.openToPublic_string length])
        {
            if ([findReqObj.openToPublic_string isEqualToString:@"1"]) {
                [cell.openToPublic_Yes_ImageView setImage:[UIImage imageNamed:@"radio_button_filled"]];
                [cell.openToPublic_no_ImageView setImage:[UIImage imageNamed:@"radio_button_empty"] ];
            }
            else
            {
                [cell.openToPublic_Yes_ImageView setImage:[UIImage imageNamed:@"radio_button_empty"] ];
                [cell.openToPublic_no_ImageView setImage:[UIImage imageNamed:@"radio_button_filled"] ];
            }
        }
        
        return cell;
    }
    
    GISFindRequestJobs_Cell *cell=(GISFindRequestJobs_Cell *)[tableView dequeueReusableCellWithIdentifier:@"GISFindReqJobs_JobDataToSearch_Cell"];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"GISFindReqJobs_JobDataToSearch_Cell" owner:self options:nil] objectAtIndex:0];
    }
    
    cell.startDate_JobData_Answer_label_.text=[GISUtility returningstring:findReqObj.startDate_JobData_string];
    cell.endDate_JobData_Answer_label_.text=[GISUtility returningstring:findReqObj.endDate_JobData_string];
    cell.startTime_JobData_Answer_label_.text=[GISUtility returningstring:findReqObj.startTime_JobData_string];
    cell.endTime_JobData_Answer_label_.text=[GISUtility returningstring:findReqObj.endTime_JobData_string];
    
    if ([findReqObj.serviceProviderType_string length])
        cell.serviceProviderType_Answer_label_.text = [GISUtility returningstring:findReqObj.serviceProviderType_string];
    else
        cell.serviceProviderType_Answer_label_.text = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    
    if ([findReqObj.serviceProvider_string length])
        cell.serviceProvider_Answer_label_.text = [GISUtility returningstring:findReqObj.serviceProvider_string];

    else
        cell.serviceProvider_Answer_label_.text = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    
    if ([findReqObj.payType_string length])
        cell.payType_Answer_label_.text = [GISUtility returningstring:findReqObj.payType_string];
    else
        cell.payType_Answer_label_.text =  NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    
    if ([findReqObj.createdBy_string length])
        cell.createdBy_Answer_label_.text = [GISUtility returningstring:findReqObj.createdBy_string];
    else
        cell.createdBy_Answer_label_.text =  NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    
    if ([findReqObj.payLevel_JobData_string length])
         cell.payLevel_JobDate_Answer_label_.text = [GISUtility returningstring:findReqObj.payLevel_JobData_string];
    else
         cell.payLevel_JobDate_Answer_label_.text = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);

    if ([findReqObj.billLevel_string length])
        cell.billLevel_Answer_label_.text = [GISUtility returningstring:findReqObj.billLevel_string];
    else
        cell.billLevel_Answer_label_.text = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);

    cell.cancelDate_Answer_label_.text=[GISUtility returningstring:findReqObj.cancelDate_string];
    
    for (int j=1; j<=7; j++) {
        
        NSString *str=[findReqObj.weekDays_dictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)j]];
        if ([str isEqualToString:@"Monday"]) {
            cell.monday_ImageView_.image=[UIImage imageNamed:@"checked.png"];
        }
        else if ([str isEqualToString:@"Tuesday"]) {
            cell.tuesday_ImageView_.image=[UIImage imageNamed:@"checked.png"];
        }
        else if ([str isEqualToString:@"Wednesday"]) {
            cell.wednesday_ImageView_.image=[UIImage imageNamed:@"checked.png"];
        }
        else if ([str isEqualToString:@"Thursday"]) {
            cell.thursday_ImageView_.image=[UIImage imageNamed:@"checked.png"];
        }
        else if ([str isEqualToString:@"Friday"]) {
            cell.friday_ImageView_.image=[UIImage imageNamed:@"checked.png"];
        }
        else if ([str isEqualToString:@"Saturday"]) {
            cell.saturday_ImageView_.image=[UIImage imageNamed:@"checked.png"];
        }
        else if ([str isEqualToString:@"Sunday"]) {
            cell.sunday_ImageView_.image=[UIImage imageNamed:@"checked.png"];
        }
    }

    if ([findReqObj.filled_string length])
    {
        if ([findReqObj.filled_string isEqualToString:@"1"]) {
            [cell.filled_yes_ImageView setImage:[UIImage imageNamed:@"radio_button_filled"] ];
            [cell.filled_no_ImageView setImage:[UIImage imageNamed:@"radio_button_empty"]];
        }
        else
        {
            [cell.filled_yes_ImageView setImage:[UIImage imageNamed:@"radio_button_empty"]];
            [cell.filled_no_ImageView setImage:[UIImage imageNamed:@"radio_button_filled"] ];
        }
    }
    if ([findReqObj.outAgency_string length])
    {
        if ([findReqObj.outAgency_string isEqualToString:@"1"]) {
            [cell.outAgency_yes_ImageView setImage:[UIImage imageNamed:@"radio_button_filled"] ];
            [cell.outAgency_no_ImageView setImage:[UIImage imageNamed:@"radio_button_empty"]];
        }
        else
        {
            [cell.outAgency_yes_ImageView setImage:[UIImage imageNamed:@"radio_button_empty"]];
            [cell.outAgency_no_ImageView setImage:[UIImage imageNamed:@"radio_button_filled"] ];
        }
    }
    if ([findReqObj.timely_string length])
    {
        if ([findReqObj.timely_string isEqualToString:@"1"]) {
            [cell.timely_yes_ImageView setImage:[UIImage imageNamed:@"radio_button_filled"]];
            [cell.timely_no_ImageView setImage:[UIImage imageNamed:@"radio_button_empty"]];
        }
        else
        {
            [cell.timely_yes_ImageView setImage:[UIImage imageNamed:@"radio_button_empty"]];
            [cell.timely_no_ImageView setImage:[UIImage imageNamed:@"radio_button_filled"]];
        }
    }
    if ([findReqObj.cancelled_string length])
    {
        if ([findReqObj.cancelled_string isEqualToString:@"1"]) {
            [cell.canceled_yes_ImageView setImage:[UIImage imageNamed:@"radio_button_filled"] ];
            [cell.canceled_no_ImageView setImage:[UIImage imageNamed:@"radio_button_empty"] ];
        }
        else
        {
            [cell.canceled_yes_ImageView setImage:[UIImage imageNamed:@"radio_button_empty"]];
            [cell.canceled_no_ImageView setImage:[UIImage imageNamed:@"radio_button_filled"]];
        }
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISFindRequestJobs_Cell *cell=(GISFindRequestJobs_Cell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section==0) {
        return cell.frame.size.height;
    }
    return 700;
}

-(void)search_ButtonPressed:(id)sender
{
    [self.days_MutableStr setString:@""];
    for (int j=1; j<=7; j++) {
        NSString *str=[findReqObj.weekDays_dictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)j]];
        if ([str isEqualToString:@"Monday"]) {
            [self.days_MutableStr appendFormat:@"%@%@",@"2",@","];        }
        else if ([str isEqualToString:@"Tuesday"]) {
            [self.days_MutableStr appendFormat:@"%@%@",@"3",@","];
        }
        else if ([str isEqualToString:@"Wednesday"]) {
            [self.days_MutableStr appendFormat:@"%@%@",@"4",@","];
        }
        else if ([str isEqualToString:@"Thursday"]) {
            [self.days_MutableStr appendFormat:@"%@%@",@"5",@","];
        }
        else if ([str isEqualToString:@"Friday"]) {
            [self.days_MutableStr appendFormat:@"%@%@",@"6",@","];
        }
        else if ([str isEqualToString:@"Saturday"]) {
            [self.days_MutableStr appendFormat:@"%@%@",@"7",@","];
        }
        else if ([str isEqualToString:@"Sunday"]) {
            [self.days_MutableStr appendFormat:@"%@%@",@"1",@","];
        }
    }
    NSRange range = [self.days_MutableStr rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location == NSNotFound) {
    } else {
        [self.days_MutableStr setString:[self.days_MutableStr substringToIndex:range.location]];
    }
    
    if([findReqObj.registeredConsumers_ID_string length]==0)
        findReqObj.registeredConsumers_ID_string = @"";
    
    [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
    
    [paramsDict setObject:[GISUtility returningstring:findReqObj.startDate_string] forKey:kRequestSDate];
    [paramsDict setObject:[GISUtility returningstring:findReqObj.endDate_string] forKey:kRequestEDate];
    [paramsDict setObject:[GISUtility returningstring:findReqObj.requestorType_ID_string] forKey:kRequestorTypeID];
    [paramsDict setObject:[GISUtility returningstring:@""] forKey:KGetRequestDetails_UnitID];
    [paramsDict setObject:[GISUtility returningstring:findReqObj.requestor_ID_string] forKey:kDateTime_RequestorID];
    [paramsDict setObject:findReqObj.registeredConsumers_ID_string forKey:kConsumerID];
    [paramsDict setObject:[GISUtility returningstring:findReqObj.generalLocation_ID_string] forKey:kSearchRequest_LocationID];
    [paramsDict setObject:[GISUtility returningstring:request_ID_String] forKey:kRequestID];
    [paramsDict setObject:[GISUtility returningstring:findReqObj.evenyType_ID_string] forKey:kChooseReqDetails_EventTypeID];
    [paramsDict setObject:[GISUtility returningstring:findReqObj.primaryAudience_ID_string] forKey:kSearchRequest_PrimaryAudienceid];
    [paramsDict setObject:[GISUtility returningstring:findReqObj.openToPublic_string] forKey:kSearchReq_SP_OpenToPublic];
    [paramsDict setObject:[GISUtility returningstring:findReqObj.startDate_JobData_string] forKey:kJobSDate];
    [paramsDict setObject:[GISUtility returningstring:findReqObj.endDate_JobData_string] forKey:kJobEDate];
    [paramsDict setObject:[GISUtility returningstring:findReqObj.startTime_JobData_string] forKey:kJobSTime];
    [paramsDict setObject:[GISUtility returningstring:findReqObj.endTime_JobData_string] forKey:kJobETime];
    [paramsDict setObject:[GISUtility returningstring:self.days_MutableStr] forKey:kDays];
    [paramsDict setObject:[GISUtility returningstring:findReqObj.serviceProviderType_ID_string] forKey:kSearchReq_SP_SpTypeID];
    [paramsDict setObject:[GISUtility returningstring:@""] forKey:kTypeID];
    [paramsDict setObject:[GISUtility returningstring:findReqObj.serviceProvider_ID_string] forKey:kSPID];
    [paramsDict setObject:[GISUtility returningstring:findReqObj.payType_ID_string] forKey:kViewSchedule_PayTypeID];
    [paramsDict setObject:[GISUtility returningstring:findReqObj.filled_string] forKey:kFilled];
    [paramsDict setObject:[GISUtility returningstring:findReqObj.outAgency_string] forKey:kOutAgency];
    [paramsDict setObject:[GISUtility returningstring:findReqObj.createdBy_string] forKey:kCreatedBy];
    [paramsDict setObject:[GISUtility returningstring:findReqObj.timely_string] forKey:kJobDetais_Timely];
    [paramsDict setObject:[GISUtility returningstring:findReqObj.cancelled_string] forKey:kCanceled];
    [paramsDict setObject:[GISUtility returningstring:findReqObj.cancelDate_string] forKey:kCancelDate];
    [paramsDict setObject:[GISUtility returningstring:findReqObj.payLevel_JobData_ID_string] forKey:kPayLevelID];
    [paramsDict setObject:[GISUtility returningstring:findReqObj.billinglevel_ID_string] forKey:kBillingLevelID];
    [paramsDict setObject:[GISUtility returningstring:[GISUtility returningstring:findReqObj.payLevel_ID_string]] forKey:kRPayLevelID];
    [paramsDict setObject:[GISUtility returningstring:findReqObj.model_ID_string] forKey:kModeID];
    [paramsDict setObject:[GISUtility returningstring:findReqObj.primaryAudience_ID_string] forKey:kPrimaryAudianceID];
    

    [[GISServerManager sharedManager] findRequestJObs_Search:self withParams:paramsDict finishAction:@selector(successmethod_findRequestJobs:) failAction:@selector(failuremethod_findRequestJobs:)];
}

-(void)successmethod_findRequestJobs:(GISJsonRequest *)response
{
    NSLog(@"successmethod_findRequestJobs Success---%@",response.responseJson);
    NSDictionary *saveUpdateDict;
    NSArray *responseArray= response.responseJson;
    saveUpdateDict = [responseArray lastObject];
    GISSchedulerSPJobsStore *spJobsStore;
    NSMutableArray *SPJobsArray=[[NSMutableArray alloc]init];
    
    //if ([[saveUpdateDict objectForKey:kStatusCode] isEqualToString:@"200"])
    {
        
        [[GISStoreManager sharedManager] removeRequestJobs_SPJobsObject];
        spJobsStore=[[GISSchedulerSPJobsStore alloc]initWithJsonDictionary:response.responseJson];
        SPJobsArray=[[GISStoreManager sharedManager] getRequestJobs_SPJobsObject];
        
        [self removeLoadingView];
        ///////////
        appDelegate.isFromViewEditService = NO;
        GISJobAssignmentViewController *detailViewController = (GISJobAssignmentViewController *)[[GISJobAssignmentViewController alloc]initWithNibName:@"GISJobAssignmentViewController" bundle:nil];
        [detailViewController.requested_Jobs_Array removeAllObjects];
        detailViewController.requested_Jobs_Array=SPJobsArray;
        detailViewController.view_string = kFindRequestJobs_Screen;
        self.navigationItem.title = @"Back";
        [self.navigationController pushViewController:detailViewController animated:YES];
        /////////////////
        
    }
   // else
    {
        
        [self removeLoadingView];
        if (responseArray.count<1) {
            [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"no_data",TABLE, nil)];
        }
    }
}

-(void)failuremethod_findRequestJobs:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"Failure");
    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
}


-(IBAction)pickerButtonPressed:(id)sender
{
    UIButton *button=(UIButton *)sender;
    id tempCellRef=(GISFindRequestJobs_Cell *)[GISUtility findParentTableViewCell:button];//button.superview.superview.superview;
    GISFindRequestJobs_Cell *findReqJobsCell=(GISFindRequestJobs_Cell *)tempCellRef;
    
    GISPopOverTableViewController *tableViewController1 = [[GISPopOverTableViewController alloc] initWithNibName:@"GISPopOverTableViewController" bundle:nil];
    tableViewController1.popOverDelegate=self;
    
    if([sender tag]==1111)
    {
        btnTag=1111;
        tableViewController1.view_String=[GISUtility returningstring:requestId_Answer_label.text];
        tableViewController1.popOverArray=chooseRequest_mutArray;
    }
    else if([sender tag]==1)
    {
        btnTag=1;
        if ([findReqObj.startDate_string length])
           tableViewController1.dateTimeMoveUp_string=[GISUtility returningstring:findReqObj.startDate_string];
        tableViewController1.view_String=@"datestimes";
    }
    else if([sender tag]==2)
    {
        btnTag=2;
        tableViewController1.view_String=@"datestimes";
        if ([findReqObj.endDate_string length])
        tableViewController1.dateTimeMoveUp_string=[GISUtility returningstring:findReqObj.endDate_string];
    }
    else if([sender tag]==3)
    {
        btnTag=3;
        tableViewController1.view_String=@"timesdates";
        if ([findReqObj.startTime_string length])
        tableViewController1.dateTimeMoveUp_string=[GISUtility returningstring:findReqObj.startTime_string];
    }
    else if ([sender tag]==4)
    {
        btnTag=4;
        tableViewController1.view_String=@"timesdates";
        if ([findReqObj.endTime_string length])
        tableViewController1.dateTimeMoveUp_string=[GISUtility returningstring:findReqObj.endTime_string];
    }
    else if([sender tag]==5)
    {
        btnTag=5;
        tableViewController1.popOverArray=requestorType_array;
    }
    else if([sender tag]==6)
    {
        btnTag=6;
        tableViewController1.popOverArray=requestor_array;
    }
    else if([sender tag]==7)
    {
        btnTag=7;
        tableViewController1.popOverArray=registeredConsumers_array;
    }
    else if([sender tag]==8)
    {
        btnTag=8;
        tableViewController1.popOverArray=generalLocation_array;
    }
    else if([sender tag]==9)
    {
        btnTag=9;
        tableViewController1.popOverArray=eventType_array;
    }
    else if([sender tag]==10)
    {
        btnTag=10;
        tableViewController1.popOverArray=payLevel_array;
    }
    else if([sender tag]==11)
    {
        btnTag=11;
        tableViewController1.popOverArray=primaryAudience_array;
    }
    else if([sender tag]==12)
    {
        btnTag=12;
        tableViewController1.popOverArray=model_array;
    }
    else if([sender tag]==13)
    {
        btnTag=[sender tag];
        tableViewController1.view_String=@"datestimes";
        if ([findReqObj.startDate_JobData_string length])
        tableViewController1.dateTimeMoveUp_string=[GISUtility returningstring:findReqObj.startDate_JobData_string];
    }
    else if([sender tag]==14)
    {
        btnTag=[sender tag];
        tableViewController1.view_String=@"datestimes";
        if ([findReqObj.endDate_JobData_string length])
        tableViewController1.dateTimeMoveUp_string=[GISUtility returningstring:findReqObj.endDate_JobData_string];
    }
    else if([sender tag]==15)
    {
        btnTag=[sender tag];
        tableViewController1.view_String=@"timesdates";
        if ([findReqObj.startTime_JobData_string length])
        tableViewController1.dateTimeMoveUp_string=[GISUtility returningstring:findReqObj.startTime_JobData_string];
    }
    else if([sender tag]==16)
    {
        btnTag=[sender tag];
        tableViewController1.view_String=@"timesdates";
        if ([findReqObj.endTime_JobData_string length])
        tableViewController1.dateTimeMoveUp_string=[GISUtility returningstring:findReqObj.endTime_JobData_string];
    }
    else if([sender tag]==17)
    {
        btnTag=[sender tag];
        tableViewController1.popOverArray=serviceProviderType_array;
    }
    else if([sender tag]==18)
    {
        btnTag=[sender tag];
        [serviceProvider_array removeAllObjects];
        
        NSString *spCode_statement;
        
        if([findReqObj.serviceProviderType_string length] >0){
            spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO WHERE TYPE = '%@' OR ID = '%@'",findReqObj.serviceProviderType_string,[NSString stringWithFormat:@"%d",0]];
            if ([findReqObj.serviceProviderType_string isEqualToString:@"Any"]) {
                spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO WHERE TYPE = '%@' OR TYPE = '%@' OR ID = '%@'",@"Interpreter",@"Captioner",[NSString stringWithFormat:@"%d",0]];
            }
        }else{
            
            spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO"];
        }
        serviceProvider_array = [[[GISDatabaseManager sharedDataManager] getServiceProviderArray:spCode_statement] mutableCopy];
        tableViewController1.popOverArray=serviceProvider_array;
    }
    else if([sender tag]==19)
    {
        btnTag=[sender tag];
        tableViewController1.popOverArray=payType_array;
    }
    else if([sender tag]==20)
    {
        btnTag=[sender tag];
        //tableViewController1.view_String=@"datestimes";
        tableViewController1.popOverArray=createdBy_mutArray;
    }
    else if([sender tag]==21)
    {
        btnTag=[sender tag];
        tableViewController1.popOverArray=payLevel_array;
    }
    else if([sender tag]==22)
    {
        btnTag=[sender tag];
        tableViewController1.popOverArray=billLevel_array;
    }
    else if([sender tag]==23)
    {
        btnTag=[sender tag];
        tableViewController1.view_String=@"datestimes";
        if ([findReqObj.cancelDate_string length])
            tableViewController1.dateTimeMoveUp_string=[GISUtility returningstring:findReqObj.cancelDate_string];
    }
    popover =[[UIPopoverController alloc] initWithContentViewController:tableViewController1];
    
    popover.delegate = self;
    popover.popoverContentSize = CGSizeMake(340, 210);
    if ([sender tag]==1111)
        [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+button.frame.size.width-14, 120, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    else
        [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+130, button.frame.origin.y+24, 1, 1) inView:findReqJobsCell.contentView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)sendTheSelectedPopOverData:(NSString *)id_str value:(NSString *)value_str
{
    [self performSelector:@selector(dismissPopOverNow) withObject:nil afterDelay:0.3];
    if (btnTag==1111)
    {
        requestId_Answer_label.text=value_str;
        request_ID_String=id_str;
    }
    else if(btnTag==1)
    {
        findReqObj.startDate_string=value_str;
        if ([findReqObj.startDate_string length] && [findReqObj.endDate_string length]){
            if ([GISUtility dateComparision:findReqObj.startDate_string :findReqObj.endDate_string:YES])
            {}
            else
            {
                [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"start Date alert", TABLE, nil)];
                findReqObj.startDate_string=@"";
            }
        }
    }
    else if(btnTag==2)
    {
        findReqObj.endDate_string=value_str;
        if ([findReqObj.startDate_string length] && [findReqObj.endDate_string length]){
            if ([GISUtility dateComparision:findReqObj.startDate_string:findReqObj.endDate_string:NO])
            {}
            else
            {
                [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"end Date alert", TABLE, nil)];
                findReqObj.endDate_string=@"";
            }
        }
        
    }
    else if(btnTag==3)
    {
        findReqObj.startTime_string=value_str;
        if ([findReqObj.startTime_string length]&& [findReqObj.endTime_string length]) {
            if([GISUtility timeComparision:findReqObj.startTime_string :findReqObj.endTime_string]){}
            else
            {
                findReqObj.startTime_string=@"";
                [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"time alert", TABLE, nil)];
            }
        }
    }
    else if(btnTag==4)
    {
        findReqObj.endTime_string=value_str;
        if ([findReqObj.startTime_string length]&& [findReqObj.endTime_string length]) {
            if([GISUtility timeComparision:findReqObj.startTime_string :findReqObj.endTime_string]){}
            else
            {
                findReqObj.endTime_string=@"";
                [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"time alert", TABLE, nil)];
            }
        }
    }
    else if(btnTag==5)
    {
        findReqObj.requestorType_ID_string=id_str;
        findReqObj.requestorType_string=value_str;
    }
    else if(btnTag==6)
    {
        findReqObj.requestor_ID_string=id_str;
        findReqObj.requestor_string=value_str;
    }
    else if(btnTag==7)
    {
        findReqObj.registeredConsumers_ID_string=id_str;
        findReqObj.registeredConsumers_string=value_str;
    }
    else if(btnTag==8)
    {
        findReqObj.generalLocation_string=value_str;
        findReqObj.generalLocation_ID_string=id_str;
    }
    else if(btnTag==9)
    {
        findReqObj.evenyType_string=value_str;
        findReqObj.evenyType_ID_string=id_str;
    }
    else if(btnTag==10)
    {
        findReqObj.payLevel_string=value_str;
        findReqObj.payLevel_ID_string=id_str;
    }
    else if(btnTag==11)
    {
        findReqObj.primaryAudience_string=value_str;
        findReqObj.primaryAudience_ID_string=id_str;
    }
    else if(btnTag==12)
    {
        findReqObj.model_string=value_str;
        findReqObj.model_ID_string=id_str;
    }
    else if(btnTag==13)
    {
        findReqObj.startDate_JobData_string=value_str;
        if ([findReqObj.startDate_JobData_string length] && [findReqObj.endDate_JobData_string length]){
            if ([GISUtility dateComparision:findReqObj.startDate_JobData_string :findReqObj.endDate_JobData_string:YES])
            {}
            else
            {
                [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"start Date alert", TABLE, nil)];
                findReqObj.startDate_JobData_string=@"";
            }
        }
    }
    else if(btnTag==14)
    {
        findReqObj.endDate_JobData_string=value_str;
        if ([findReqObj.startDate_JobData_string length] && [findReqObj.endDate_JobData_string length]){
            if ([GISUtility dateComparision:findReqObj.startDate_JobData_string:findReqObj.endDate_JobData_string:NO])
            {}
            else
            {
                [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"end Date alert", TABLE, nil)];
                findReqObj.endDate_JobData_string=@"";
            }
        }
    }
    else if(btnTag==15)
    {
        findReqObj.startTime_JobData_string=value_str;
        if ([findReqObj.startTime_JobData_string length]&& [findReqObj.endTime_string length]) {
            if([GISUtility timeComparision:findReqObj.startTime_string :findReqObj.endTime_string]){}
            else
            {
                findReqObj.startTime_JobData_string=@"";
                [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"time alert", TABLE, nil)];
            }
        }
    }
    else if(btnTag==16)
    {
        findReqObj.endTime_JobData_string=value_str;
    }
    else if(btnTag==17)
    {
        findReqObj.serviceProviderType_string=value_str;
        findReqObj.serviceProviderType_ID_string=id_str;
    }
    else if(btnTag==18)
    {
        findReqObj.serviceProvider_string=value_str;
        findReqObj.serviceProvider_ID_string=id_str;
        
        if([id_str isEqualToString:@"0"])
            findReqObj.serviceProvider_ID_string = @"";
    }
    else if(btnTag==19)
    {
        findReqObj.payType_string=value_str;
        findReqObj.payType_ID_string=id_str;
    }
    else if(btnTag==20)
    {
        findReqObj.createdBy_string=value_str;
        findReqObj.createdBy_ID_string=value_str;
    }
    else if(btnTag==21)
    {
        findReqObj.payLevel_JobData_string=value_str;
        findReqObj.payLevel_JobData_ID_string=id_str;
    }
    else if(btnTag==22)
    {
        findReqObj.billLevel_string = value_str;
        findReqObj.billinglevel_ID_string = id_str;
    }
    else if(btnTag==23)
    {
        findReqObj.cancelDate_string=value_str;
    }
    [findReqJobs_tableView reloadData];
}

-(void)dismissPopOverNow
{
    [popover dismissPopoverAnimated:YES];
}

-(IBAction)weekDays_ButtonPressed:(id)sender
{
    if ([findReqObj.weekDays_dictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]]){
        [findReqObj.weekDays_dictionary removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
    }
    else{
        if ([sender tag]==1) {
            [findReqObj.weekDays_dictionary setValue:@"Monday" forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
        }
        else if ([sender tag]==2) {
            [findReqObj.weekDays_dictionary setValue:@"Tuesday" forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
        }
        else if ([sender tag]==3) {
            [findReqObj.weekDays_dictionary setValue:@"Wednesday" forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
        }
        else if ([sender tag]==4) {
            [findReqObj.weekDays_dictionary setValue:@"Thursday" forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
        }
        else if ([sender tag]==5) {
            [findReqObj.weekDays_dictionary setValue:@"Friday" forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
        }
        else if ([sender tag]==6) {
            [findReqObj.weekDays_dictionary setValue:@"Saturday" forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
        }
        else if ([sender tag]==7) {
            [findReqObj.weekDays_dictionary setValue:@"Sunday" forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
        }
    }
    [findReqJobs_tableView reloadData];
    NSLog(@"----week Day dict-->%@",[findReqObj.weekDays_dictionary description]);
}

-(IBAction)radioButton_Pressed:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if (button.tag==1 || button.tag==2) {
        if (button.tag==1)
            findReqObj.openToPublic_string=@"1";
        else
            findReqObj.openToPublic_string=@"0";
    }
    else if (button.tag==3 || button.tag==4) {
        if (button.tag==3)
            findReqObj.filled_string=@"1";
        else
            findReqObj.filled_string=@"0";
    }
    else if (button.tag==5 || button.tag==6) {
        if (button.tag==5)
            findReqObj.outAgency_string=@"1";
        else
            findReqObj.outAgency_string=@"0";
    }
    else if (button.tag==7 || button.tag==8) {
        if (button.tag==7)
            findReqObj.timely_string=@"1";
        else
            findReqObj.timely_string=@"0";
    }
    else if (button.tag==9 || button.tag==10) {
        if (button.tag==9)
            findReqObj.cancelled_string=@"1";
        else
            findReqObj.cancelled_string=@"0";
    }
    [findReqJobs_tableView reloadData];
}



-(void)addLoadViewWithLoadingText:(NSString*)title
{
    [[GISLoadingView sharedDataManager] addLoadingAlertView:title];
    
}

-(void)removeLoadingView
{
    [[GISLoadingView sharedDataManager] removeLoadingAlertview];
}


- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    NSLog(@"rightSwipeHandle");
}

- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    NSLog(@"leftSwipeHandle");
}
-(IBAction)clear_ButtonPressed:(id)sender
{
    findReqObj=[[GISFindRequestJobsObject alloc]init];
    findReqObj.weekDays_dictionary=[[NSMutableDictionary alloc]init];
    [findReqJobs_tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
