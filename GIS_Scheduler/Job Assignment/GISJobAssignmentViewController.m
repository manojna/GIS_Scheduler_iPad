//
//  GISJobAssignmentViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 22/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISJobAssignmentViewController.h"
#import "GISJobAssignmentCell.h"
#import "GISConstants.h"
#import "GISDatabaseManager.h"
#import "GISUtility.h"
#import "GISJsonRequest.h"
#import "GISStoreManager.h"
#import "GISServerManager.h"
#import "GISJSONProperties.h"
#import "GISConstants.h"
#import "GISFonts.h"
#import "GISLoadingView.h"
#import "GISSchedulerSPJobsObject.h"
#import "GISSchedulerSPJobsStore.h"



@interface GISJobAssignmentViewController ()

@end

@implementation GISJobAssignmentViewController

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
    
    self.navigationItem.hidesBackButton = YES;
    
    appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
    NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
    login_Obj=[requetId_array lastObject];
    
    selected_row=999999;
    ota_dictionary=[[NSMutableDictionary alloc]init];
    chooseRequest_mutArray=[[NSMutableArray alloc]init];
    
    NSString *requetDetails_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SEARCH_CHOOSE_REQUEST ORDER BY ID DESC;"];
    chooseRequest_mutArray = [[[GISDatabaseManager sharedDataManager] getDropDownArray:requetDetails_statement] mutableCopy];
    
    dashBoard_UIView.hidden=YES;

    
    self.title=NSLocalizedStringFromTable(@"Jobs_Assignment", TABLE, nil);
    CGRect frame1=table_UIView.frame;
    frame1.origin.x=0;
    table_UIView.frame=frame1;
    
    serviceProvider_Array=[[NSMutableArray alloc]init];
    serviceProviderType_array=[[NSMutableArray alloc]init];
    payType_array=[[NSMutableArray alloc]init];
    NSString *spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO"];
    serviceProvider_Array = [[[GISDatabaseManager sharedDataManager] getServiceProviderArray:spCode_statement] mutableCopy];
    NSString *typeOfService_statement = [[NSString alloc]initWithFormat:@"select * from TBL_TYPE_OF_SERVICE  ORDER BY ID DESC;"];
    serviceProviderType_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:typeOfService_statement] mutableCopy];
    NSString *payType_statement = [[NSString alloc]initWithFormat:@"select * from TBL_PAY_TYPE"];
    payType_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:payType_statement] mutableCopy];
    
    
    mainArray=[[NSMutableArray alloc]init];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.view_string isEqualToString:kFindRequestJobs_Screen]) {
        segment_UIView.hidden=YES;
        CGRect new_frame=table_UIView.frame;
        new_frame.origin.y=90;
        new_frame.size.height=650;
        table_UIView.frame=new_frame;
        self.title=NSLocalizedStringFromTable(@"Find_Requests_Jobs", TABLE, nil);
    }else{
        
    }
    NSLog(@"----Array is -->%@--count-->%d",[self.requested_Jobs_Array description],self.requested_Jobs_Array.count);
    
    chooseRequest_ID_answer_Label.text = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    typeOfService_answer_Label.text = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    
}

-(void)backButtonPressed
{
    if (table_UIView.frame.origin.x==0) {
        [self performSelector:@selector(hideAndUnHideMaster:) withObject:nil];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)splitViewController: (UISplitViewController*)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    return self.isMasterHide;
}

- (IBAction)hideButtonPressed:(id)sender{
    
    isHide = NO;
    [self performSelector:@selector(hideAndUnHideMaster:) withObject:nil];
    
}

