//
//  GISServiceProviderRequestedJobsViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 14/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISServiceProviderRequestedJobsViewController.h"
#import "GISDatabaseManager.h"
#import "GISUtility.h"
#import "GISJsonRequest.h"
#import "GISStoreManager.h"
#import "GISServerManager.h"
#import "GISJSONProperties.h"
#import "GISConstants.h"
#import "GISFonts.h"
#import "GISLoadingView.h"
#import "GISServiceProviderRequestedJobsResultsViewController.h"

@interface GISServiceProviderRequestedJobsViewController ()

@end


@implementation GISServiceProviderRequestedJobsViewController

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
    self.title=@"Service Provider Requested jobs - Search";
    weekDays_dictionary_here= [[NSMutableDictionary alloc]init];
    
    chooseRequest_mutArray=[[NSMutableArray alloc]init];
    serviceProviderName_mutArray=[[NSMutableArray alloc]init];
    typeOfservice_mutArray=[[NSMutableArray alloc]init];
    eventType_mutArray=[[NSMutableArray alloc]init];
    generalLoaction_mutArray=[[NSMutableArray alloc]init];
    
    NSString *spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO"];
    serviceProviderName_mutArray = [[[GISDatabaseManager sharedDataManager] getServiceProviderArray:spCode_statement] mutableCopy];
    
    noOfAttendees_mutArray=[[NSMutableArray alloc]initWithObjects:@"2-5",@"6-15",@"16-50", @"50+" , nil];
    noOfAttendees_ID_mutArray=[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3", @"4" , nil];
    
    NSString *requetDetails_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SPJOBS_CHOOSE_REQUEST ORDER BY ID DESC;"];
    chooseRequest_mutArray = [[[GISDatabaseManager sharedDataManager] getDropDownArray:requetDetails_statement] mutableCopy];
    
    NSString *eventCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_EVENT_TYPE;"];
    eventType_mutArray = [[[GISDatabaseManager sharedDataManager] getDropDownArray:eventCode_statement] mutableCopy];
    
    NSString *generalLocation_statement = [[NSString alloc]initWithFormat:@"select * from TBL_GENERAL_LOCATION  ORDER BY ID DESC;"];
    generalLoaction_mutArray = [[[GISDatabaseManager sharedDataManager] getDropDownArray:generalLocation_statement] mutableCopy];
    
    NSString *typeOfService_statement = [[NSString alloc]initWithFormat:@"select * from TBL_TYPE_OF_SERVICE  ORDER BY ID DESC;"];
    typeOfservice_mutArray = [[[GISDatabaseManager sharedDataManager] getDropDownArray:typeOfService_statement] mutableCopy];
    
    chooseRequest_ID_answer_label.font=[GISFonts small];
    serviceProvider_answer_label.font=[GISFonts small];
    startDate_answer_label.font=[GISFonts small];
    endDate_answer_label.font=[GISFonts small];
    startTime_answer_label.font=[GISFonts small];
    endTime_answer_label.font=[GISFonts small];
    typeOfService_answer_label.font=[GISFonts small];
    eventType_answer_label.font=[GISFonts small];
    noOfAttendees_answer_label.font=[GISFonts small];
    generalLocation_answer_label.font=[GISFonts small];
    
    chooseRequest_ID_answer_label.textColor=UIColorFromRGB(0x666666);
    serviceProvider_answer_label.textColor=UIColorFromRGB(0x666666);
    startDate_answer_label.textColor=UIColorFromRGB(0x666666);
    endDate_answer_label.textColor=UIColorFromRGB(0x666666);
    startTime_answer_label.textColor=UIColorFromRGB(0x666666);
    endTime_answer_label.textColor=UIColorFromRGB(0x666666);
    typeOfService_answer_label.textColor=UIColorFromRGB(0x666666);
    eventType_answer_label.textColor=UIColorFromRGB(0x666666);
    noOfAttendees_answer_label.textColor=UIColorFromRGB(0x666666);
    generalLocation_answer_label.textColor=UIColorFromRGB(0x666666);
    
    [search_button.layer setCornerRadius:3.0f];
    [[search_button layer] setMasksToBounds:YES];
    search_button.titleLabel.font=[GISFonts larger];
    
    daysArray = [[NSMutableArray alloc] init];
    days_str = [[NSMutableString alloc] init];
    SPJobsArray = [[NSMutableArray alloc] init];
    
    appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication]delegate];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    chooseRequest_ID_answer_label.text =  NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    typeOfService_answer_label.text =  NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    eventType_answer_label.text = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    noOfAttendees_answer_label.text =  NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    generalLocation_answer_label.text =  NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    serviceProvider_answer_label.text =  NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
}

-(IBAction)pickerButton_pressed:(id)sender
{
    
    UIButton *button=(UIButton *)sender;
    
    GISPopOverTableViewController *tableViewController1 = [[GISPopOverTableViewController alloc] initWithNibName:@"GISPopOverTableViewController" bundle:nil];
    tableViewController1.popOverDelegate=self;
    appDelegate.isNoofAttendees = NO;
    
    
    popover =[[UIPopoverController alloc] initWithContentViewController:tableViewController1];
    
    popover.delegate = self;
    popover.popoverContentSize = CGSizeMake(340, 220);
    
    
    if([sender tag]==111)
    {
        btnTag=111;
        
        tableViewController1.view_String=[GISUtility returningstring:chooseRequest_ID_answer_label.text];
        tableViewController1.popOverArray=chooseRequest_mutArray;
    }
    else if([sender tag]==222)
    {
        btnTag=222;
        tableViewController1.popOverArray=serviceProviderName_mutArray;
        tableViewController1.view_String=[GISUtility returningstring:serviceProvider_answer_label.text];
    }
    else if ([sender tag]==333)
    {
        btnTag=333;
        tableViewController1.view_String=@"datestimes";
        tableViewController1.dateTimeMoveUp_string=[GISUtility returningstring:startDate_answer_label.text];
    }
    else if ([sender tag]==444)
    {
        btnTag=444;
        tableViewController1.view_String=@"datestimes";
        tableViewController1.dateTimeMoveUp_string=[GISUtility returningstring:endDate_answer_label.text];
        
    }
    else if ([sender tag]==555)
    {
        btnTag=555;
        tableViewController1.view_String=@"timesdates";
        tableViewController1.dateTimeMoveUp_string=[GISUtility returningstring:startTime_answer_label.text];
        
    }
    else if ([sender tag]==666)//Create Jobs View Buttons
    {
        btnTag=666;
        tableViewController1.view_String=@"timesdates";
        tableViewController1.dateTimeMoveUp_string=[GISUtility returningstring:endTime_answer_label.text];
    }
    else if ([sender tag]==777)//Create Jobs View Buttons
    {
        btnTag=777;
        popover.popoverContentSize = CGSizeMake(340, 150);
         tableViewController1.popOverArray=typeOfservice_mutArray;
        tableViewController1.view_String=[GISUtility returningstring:typeOfService_answer_label.text];
        
    }
    else if ([sender tag]==888)//Create Jobs View Buttons
    {
        btnTag=888;
         tableViewController1.popOverArray=eventType_mutArray;
        tableViewController1.view_String=[GISUtility returningstring:eventType_answer_label.text];
        
    }
    else if ([sender tag]==999)//Create Jobs View Buttons
    {
        btnTag=999;
        popover.popoverContentSize = CGSizeMake(340, 150);
         tableViewController1.popOverArray=noOfAttendees_mutArray;
        tableViewController1.view_String=[GISUtility returningstring:noOfAttendees_answer_label.text];
        tableViewController1.noOfAttendeesIdArray = noOfAttendees_ID_mutArray;
        appDelegate.isNoofAttendees = YES;
        
    }
    else if ([sender tag]==1010)//Create Jobs View Buttons
    {
        btnTag=1010;
         tableViewController1.popOverArray=generalLoaction_mutArray;
        tableViewController1.view_String=[GISUtility returningstring:generalLocation_answer_label.text];
        
    }

    
    [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+131, button.frame.origin.y+24, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)sendTheSelectedPopOverData:(NSString *)id_str value:(NSString *)value_str
{
    [self performSelector:@selector(dismissPopOverNow) withObject:nil afterDelay:0.0];
    if (btnTag==111)
    {
        chooseRequest_ID_answer_label.text=value_str;
        ChooserequestID  = id_str;
        
    }
    else if (btnTag==222)
    {
        serviceProvider_answer_label.text=value_str;
        SPID_str = id_str;
        
    }
    else if (btnTag==333)
    {
        startDate_answer_label.text=value_str;
        startDate_str = value_str;
        if ([startDate_answer_label.text length] && [endDate_answer_label.text length]){
            if ([GISUtility dateComparision:startDate_answer_label.text :endDate_answer_label.text:YES])
            {}
            else
            {
                [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"start Date alert", TABLE, nil)];
                startDate_answer_label.text=@"";
            }
        }
    }
    else if (btnTag==444)
    {
        endDate_answer_label.text=value_str;
        endDate_str = value_str;
        if ([startDate_answer_label.text length] && [endDate_answer_label.text length]){
            if ([GISUtility dateComparision:startDate_answer_label.text :endDate_answer_label.text:NO])
            {}
            else
            {
                [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"end Date alert", TABLE, nil)];
                endDate_answer_label.text=@"";
            }
        }
    }
    else if (btnTag==555)
    {
        startTime_answer_label.text=value_str;
        startTime_str = value_str;
        if ([startTime_answer_label.text length]&& [endTime_answer_label.text length]) {
            if([GISUtility timeComparision:startTime_answer_label.text :endTime_answer_label.text]){}
            else
            {
                startTime_answer_label.text=@"";
                [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"time alert", TABLE, nil)];
            }
        }
    }
    else if (btnTag==666)
    {
        endTime_answer_label.text=value_str;
        endTime_str = value_str;
        if ([endTime_answer_label.text length]&& [endTime_answer_label.text length]) {
            if([GISUtility timeComparision:startTime_answer_label.text :endTime_answer_label.text]){}
            else
            {
                endTime_answer_label.text=@"";
                [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"time alert", TABLE, nil)];
            }
        }
    }
    else if (btnTag==777)
    {
        spType_ID_str = id_str;
        typeOfService_answer_label.text=value_str;
    }
    else if (btnTag==888)
    {
        eventType_ID_str = id_str;
        eventType_answer_label.text=value_str;
        
    }
    else if (btnTag==999)
    {
        noOfExpAttendID_str = id_str;
        noOfAttendees_answer_label.text=value_str;
        
    }
    else if (btnTag==1010)
    {
        locationID_str = id_str;
        generalLocation_answer_label.text=value_str;
    }
}