- (IBAction)hideAndUnHideMaster:(id)sender
{
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    UIButton *btn = (UIButton*)sender;
    GISAppDelegate *appDelegate1 = (GISAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.isMasterHide= isHide;
    NSString *buttonTitle = self.isMasterHide ? @""  : @"  "; //@""== Unhide   @"  "==Hide
    if (isHide)
    {
        dashBoard_UIView.hidden=NO;
        CGRect frame1=table_UIView.frame;
        frame1.origin.x=75;
        table_UIView.frame=frame1;
        
        self.navigationItem.hidesBackButton = YES;
        
    }
    else
    {
        dashBoard_UIView.hidden=YES;
        CGRect frame1=table_UIView.frame;
        frame1.origin.x=0;
        table_UIView.frame=frame1;
        
        if ([self.view_string isEqualToString:kFindRequestJobs_Screen])
            self.navigationItem.hidesBackButton = NO;
    }
    
    [btn setTitle:buttonTitle forState:UIControlStateNormal];
    [appDelegate1.spiltViewController.view setNeedsLayout ];
    appDelegate1.spiltViewController.delegate = self;
    
    [appDelegate1.spiltViewController willRotateToInterfaceOrientation:self.interfaceOrientation duration:0];
}

- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    NSLog(@"rightSwipeHandle");
    isHide = NO;
    [self performSelector:@selector(hideAndUnHideMaster:) withObject:nil];
}

- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    NSLog(@"leftSwipeHandle");
    isHide = YES;
    [self performSelector:@selector(hideAndUnHideMaster:) withObject:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.requested_Jobs_Array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISJobAssignmentCell *cell=(GISJobAssignmentCell *)[tableView dequeueReusableCellWithIdentifier:@"AssignmentCell"];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"GISJobAssignmentCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.tag=indexPath.row;

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.tag=indexPath.row;
    
    GISSchedulerSPJobsObject *obj=[self.requested_Jobs_Array objectAtIndex:indexPath.row];
    
    cell.oTA_button.tag=indexPath.row;
    cell.edit_button.tag=indexPath.row;
    [cell.oTA_button addTarget:self action:@selector(OTA_Button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell.edit_button addTarget:self action:@selector(editButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.jobId_label.text=obj.JobNumber_String;
    cell.jobDate_label.text=obj.JobDate_String;
    cell.startTime_label.text=obj.startTime_String;
    cell.endTime_label.text=obj.endTime_String;
    cell.serviceProviderType_label.text=obj.typeOfService_string;
    cell.serviceProvider_label.text=obj.ServiceProviderName_String;
    cell.payType_label.text=obj.PayType_String;
    cell.location_label.text=obj.location_string;
    cell.account_label.text=obj.accountName_string;
    cell.requestor_label.text=obj.requestorName_string;
    
    if([obj.ServiceProviderName_String length] == 0)
        cell.serviceProvider_label.text = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    
    if ([ota_dictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]])
        [cell.oTA_imageView setImage:[UIImage imageNamed:@"checked.png"]];
    else
        [cell.oTA_imageView setImage:[UIImage imageNamed:@"unchecked.png"]];
    
    
    if (selected_row==indexPath.row && isEdit_Button_Clicked)
    {
        cell.serviceProviderType_label.text=typeOfservice_temp_string;
        cell.serviceProvider_label.text=serviceProvider_temp_string;
        cell.payType_label.text=payType_temp_string;
        [cell.edit_button setImage:[UIImage imageNamed:@"check_pressed"] forState:UIControlStateNormal];
    }
    else
    {
        //[cell.edit_button setImage:[UIImage imageNamed:@"edit.png"] forState:UIControlStateNormal];
    }
    
    if ([obj.requestApproved_string isEqualToString:@"0"]) {
        
        cell.payType_button.userInteractionEnabled = NO;
        cell.service_Provider_button.userInteractionEnabled = NO;
        
        [cell.payType_textfield setBackgroundColor:[UIColor lightGrayColor]];
        [cell.service_Provider_textfield setBackgroundColor:[UIColor lightGrayColor]];
    }else{
        
        cell.payType_button.userInteractionEnabled = YES;
        cell.service_Provider_button.userInteractionEnabled = YES;
        
        [cell.payType_textfield setBackgroundColor:[UIColor clearColor]];
        [cell.service_Provider_textfield setBackgroundColor:[UIColor clearColor]];
    }
    [cell.restore_button setTag:indexPath.row];
    [cell.restore_button addTarget:self action:@selector(restoreButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(void)OTA_Button_pressed:(id)sender
{
    if ([ota_dictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]]) {
        [ota_dictionary removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
    }
    else
    {
        [ota_dictionary setObject:[NSString stringWithFormat:@"%ld",(long)[sender tag]] forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
    }
    [jobAssignment_tableView reloadData];

}

-(IBAction)pickerButton_pressed:(id)sender
{
    
    
    UIButton *button=(UIButton *)sender;
    GISPopOverTableViewController *tableViewController1 = [[GISPopOverTableViewController alloc] initWithNibName:@"GISPopOverTableViewController" bundle:nil];
    tableViewController1.popOverDelegate=self;
    GISJobAssignmentCell *cell=(GISJobAssignmentCell *)[GISUtility findParentTableViewCell:button];
    selected_row=cell.tag;
    
    
    popover =[[UIPopoverController alloc] initWithContentViewController:tableViewController1];
    popover.delegate = self;
    popover.popoverContentSize = CGSizeMake(340, 150);
    if([sender tag]==111 || [sender tag]==222 || [sender tag]==333 || [sender tag]==444)
    {
        if([sender tag]==111)
        {
            btnTag=111;
            tableViewController1.view_String=[GISUtility returningstring:chooseRequest_ID_answer_Label.text];
            tableViewController1.popOverArray=chooseRequest_mutArray;
        }
        else if([sender tag]==222)
        {
            btnTag=222;
            tableViewController1.view_String=@"datestimes";
            tableViewController1.dateTimeMoveUp_string=[GISUtility returningstring:from_answer_Label.text];
        }
        else if ([sender tag]==333)
        {
            btnTag=333;
            tableViewController1.view_String=@"datestimes";
            tableViewController1.dateTimeMoveUp_string=[GISUtility returningstring:to_answer_Label.text];
        }
        else if ([sender tag]==444)
        {
            btnTag=444;tableViewController1.popOverArray=serviceProviderType_array;
            
        }
        else if ([sender tag]==555)
        {
            btnTag=555;
            tableViewController1.popOverArray=serviceProvider_Array;
            
        }
        else if ([sender tag]==666)
        {
            btnTag=666;
            tableViewController1.popOverArray=payType_array;
            
        }
        if ([sender tag]==111)
            [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+button.frame.size.width+45, 148, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        else
            [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+button.frame.size.width+45, 185, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
    else
    {
        if (selected_row==999999) {
            
            [GISUtility showAlertWithTitle:@"GIS" andMessage:@"Please click on tick button to view the list"];
            return;
        }
        
        if ([sender tag]==555)
        {
            btnTag=555;
            tableViewController1.popOverArray=serviceProviderType_array;
            
        }
        else if ([sender tag]==777)
        {
            btnTag=777;
            tableViewController1.popOverArray=payType_array;
            
        }
        popover.popoverContentSize = CGSizeMake(340, 250);
        GISJobAssignmentCell *tempCell_JobAssignment=(GISJobAssignmentCell *)[GISUtility findParentTableViewCell:button];//button.superview.superview.superview.superview.superview;
        
        if ([sender tag]==555)
         [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+button.frame.size.width+435, button.frame.origin.x+button.frame.size.width-57, 1, 1) inView:tempCell_JobAssignment.contentView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        else
            [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+button.frame.size.width+680, button.frame.origin.x+button.frame.size.width-57, 1, 1) inView:tempCell_JobAssignment.contentView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}

-(void)sendTheSelectedPopOverData:(NSString *)id_str value:(NSString *)value_str
{
    [self performSelector:@selector(dismissPopOverNow) withObject:nil afterDelay:0.0];
    if (btnTag==111)
    {
        chooseRequest_ID_answer_Label.text=value_str;
        chooseRequestID_str = id_str;
        
    }
    else if (btnTag==222)
    {
        from_answer_Label.text=value_str;
        startDate_str = value_str;
        if ([startDate_str length] && [endDate_str length]){
            if ([GISUtility dateComparision:startDate_str :endDate_str:YES])
            {}
            else
            {
                [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"start Date alert", TABLE, nil)];
                from_answer_Label.text=@"";
                startDate_str=@"";
            }
        }
    }
    else if (btnTag==333)
    {
        to_answer_Label.text=value_str;
        endDate_str = value_str;
        if ([startDate_str length] && [endDate_str length]){
            if ([GISUtility dateComparision:startDate_str :endDate_str:NO])
            { }
            else
            {
                [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"end Date alert", TABLE, nil)];
                to_answer_Label.text=@"";
                endDate_str=@"";
            }
        }
    }
    else  if (btnTag==444)
    {
        typeOfService_answer_Label.text=value_str;
        typeServiceID_str = id_str;
    }
    else  if (btnTag==555)
    {
        typeOfservice_temp_string=value_str;
        GISSchedulerSPJobsObject *obj=[self.requested_Jobs_Array objectAtIndex:selected_row];
        obj.typeOfService_string=typeOfservice_temp_string;
        [self.requested_Jobs_Array replaceObjectAtIndex:selected_row withObject:obj];
        
    }
    else  if (btnTag==777)
    {
        payType_temp_string=value_str;
        GISSchedulerSPJobsObject *obj=[self.requested_Jobs_Array objectAtIndex:selected_row];
        obj.PayType_String=payType_temp_string;
        [self.requested_Jobs_Array replaceObjectAtIndex:selected_row withObject:obj];
    }
    if (btnTag==555||btnTag==777)
       [jobAssignment_tableView reloadData];
}

-(void)dismissPopOverNow
{
    [popover dismissPopoverAnimated:YES];
}

-(IBAction)filterMore_ButtonPressed:(id)sender
{
    UIButton *button=(UIButton *)sender;
    
    GISFilterMoreViewController *tableViewController = [[GISFilterMoreViewController alloc] initWithNibName:@"GISFilterMoreViewController" bundle:nil];
    tableViewController.delegate_filter=self;
    popover =[[UIPopoverController alloc] initWithContentViewController:tableViewController];
    popover.popoverContentSize = CGSizeMake(433, 400);
    [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+68, button.frame.origin.y+88, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];

}



-(IBAction)searchButton_Pressed:(id)sender
{
    
    if([startDate_str length] == 0  )
    {
        startDate_str = @"";
    }
    if( [endDate_str length] == 0 )
    {
        endDate_str = @"";
    }
    if([typeServiceID_str length] == 0)
    {
        typeServiceID_str = @"";
    }
    if([chooseRequestID_str length] == 0)
    {
        chooseRequestID_str = @"";
    }
    
    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
    [paramsDict setObject:startDate_str forKey:kJobAssignmentStartDate];
    [paramsDict setObject:endDate_str forKey:kJobAssignmentEndDate];
    [paramsDict setObject:typeServiceID_str forKey:kJobAssignmentSPSubRole];
    [paramsDict setObject:chooseRequestID_str forKey:kRequestID];
    [paramsDict setObject:@"" forKey:kLoginRequestorID];
    [paramsDict setObject:login_Obj.token_string forKey:keventDetails_token];
    [paramsDict setObject:[GISUtility returningstring:eventType_ID_string] forKey:kViewSchedule_EventType];
    [paramsDict setObject:[GISUtility returningstring:serviceProvider_ID_string] forKey:kServiceProvider];
    [paramsDict setObject:[GISUtility returningstring:registeredConsumers_ID_string] forKey:kRegisteredConsumers];
    [paramsDict setObject:[GISUtility returningstring:unitAccount_ID_string] forKey:kUnitNumber];
    [paramsDict setObject:[GISUtility returningstring:typeOfAct_ID_string] forKey:kAccountType];
    [paramsDict setObject:[GISUtility returningstring:onGoing_ID_string] forKey:kSPRequetstesJobsSearchonGoing];
    [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
    [[GISServerManager sharedManager] jobAssignmentJobs:self withParams:paramsDict finishAction:@selector(successmethod_jobAssignmentRequest:) failAction:@selector(failuremethod_jobAssignmentRequest:)];
    
}

/*
 
    Service Provider if Empty i.e., We are getting like this ServiceProvider = "" -----> Unfilled
    Service Provider if Not Empty ---> filled
 
 */

-(void)successmethod_jobAssignmentRequest:(GISJsonRequest *)response
{
    
    NSDictionary *saveUpdateDict;
    NSArray *responseArray= response.responseJson;
    saveUpdateDict = [responseArray lastObject];
    NSLog(@"successmethod_jobAssignmentRequest Success---%@",saveUpdateDict);
    
    if (responseArray.count<1) {
         [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"no_data",TABLE, nil)];
         [self.requested_Jobs_Array removeAllObjects];
         [mainArray removeAllObjects];
        
    }else {
        
        if([mainArray count]>0)
            [mainArray removeAllObjects];
        
        [[GISStoreManager sharedManager] removeRequestJobs_SPJobsObject];
        GISSchedulerSPJobsStore *spJobsStore;
        spJobsStore=[[GISSchedulerSPJobsStore alloc]initWithJsonDictionary:response.responseJson];
        self.requested_Jobs_Array=[[GISStoreManager sharedManager] getRequestJobs_SPJobsObject];
        [mainArray addObjectsFromArray:self.requested_Jobs_Array];
        [self segmentSelected];
    }
    
    [jobAssignment_tableView reloadData];
    
    [self removeLoadingView];
    
}

-(void)failuremethod_jobAssignmentRequest:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"Failure");
    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
}


-(IBAction)segment_filled_Unfilled_ValueChanged:(id)sender
{
    segment=(UISegmentedControl *)sender;
    [self segmentSelected];
}

-(void)segmentSelected
{
    if (segment.selectedSegmentIndex==0) {
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"filledOrUnfilled_string=%@",@"filled"];
        NSArray *array=[mainArray filteredArrayUsingPredicate:predicate];
        [self.requested_Jobs_Array removeAllObjects];
        self.requested_Jobs_Array=[array mutableCopy];
    }
    else if (segment.selectedSegmentIndex==1) {
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"filledOrUnfilled_string=%@",@"unfilled"];
        NSArray *array=[mainArray filteredArrayUsingPredicate:predicate];
        [self.requested_Jobs_Array removeAllObjects];
        self.requested_Jobs_Array=[array mutableCopy];
    }
    [jobAssignment_tableView reloadData];
    if ((self.requested_Jobs_Array.count<1)) {
        [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"no_data",TABLE, nil)];
    }
}
-(IBAction)listOfServiceProviders_ButtonPressed:(id)sender
{
    UIButton *button=(UIButton *)sender;
    id tempCellRef=(GISJobAssignmentCell *)[GISUtility findParentTableViewCell:button];//button.superview.superview.superview.superview.superview;
    GISJobAssignmentCell *attendeesCell=(GISJobAssignmentCell *)tempCellRef;
    selected_row=attendeesCell.tag;
    GISServiceProviderPopUpViewController *popOverController=[[GISServiceProviderPopUpViewController alloc]initWithNibName:@"GISServiceProviderPopUpViewController" bundle:nil];
    
    popOverController.delegate_list=self;
    
    GISSchedulerSPJobsObject *obj=[self.requested_Jobs_Array objectAtIndex:selected_row];
    
    NSString *spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO WHERE TYPE = '%@' OR ID = '%@'",[GISUtility returningstring:obj.typeOfService_string],[NSString stringWithFormat:@"%d",0]];
    if ([obj.typeOfService_string isEqualToString:@"Any"]||[sender tag]==1919) {
        spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO WHERE TYPE = '%@' OR TYPE = '%@' OR ID = '%@'",@"Interpreter",@"Captioner",[NSString stringWithFormat:@"%d",0]];
    }
    serviceProvider_Array = [[[GISDatabaseManager sharedDataManager] getServiceProviderArray:spCode_statement] mutableCopy];
    popOverController.popOverArray=serviceProvider_Array;

    popover=[[UIPopoverController alloc]initWithContentViewController:popOverController];
    popover.popoverContentSize = CGSizeMake(340, 357);
    if ([sender tag]==1919)
        [popover presentPopoverFromRect:CGRectMake(attendeesCell.service_Provider_button.frame.origin.x+660, attendeesCell.service_Provider_button.frame.origin.y+30, 1, 1) inView:attendeesCell.contentView permittedArrowDirections:(UIPopoverArrowDirectionAny) animated:YES];
    else
        [popover presentPopoverFromRect:CGRectMake(attendeesCell.service_Provider_button.frame.origin.x+640, attendeesCell.service_Provider_button.frame.origin.y+30, 1, 1) inView:attendeesCell.contentView permittedArrowDirections:(UIPopoverArrowDirectionAny) animated:YES];
}


-(void)editButtonPressed:(id)sender
{
    
    GISSchedulerSPJobsObject *obj=[self.requested_Jobs_Array objectAtIndex:[sender tag]];
    selected_row=[sender tag];
    
//    obj.typeOfService_string=typeOfservice_temp_string;
//    obj.ServiceProviderName_String=serviceProvider_temp_string;
//    obj.PayType_String=payType_temp_string;
    [self.requested_Jobs_Array replaceObjectAtIndex:selected_row withObject:obj];
    
    NSString *typeOfService_ID_temp_String=@"";
    NSString *serviceProvider_ID_temp_String=@"";
    NSString *payType_ID_temp_String=@"";
    
    NSPredicate *predicate_typeOfService=[NSPredicate predicateWithFormat:@"value_String=%@",obj.typeOfService_string];
    NSArray *array_typeOfService=[serviceProviderType_array filteredArrayUsingPredicate:predicate_typeOfService];
    if (array_typeOfService.count>0) {
        GISDropDownsObject *obj=[array_typeOfService lastObject];
        typeOfService_ID_temp_String=obj.id_String;
    }
    
    NSPredicate *predicate_serviceProvider=[NSPredicate predicateWithFormat:@"service_Provider_String=%@",obj.ServiceProviderName_String];
    NSArray *array_serviceProvider=[serviceProvider_Array filteredArrayUsingPredicate:predicate_serviceProvider];
    if (array_serviceProvider.count>0) {
        GISServiceProviderObject *obj=[array_serviceProvider lastObject];
        serviceProvider_ID_temp_String=obj.id_String;
        if([obj.id_String isEqualToString:@"0"])
            serviceProvider_ID_temp_String = @"";
    }
    
    NSPredicate *predicate_payType=[NSPredicate predicateWithFormat:@"value_String=%@",obj.PayType_String];
    NSArray *array_payType=[payType_array filteredArrayUsingPredicate:predicate_payType];
    if (array_payType.count>0) {
        GISDropDownsObject *obj=[array_payType lastObject];
        payType_ID_temp_String=obj.id_String;
    }
    
    NSMutableDictionary *update_eventdict;
    update_eventdict=[[NSMutableDictionary alloc]init];
    
    [update_eventdict setObject:obj.JobID_String forKey:kJobDetais_JobID];
    [update_eventdict setObject:obj.startTime_String forKey:kJobDetais_StartTime];
    [update_eventdict setObject:obj.endTime_String forKey:kJobDetais_EndTime];
    [update_eventdict setObject:obj.JobDate_String forKey:kJobDetais_JobDate];
    [update_eventdict setObject:payType_ID_temp_String forKey:kViewSchedule_PayTypeID];
    [update_eventdict setObject:serviceProvider_ID_temp_String forKey:kViewSchedule_ServiceProviderID];
    [update_eventdict setObject:typeOfService_ID_temp_String forKey:kViewSchedule_SubroleID];
    [update_eventdict setObject:login_Obj.requestorID_string forKey:kLoginRequestorID];
    [update_eventdict setObject:@"" forKey:kViewSchedule_JobNotes];
    
    [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
    [[GISServerManager sharedManager] updateJobDetails:self withParams:update_eventdict finishAction:@selector(successmethod_updateJobDetails_data:) failAction:@selector(failuremethod_updateJobDetails_data:)];
}
/*
{
    NSLog(@"tag--%d",[sender tag]);

    if(!isEdit_Button_Clicked)
    {
        isEdit_Button_Clicked=YES;
        selected_row=[sender tag];
        GISSchedulerSPJobsObject *obj=[self.requested_Jobs_Array objectAtIndex:selected_row];

        typeOfservice_temp_string=obj.typeOfService_string;
        serviceProvider_temp_string=obj.ServiceProviderName_String;
        payType_temp_string=obj.PayType_String;
    }
    else if(isEdit_Button_Clicked){
        
        if (selected_row==[sender tag])
        {
            GISSchedulerSPJobsObject *obj=[self.requested_Jobs_Array objectAtIndex:selected_row];
            
            obj.typeOfService_string=typeOfservice_temp_string;
            obj.ServiceProviderName_String=serviceProvider_temp_string;
            obj.PayType_String=payType_temp_string;
            [self.requested_Jobs_Array replaceObjectAtIndex:selected_row withObject:obj];
            //Call the Save Update JObs Service here
            
            NSString *typeOfService_ID_temp_String=@"";
            NSString *serviceProvider_ID_temp_String=@"";
            NSString *payType_ID_temp_String=@"";
            
            NSPredicate *predicate_typeOfService=[NSPredicate predicateWithFormat:@"value_String=%@",obj.typeOfService_string];
            NSArray *array_typeOfService=[serviceProviderType_array filteredArrayUsingPredicate:predicate_typeOfService];
            if (array_typeOfService.count>0) {
                GISDropDownsObject *obj=[array_typeOfService lastObject];
                typeOfService_ID_temp_String=obj.id_String;
            }
            
            NSPredicate *predicate_serviceProvider=[NSPredicate predicateWithFormat:@"service_Provider_String=%@",obj.ServiceProviderName_String];
            NSArray *array_serviceProvider=[serviceProvider_Array filteredArrayUsingPredicate:predicate_serviceProvider];
            if (array_serviceProvider.count>0) {
                GISServiceProviderObject *obj=[array_serviceProvider lastObject];
                serviceProvider_ID_temp_String=obj.id_String;
            }
            
            NSPredicate *predicate_payType=[NSPredicate predicateWithFormat:@"value_String=%@",obj.PayType_String];
            NSArray *array_payType=[payType_array filteredArrayUsingPredicate:predicate_payType];
            if (array_payType.count>0) {
                GISDropDownsObject *obj=[array_payType lastObject];
                payType_ID_temp_String=obj.id_String;
            }
            
            NSMutableDictionary *update_eventdict;
            update_eventdict=[[NSMutableDictionary alloc]init];
            
            [update_eventdict setObject:obj.JobID_String forKey:kJobDetais_JobID];
            [update_eventdict setObject:obj.startTime_String forKey:kJobDetais_StartTime];
            [update_eventdict setObject:obj.endTime_String forKey:kJobDetais_EndTime];
            [update_eventdict setObject:obj.JobDate_String forKey:kJobDetais_JobDate];
            [update_eventdict setObject:payType_ID_temp_String forKey:kViewSchedule_PayTypeID];
            [update_eventdict setObject:serviceProvider_ID_temp_String forKey:kViewSchedule_ServiceProviderID];
            [update_eventdict setObject:typeOfService_ID_temp_String forKey:kViewSchedule_SubroleID];
            [update_eventdict setObject:login_Obj.requestorID_string forKey:kLoginRequestorID];
            [update_eventdict setObject:@"" forKey:kViewSchedule_JobNotes];
            
            [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
            [[GISServerManager sharedManager] updateJobDetails:self withParams:update_eventdict finishAction:@selector(successmethod_updateJobDetails_data:) failAction:@selector(failuremethod_updateJobDetails_data:)];
            selected_row=999999;
            isEdit_Button_Clicked=NO;
        }
        else
        {
            isEdit_Button_Clicked=YES;
            selected_row=[sender tag];
            GISSchedulerSPJobsObject *obj=[self.requested_Jobs_Array objectAtIndex:selected_row];
            
            typeOfservice_temp_string=obj.typeOfService_string;
            serviceProvider_temp_string=obj.ServiceProviderName_String;
            payType_temp_string=obj.PayType_String;
        }
    }
    [jobAssignment_tableView reloadData];
*/


-(void)successmethod_updateJobDetails_data:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"successmethod_updateScheduledata Success---%@",response.responseJson);
    NSArray *array=response.responseJson;
    NSDictionary *dictNew=[array lastObject];
    NSString *success= [NSString stringWithFormat:@"%@",[dictNew objectForKey:kStatusCode]];
    
    if ([success isEqualToString:@"200"]) {
        [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"updated_successfully", TABLE, nil)];
    }
    else{
        [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
    }
    
}
-(void)failuremethod_updateJobDetails_data:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"Failure");
    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
}
-(void)sendFilterMoreValues:(NSMutableDictionary *)dict
{
    [self dismissPopOverNow];
    NSLog(@"sendFilterMoreValues-->%@",[dict description]);
    
    if (dict.count) {
        eventType_ID_string=[dict objectForKey:@"1"];
        serviceProvider_ID_string=[dict objectForKey:@"2"];
        registeredConsumers_ID_string=[dict objectForKey:@"3"];
        unitAccount_ID_string=[dict objectForKey:@"4"];
        typeOfAct_ID_string=[dict objectForKey:@"5"];
        onGoing_ID_string=[dict objectForKey:@"6"];
        [self performSelector:@selector(searchButton_Pressed:) withObject:nil];
    }
}