-(void)dismissPopOverNow
{
    [popover dismissPopoverAnimated:YES];
}

-(IBAction)radioButton_pressed:(id)sender
{
    if ([sender tag]==1 || [sender tag]==2) {
        if ([sender tag]==1) {
            openToPublic_str=@"1";
            [openToPublic_NO_button setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [openToPublic_YES_button setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }
        else
        {
            openToPublic_str=@"0";
            [openToPublic_YES_button setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [openToPublic_NO_button setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }
    }
    
    if ([sender tag]==3 || [sender tag]==4) {
        if ([sender tag]==3) {
            onGoing_str=@"1";
            [onGoing_NO_button setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [onGoing_YES_button setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }
        else
        {
            onGoing_str=@"0";
            [onGoing_YES_button setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [onGoing_NO_button setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }
    }
    
    if ([sender tag]==5 || [sender tag]==6) {
        if ([sender tag]==5) {
            recordBroadCast_str=@"1";
            [recordBroadCast_NO_button setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [recordBroadCast_YES_button setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }
        else
        {
            recordBroadCast_str=@"0";
            [recordBroadCast_YES_button setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [recordBroadCast_NO_button setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }
    }
}

-(IBAction)searchButton_pressed:(id)sender
{
    
    [days_str setString:@""];
    
    for(int i=0; i <[daysArray count];i++){
        //othertechvalueStr = [[otherTechStr objectAtIndex:i] componentsJoinedByString:@","];
        [days_str appendFormat:@"%@%@",[daysArray objectAtIndex:i],@","];
    }
    NSRange range = [days_str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location == NSNotFound) {
        //  [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,maxRange-1)];
    } else {
        [days_str setString:[days_str substringToIndex:range.location]];
    }
    
    if([startTime_str length] == 0  )
    {
        startTime_str = @"";
    }
    if( [endTime_str length] == 0 )
    {
        endTime_str = @"";
    }
    if([startDate_str length] == 0)
    {
        startDate_str = @"";
    }
    if( [endDate_str length] == 0 )
    {
        endDate_str = @"";
    }
    if([days_str length] == 0)
    {
        [days_str setString:@""];
    }
    if( [spType_ID_str length] == 0 ){
        
        spType_ID_str = @"";
    }
    if([SPID_str length] == 0)
    {
        SPID_str = @"";
    }
    if( [noOfExpAttendID_str length] == 0 )
    {
        noOfExpAttendID_str = @"";
    }
    if([eventType_ID_str length] == 0)
    {
        eventType_ID_str = @"";
    }
    if( [locationID_str length] == 0 ){
        
        locationID_str = @"";
    }
    if([recordBroadCast_str length] == 0)
    {
        recordBroadCast_str = @"";
    }
    if( [onGoing_str length] == 0 )
    {
        onGoing_str = @"";
    }
    if([openToPublic_str length] == 0)
    {
        openToPublic_str = @"";
    }
    
    if([ChooserequestID length] == 0)
    {
        ChooserequestID = @"";
    }
    
    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
    [paramsDict setObject:startDate_str forKey:kSPRequetstesJobsSearchJobsDate];
    [paramsDict setObject:endDate_str forKey:kSPRequetstesJobsSearchJobEDate];
    [paramsDict setObject:startTime_str forKey:kSPRequetstesJobsSearchJobSTime];
    [paramsDict setObject:endTime_str forKey:kSPRequetstesJobsSearchJobETime];
    [paramsDict setObject:days_str forKey:kSPRequetstesJobsSearchDays];
    [paramsDict setObject:spType_ID_str forKey:kSPRequetstesJobsSearchSpTypeID];
    [paramsDict setObject:SPID_str forKey:kSPRequetstesJobsSearchSPID];
    [paramsDict setObject:noOfExpAttendID_str forKey:kSPRequetstesJobsSearchnoOfExpAttendID];
    
    [paramsDict setObject:eventType_ID_str forKey:kSPRequetstesJobsSearchEventTypeID];
    [paramsDict setObject:locationID_str forKey:kSPRequetstesJobsSearchLocationID];
    [paramsDict setObject:recordBroadCast_str forKey:kSPRequetstesJobsSearchrecordedOrBoardCast];
    [paramsDict setObject:onGoing_str forKey:kSPRequetstesJobsSearchonGoing];
    [paramsDict setObject:openToPublic_str forKey:kSPRequetstesJobsSearchOpenToPublic];
    [paramsDict setObject:ChooserequestID forKey:kRequestID];
    
    [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
    [[GISServerManager sharedManager] searchSpRequestedJobs:self withParams:paramsDict finishAction:@selector(successmethod_spRequestJobsSearchRequest:) failAction:@selector(failuremethod_spRequestJobsSearchRequest:)];
    
}

-(IBAction)weekDays_ButtonPressed:(id)sender
{
    if ([weekDays_dictionary_here objectForKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]]){
        [weekDays_dictionary_here removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
        if ([sender tag]==2) {
            monday_ImageView.image=[UIImage imageNamed:@"unchecked"];
            [daysArray removeObject:[NSString stringWithFormat:@"%d",[sender tag]]];
        }
        else if ([sender tag]==3) {
            tuesday_ImageView.image=[UIImage imageNamed:@"unchecked"];
            [daysArray removeObject:[NSString stringWithFormat:@"%d",[sender tag]]];
        }
        else if ([sender tag]==4) {
            wednesday_ImageView.image=[UIImage imageNamed:@"unchecked"];
            [daysArray removeObject:[NSString stringWithFormat:@"%d",[sender tag]]];
        }
        else if ([sender tag]==5) {
            thursday_ImageView.image=[UIImage imageNamed:@"unchecked"];
            [daysArray removeObject:[NSString stringWithFormat:@"%d",[sender tag]]];
        }
        else if ([sender tag]==6) {
            friday_ImageView.image=[UIImage imageNamed:@"unchecked"];
            [daysArray removeObject:[NSString stringWithFormat:@"%d",[sender tag]]];
        }
        else if ([sender tag]==7) {
            saturday_ImageView.image=[UIImage imageNamed:@"unchecked"];
            [daysArray removeObject:[NSString stringWithFormat:@"%d",[sender tag]]];
        }
        else if ([sender tag]==1) {
            sunday_ImageView.image=[UIImage imageNamed:@"unchecked"];
            [daysArray removeObject:[NSString stringWithFormat:@"%d",[sender tag]]];
        }
    }
    else{
        //Sunday Start =1
        if ([sender tag]==2) {
            [weekDays_dictionary_here setValue:@"Monday" forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
            monday_ImageView.image=[UIImage imageNamed:@"checked.png"];
            [daysArray addObject:[NSString stringWithFormat:@"%d",[sender tag]]];
        }
        else if ([sender tag]==3) {
            [weekDays_dictionary_here setValue:@"Tuesday" forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
            tuesday_ImageView.image=[UIImage imageNamed:@"checked.png"];
            [daysArray addObject:[NSString stringWithFormat:@"%d",[sender tag]]];
        }
        else if ([sender tag]==4) {
            [weekDays_dictionary_here setValue:@"Wednesday" forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
            wednesday_ImageView.image=[UIImage imageNamed:@"checked.png"];
            [daysArray addObject:[NSString stringWithFormat:@"%d",[sender tag]]];
        }
        else if ([sender tag]==5) {
            [weekDays_dictionary_here setValue:@"Thursday" forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
            thursday_ImageView.image=[UIImage imageNamed:@"checked.png"];
            [daysArray addObject:[NSString stringWithFormat:@"%d",[sender tag]]];
        }
        else if ([sender tag]==6) {
            [weekDays_dictionary_here setValue:@"Friday" forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
            friday_ImageView.image=[UIImage imageNamed:@"checked.png"];
            [daysArray addObject:[NSString stringWithFormat:@"%d",[sender tag]]];
        }
        else if ([sender tag]==7) {
            [weekDays_dictionary_here setValue:@"Saturday" forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
            saturday_ImageView.image=[UIImage imageNamed:@"checked.png"];
            [daysArray addObject:[NSString stringWithFormat:@"%d",[sender tag]]];
        }
        else if ([sender tag]==1) {
            [weekDays_dictionary_here setValue:@"Sunday" forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
            sunday_ImageView.image=[UIImage imageNamed:@"checked.png"];
            [daysArray addObject:[NSString stringWithFormat:@"%d",[sender tag]]];
        }
    }
    
    NSLog(@"----week Day dict-->%@",[weekDays_dictionary_here description]);
}

-(void)addLoadViewWithLoadingText:(NSString*)title
{
    [[GISLoadingView sharedDataManager] addLoadingAlertView:title];
    // _loadingView = [LoadingView loadingViewInView:self.navigationController.view andWithText:title];
}

-(void)removeLoadingView
{
    [[GISLoadingView sharedDataManager] removeLoadingAlertview];
}

-(void)successmethod_spRequestJobsSearchRequest:(GISJsonRequest *)response
{
    NSDictionary *saveUpdateDict;
    NSArray *responseArray= response.responseJson;
    saveUpdateDict = [responseArray lastObject];
    NSLog(@"successmethod_spRequestJobsSearchRequest Success---%@",saveUpdateDict);
    
    if ([[saveUpdateDict objectForKey:kStatusCode] isEqualToString:@"200"]) {
        
        [[GISStoreManager sharedManager] removeRequestJobs_SPJobsObject];
        spJobsStore=[[GISSchedulerSPJobsStore alloc]initWithJsonDictionary:response.responseJson];
        SPJobsArray=[[GISStoreManager sharedManager] getRequestJobs_SPJobsObject];
        
        GISServiceProviderRequestedJobsResultsViewController *serviceProviderRequestedResult =[[GISServiceProviderRequestedJobsResultsViewController alloc]initWithNibName:@"GISServiceProviderRequestedJobsResultsViewController" bundle:nil];
        serviceProviderRequestedResult.SPJobsArray = SPJobsArray;
        [self.navigationController pushViewController:serviceProviderRequestedResult animated:NO];
        
    }else{
        
        
        if (responseArray.count<1) {
            [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"no_data",TABLE, nil)];
        }
    }
    [self removeLoadingView];
}


-(void)failuremethod_spRequestJobsSearchRequest:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"Failure");
     [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
}


- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    NSLog(@"rightSwipeHandle");
}

- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    NSLog(@"leftSwipeHandle");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