//This method call when we select the service provider from the table view
-(void)sendServiceProviderName:(NSString *)name_str :(NSString *)id_str
{
    [self performSelector:@selector(dismissPopOverNow) withObject:nil afterDelay:0.0];
    serviceProvider_temp_string=name_str;
    GISSchedulerSPJobsObject *obj=[self.requested_Jobs_Array objectAtIndex:selected_row];
    obj.ServiceProviderName_String=serviceProvider_temp_string;
    [self.requested_Jobs_Array replaceObjectAtIndex:selected_row withObject:obj];
    [jobAssignment_tableView reloadData];
    
}

-(IBAction)restoreButtonPressed:(id)sender{
    
    NSString *requestValuestr;
    
    GISSchedulerSPJobsObject *obj=[self.requested_Jobs_Array objectAtIndex:[sender tag]];
    
    NSRange range = [obj.JobNumber_String rangeOfString:@"-" options:NSBackwardsSearch];
    if (range.location == NSNotFound) {
        
    } else {
        requestValuestr = [obj.JobNumber_String substringToIndex:range.location];
    }
    
    appDelegate.chooseRequest_Value_String = requestValuestr;
    appDelegate.isShowfromDashboard = YES;
    appDelegate.isShowfromSPRequestedJobs = YES;
    [self performSelector:@selector(hideShowDashboard) withObject:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:kRowSelected object:nil userInfo:nil];
}

-(void)hideShowDashboard
{
    self.isMasterHide = YES;
    [self performSelector:@selector(hideAndUnHideMaster:) withObject:nil];
}
-(void)addLoadViewWithLoadingText:(NSString*)title
{
    [[GISLoadingView sharedDataManager] addLoadingAlertView:title];
}
-(void)removeLoadingView
{
    [[GISLoadingView sharedDataManager] removeLoadingAlertview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
