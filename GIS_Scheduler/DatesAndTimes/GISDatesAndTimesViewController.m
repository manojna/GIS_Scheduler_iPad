//
//  GISDatesAndTimesViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 15/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISDatesAndTimesViewController.h"
#import "GISDatesTimesDetailCell.h"

#import "GISFonts.h"
#import "GISConstants.h"
#import "GISUtility.h"
#import "GISDatesAndTimesObject.h"
#import "PCLogger.h"
#import "GISLoadingView.h"
#import "GISJsonRequest.h"
#import "GISJSONProperties.h"
#import "GISServerManager.h"
#import "GISDatabaseManager.h"
#import "GISStoreManager.h"
#import "GISDatesTimesDetailStore.h"
#import "GISCreateJobs_Cell.h"


@interface GISDatesAndTimesViewController ()

@end

@implementation GISDatesAndTimesViewController

@synthesize createDateTimes_mutArray,detail_mut_array;

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
    
    createDatesTimes_Label.font=[GISFonts large];
    createDatesTimes_Label.textColor=UIColorFromRGB(0x00457c);
    
    viewEditDatesTimes_Label.font=[GISFonts large];
    viewEditDatesTimes_Label.textColor=UIColorFromRGB(0x00457c);
    
    editALL_Label.font=[GISFonts small];
    editALL_Label.textColor=UIColorFromRGB(0x00457c);
    
    dateLabel.font=[GISFonts small];
    dayLabel.font=[GISFonts small];
    startTime_Header_Label.font=[GISFonts small];
    endTime_header_Label.font=[GISFonts small];
    
    dateLabel.textColor=UIColorFromRGB(0x00457c);
    dayLabel.textColor=UIColorFromRGB(0x00457c);
    startTime_Header_Label.textColor=UIColorFromRGB(0x00457c);
    endTime_header_Label.textColor=UIColorFromRGB(0x00457c);
    
    startTime_Label .font=[GISFonts normal];
    startTime_TextField.font=[GISFonts small];
    startTime_Label.textColor=UIColorFromRGB(0x666666);
    startTime_TextField.textColor=UIColorFromRGB(0x666666);
    
    endTime_Label .font=[GISFonts normal];
    endTime_TextField.font=[GISFonts small];
    endTime_Label.textColor=UIColorFromRGB(0x666666);
    endTime_TextField.textColor=UIColorFromRGB(0x666666);
    
    startDate_Label .font=[GISFonts normal];
    startDate_TextField.font=[GISFonts small];
    startDate_Label.textColor=UIColorFromRGB(0x666666);
    startDate_TextField.textColor=UIColorFromRGB(0x666666);
    
    endDate_Label .font=[GISFonts normal];
    endDate_TextField.font=[GISFonts small];
    endDate_Label.textColor=UIColorFromRGB(0x666666);
    endDate_TextField.textColor=UIColorFromRGB(0x666666);
    
    weekDays_Label .font=[GISFonts normal];
    weekDays_Label.textColor=UIColorFromRGB(0x666666);
    
    monday_Label.font=[GISFonts small];
    tuesday_Label.font=[GISFonts small];
    wednesday_Label.font=[GISFonts small];
    thursday_Label.font=[GISFonts small];
    friday_Label.font=[GISFonts small];
    saturday_Label.font=[GISFonts small];
    sunday_Label.font=[GISFonts small];
    monday_Label.textColor=UIColorFromRGB(0x666666);
    tuesday_Label.textColor=UIColorFromRGB(0x666666);
    wednesday_Label.textColor=UIColorFromRGB(0x666666);
    thursday_Label.textColor=UIColorFromRGB(0x666666);
    friday_Label.textColor=UIColorFromRGB(0x666666);
    saturday_Label.textColor=UIColorFromRGB(0x666666);
    sunday_Label.textColor=UIColorFromRGB(0x666666);
    
    //create_DateTime_Button.backgroundColor=UIColorFromRGB(0x00457c);
    //[create_DateTime_Button setTitleColor:UIColorFromRGB(0xe8d4a2) forState:UIControlStateNormal];
    create_DateTime_Button.titleLabel.font=[GISFonts larger];
    [create_DateTime_Button.layer setCornerRadius:3.0f];
    
    
    create_Jobs_Button.titleLabel.font=[GISFonts larger];
    [create_Jobs_Button.layer setCornerRadius:3.0f];
    
    next_Button.backgroundColor=UIColorFromRGB(0x00457c);
    [next_Button setTitleColor:UIColorFromRGB(0xe8d4a2) forState:UIControlStateNormal];
    next_Button.titleLabel.font=[GISFonts larger];
    [next_Button.layer setCornerRadius:3.0f];
    
    //Localized strings
    createDatesTimes_Label.text=NSLocalizedStringFromTable(@"create_dates_times", TABLE, nil);
    viewEditDatesTimes_Label.text=NSLocalizedStringFromTable(@"view_edit_dates_times", TABLE, nil);
    editALL_Label.text=NSLocalizedStringFromTable(@"", TABLE, nil);
    dateLabel.text=NSLocalizedStringFromTable(@"date", TABLE, nil);
    dayLabel.text=NSLocalizedStringFromTable(@"day", TABLE, nil);
    startTime_Header_Label.text=NSLocalizedStringFromTable(@"startTime", TABLE, nil);
    endTime_header_Label.text=NSLocalizedStringFromTable(@"endTime", TABLE, nil);
    startTime_Label.text=NSLocalizedStringFromTable(@"start_time_", TABLE, nil);
    endTime_Label.text=NSLocalizedStringFromTable(@"end_time_", TABLE, nil);
    startDate_Label.text=NSLocalizedStringFromTable(@"start_date_", TABLE, nil);
    endDate_Label.text=NSLocalizedStringFromTable(@"end_date_", TABLE, nil);
    weekDays_Label.text=NSLocalizedStringFromTable(@"weekDays", TABLE, nil);
    monday_Label.text=NSLocalizedStringFromTable(@"monday", TABLE, nil);
    tuesday_Label.text=NSLocalizedStringFromTable(@"tuesday", TABLE, nil);
    wednesday_Label.text=NSLocalizedStringFromTable(@"wednesday", TABLE, nil);
    thursday_Label.text=NSLocalizedStringFromTable(@"thursday", TABLE, nil);
    friday_Label.text=NSLocalizedStringFromTable(@"friday", TABLE, nil);
    saturday_Label.text=NSLocalizedStringFromTable(@"saturday", TABLE, nil);
    sunday_Label.text=NSLocalizedStringFromTable(@"sunday", TABLE, nil);
    [create_DateTime_Button setTitle:NSLocalizedStringFromTable(@"create_dates_times_Btn", TABLE, nil) forState:UIControlStateNormal];
    [create_Jobs_Button setTitle:NSLocalizedStringFromTable(@"create_jobs_btn", TABLE, nil) forState:UIControlStateNormal];
    [next_Button setTitle:NSLocalizedStringFromTable(@"next", TABLE, nil) forState:UIControlStateNormal];
    
    [create_DateTime_Button setBackgroundColor:UIColorFromRGB(0x00457c)];
    [create_Jobs_Button setBackgroundColor:UIColorFromRGB(0x00457c)];
    [create_DateTime_Button setTitleColor:UIColorFromRGB(0xe8d4a2) forState:UIControlStateNormal];
    [create_Jobs_Button setTitleColor:UIColorFromRGB(0xe8d4a2) forState:UIControlStateNormal];
    ////
    
    weekDays_dictionary_here= [[NSMutableDictionary alloc]init];
    createDateTimes_mutArray=[[NSMutableArray alloc]init];
    
    dateformatter=[[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"MM/dd/yyyy"];
    timeformatter=[[NSDateFormatter alloc]init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [timeformatter setLocale:locale];
    [timeformatter setDateFormat:@"hh:mm a"];
    
    NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
    NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
    login_Obj=[requetId_array lastObject];
    
    selected_row=999999;
    tableViewController = [[GISPopOverTableViewController alloc] initWithNibName:@"GISPopOverTableViewController" bundle:nil];
    tableViewController.popOverDelegate=self;
    isUpdated = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    if(appDelegate.isNewRequest){
        create_Jobs_Button.hidden = YES;
    }
    
    createJobs_UIVIew.hidden=YES;
    createJobs=[[GISCreateJobsViewController alloc]initWithNibName:@"GISCreateJobsViewController" bundle:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectedChooseRequestNumber:) name:kselectedChooseReqNumber object:nil];
    
    [self.cancelBtn_createJobs addTarget:self action:@selector(cancelButtonPressed_CreateJobs:) forControlEvents:UIControlEventTouchUpInside];
        [self.doneBtn_createJobs addTarget:self action:@selector(doneButtonPressed_CreateJobs:) forControlEvents:UIControlEventTouchUpInside];
    
    if([appDelegate.chooseRequest_ID_String length] > 0 && ![appDelegate.chooseRequest_ID_String isEqualToString:@"0"]){
       
        NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
        [paramsDict setObject:[GISUtility returningstring:appDelegate.chooseRequest_ID_String] forKey:kID];
        [paramsDict setObject:login_Obj.token_string forKey:kToken];
        if (![appDelegate.chooseRequest_ID_String isEqualToString:@"-- Select --"])
        {
            [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
            [[GISServerManager sharedManager] getDateTimeDetails:self withParams:paramsDict finishAction:@selector(successmethod_get_Date_Time:) failAction:@selector(failuremethod_get_Date_Time:)];
        }
    }
    typeOfServiceProvider_Array=[[NSMutableArray alloc]init];
    payLevel_Array=[[NSMutableArray alloc]init];
    billLevel_Array=[[NSMutableArray alloc]init];
    payLevel_Array=[[GISStoreManager sharedManager]getPayLevelObjects];
    billLevel_Array=[[GISStoreManager sharedManager]getBillLevelObjects];
    NSString *typeOfService_statement = [[NSString alloc]initWithFormat:@"select * from TBL_TYPE_OF_SERVICE  ORDER BY ID DESC;"];
    typeOfServiceProvider_Array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:typeOfService_statement] mutableCopy];
    
    [self clearDateTimes_Data];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return detail_mut_array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
    GISDatesTimesDetailCell *cell=(GISDatesTimesDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"datesTimesDetailCell"];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"GISDatesTimesDetailCell" owner:self options:nil] objectAtIndex:0];
    }
    
    GISDatesAndTimesObject *detailObj;
    @try {
        if([detail_mut_array count] >0)
            detailObj=[detail_mut_array objectAtIndex:indexPath.row];
    }
    @catch (NSException *exception) {
        [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in DatesAndTimesDetailView CellForRowAtIndexPath %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
    }
    
    cell.dateLabel.text=detailObj.date_String;
    cell.dayLabel.text=detailObj.day_String;
    cell.startTime_Label.text=detailObj.startTime_String;
    cell.endTimeLabel.text=detailObj.endTime_String;
    
    cell.date_TextField.text=detailObj.date_String;
    cell.startTime_TextField.text=detailObj.startTime_String;
    cell.endTime_TextField.text=detailObj.endTime_String;
    
    cell.editButton.tag=indexPath.row;
    cell.deleteButton.tag=indexPath.row;
    
    cell.date_edit_button_detailView.tag=indexPath.row;
    cell.startTime_edit_button_detailView.tag=indexPath.row;
    cell.endTime_edit_button_detailView.tag=indexPath.row;
    cell.save_button_detailView.tag=indexPath.row;
    cell.cancel_button_detailView.tag=indexPath.row;
    
    [cell.editButton addTarget:self action:@selector(editButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deleteButton addTarget:self action:@selector(deleteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.date_edit_button_detailView addTarget:self action:@selector(dateButton_Edit_Pressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell.startTime_edit_button_detailView addTarget:self action:@selector(startTimeButton_Edit_Pressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell.endTime_edit_button_detailView addTarget:self action:@selector(endTimeButton_Edit_Pressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell.save_button_detailView addTarget:self action:@selector(saveButton_Edit_Pressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell.cancel_button_detailView addTarget:self action:@selector(cancelButton_Edit_Pressed:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    if (selected_row==indexPath.row) {
        cell.date_UIview.hidden=NO;
        cell.startTime_UIview.hidden=NO;
        cell.endTime_UIview.hidden=NO;
        cell.saveCancel_UIview.hidden=NO;
        
        cell.date_TextField.text=date_temp_string;
        cell.startTime_TextField.text=startTime_temp_string;
        cell.endTime_TextField.text=endTime_temp_string;
        cell.dayLabel.text=day_temp_string;
    }
    else
    {
        cell.date_UIview.hidden=YES;
        cell.startTime_UIview.hidden=YES;
        cell.endTime_UIview.hidden=YES;
        cell.saveCancel_UIview.hidden=YES;
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(IBAction)pickerButtonPressed:(id)sender
{
    [noOfServiceProviders_TextField resignFirstResponder];
    UIButton *button=(UIButton *)sender;
    
    GISPopOverTableViewController *tableViewController1 = [[GISPopOverTableViewController alloc] initWithNibName:@"GISPopOverTableViewController" bundle:nil];
    tableViewController1.popOverDelegate=self;
    
   [self performSelector:@selector(cancelButton_Edit_Pressed:) withObject:nil];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    
    if([sender tag]==111)
    {
        btnTag=111;
        tableViewController1.view_String=@"datestimes";
        tableViewController1.dateTimeMoveUp_string=startDate_TextField.text;
        if (![startDate_TextField.text length]) {
            tableViewController1.dateTimeMoveUp_string=[formatter stringFromDate:[NSDate date]];
        }
    }
    else if ([sender tag]==222)
    {
        btnTag=222;
        tableViewController1.view_String=@"datestimes";
        tableViewController1.dateTimeMoveUp_string=endDate_TextField.text;
        if (![endDate_TextField.text length]) {
            tableViewController1.dateTimeMoveUp_string=[formatter stringFromDate:[NSDate date]];
        }
    }
    else if ([sender tag]==333)
    {
        btnTag=333;
        tableViewController1.view_String=@"timesdates";
        tableViewController1.dateTimeMoveUp_string=startTime_TextField.text;
        [formatter setDateFormat:@"hh:mm a"];
        if (![startTime_TextField.text length]) {
            tableViewController1.dateTimeMoveUp_string=[formatter stringFromDate:[NSDate date]];
        }
    }
    else if ([sender tag]==444)
    {
        btnTag=444;
        tableViewController1.view_String=@"timesdates";
        tableViewController1.dateTimeMoveUp_string=endTime_TextField.text;
        [formatter setDateFormat:@"hh:mm a"];
        if (![endTime_TextField.text length]) {
            tableViewController1.dateTimeMoveUp_string=[formatter stringFromDate:[NSDate date]];
        }
    }
    else if ([sender tag]==888)//Create Jobs View Buttons
    {
        btnTag=888;
        tableViewController1.view_String=@"datestimes";
        tableViewController1.dateTimeMoveUp_string=endDate_TextField.text;
    }
    else if ([sender tag]==999)//Create Jobs View Buttons
    {
        btnTag=999;
        tableViewController1.view_String=@"timesdates";
        tableViewController1.dateTimeMoveUp_string=startTime_TextField.text;
        
    }
    else if ([sender tag]==1010)//Create Jobs View Buttons
    {
        btnTag=1010;
        tableViewController1.view_String=@"timesdates";
        tableViewController1.dateTimeMoveUp_string=endTime_TextField.text;
        
    }
    else if ([sender tag]==1111)// Create Jobs
    {
        btnTag=1111;
        tableViewController1.popOverArray=typeOfServiceProvider_Array;
    }
    else if ([sender tag]==1212) // Create Jobs
    {
        btnTag=1212;
        tableViewController1.popOverArray=payLevel_Array;
        
    }
    else if ([sender tag]==1313) // Create Jobs
    {
        btnTag=1313;
        tableViewController1.popOverArray=billLevel_Array;
        
    }
    popover =[[UIPopoverController alloc] initWithContentViewController:tableViewController1];
    
    popover.delegate = self;
    popover.popoverContentSize = CGSizeMake(340, 150);
    if([sender tag]==1111 || [sender tag]==1212 || [sender tag]==1313)
        [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+306, button.frame.origin.y+30, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    else if([sender tag]==888 || [sender tag]==999 || [sender tag]==1010)
        [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+306, button.frame.origin.y+30, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
    else
        [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+131, button.frame.origin.y+24, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

-(void)sendTheSelectedPopOverData:(NSString *)id_str value:(NSString *)value_str
{
    [self performSelector:@selector(dismissPopOverNow) withObject:nil afterDelay:1.0];
    if (btnTag==111)
    {
        startDate_TextField.text=value_str;
        if ([startDate_TextField.text length] && [endDate_TextField.text length]){
            if ([GISUtility dateComparision:startDate_TextField.text :endDate_TextField.text :YES])
            {}
            else
            {
                [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"start Date alert", TABLE, nil)];
                startDate_TextField.text=@"";
            }
        }
    }
    else if (btnTag==222)
    {
        endDate_TextField.text=value_str;
        if ([startDate_TextField.text length] && [endDate_TextField.text length]){
            if ([GISUtility dateComparision:startDate_TextField.text :endDate_TextField.text :NO])
            { }
            else
            {
                [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"end Date alert", TABLE, nil)];
                endDate_TextField.text=@"";
            }
        }
    }
    else if (btnTag==333)
    {
        startTime_TextField.text=value_str;
        if ([startTime_TextField.text length]&& [endTime_TextField.text length]) {
            if([GISUtility timeComparision:startTime_TextField.text :endTime_TextField.text]){}
            else
            {
                startTime_TextField.text=@"";
                [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"time alert", TABLE, nil)];
            }
        }
    }
    else if (btnTag==444)
    {
        endTime_TextField.text=value_str;
        if ([startTime_TextField.text length]&& [endTime_TextField.text length]) {
            if([GISUtility timeComparision:startTime_TextField.text :endTime_TextField.text]){}
            else
            {
                endTime_TextField.text=@"";
                [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"time alert", TABLE, nil)];
            }
        }
    }
    else if (btnTag==555 || btnTag==666 || btnTag==777)
    {
        if (btnTag==555)
        {
            date_temp_string=value_str;
            
            NSDateFormatter  *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM/dd/yyyy"];
            NSString *strVisitDate = [NSString stringWithFormat:@"%@", date_temp_string];
            NSDate *visitDate = [dateFormatter dateFromString:strVisitDate];
            strVisitDate = [dateFormatter stringFromDate:visitDate];
            //Here you can set any date Format as per your need
            [dateFormatter setDateFormat:@"EEEE"];
            strVisitDate = [dateFormatter stringFromDate:visitDate];
            day_temp_string=strVisitDate;
            [datesTimes_tableView reloadData];
            if ([startDate_TextField.text length] && [endDate_TextField.text length]){
                if ([GISUtility dateComparision:startDate_TextField.text :endDate_TextField.text:NO])
                {}
                else
                {
                    [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"end Date alert", TABLE, nil)];
                    endDate_TextField.text=@"";
                }
            }
        }
        else if (btnTag==666)
        {
            startTime_temp_string=value_str;
            if ([startTime_temp_string length] && [endTime_temp_string length]) {
                if([GISUtility timeComparision:startTime_temp_string :endTime_temp_string]){}
                else
                {
                    startTime_temp_string=@"";
                    [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"start Time alert", TABLE, nil)];
                }
            }
        }
        else if (btnTag==777)
        {
            endTime_temp_string=value_str;
            if ([startTime_temp_string length]&& [endTime_temp_string length]) {
                if([GISUtility timeComparision:startTime_temp_string :endTime_temp_string]){}
                else
                {
                    endTime_temp_string=@"";
                    [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"end Time alert", TABLE, nil)];
                }
            }
        }
        [datesTimes_tableView reloadData];
    }
    if (btnTag==888)
    {
        typeOfServiceProvidersLabel.text=value_str;
    }
    else if (btnTag==999)
    {
        payLevel_Label.text=value_str;
        
    }
    else if (btnTag==1010)
    {
        billLevel_Label.text=value_str;
    }
    else if (btnTag==1111)// Create Jobs
    {
        typeOfServiceProviders_Answer_Label.text=value_str;
    }
    else if (btnTag==1212) // Create Jobs
    {
        payLevel_Answer_Label.text=value_str;
    }
    else if (btnTag==1313) // Create Jobs
    {
        billLevel_Answer_Label.text=value_str;
    }
}

-(void)dismissPopOverNow
{
    [popover dismissPopoverAnimated:YES];
}

-(IBAction)weekDays_ButtonPressed:(id)sender
{
    if ([weekDays_dictionary_here objectForKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]]){
        [weekDays_dictionary_here removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
        if ([sender tag]==1) {
            monday_ImageView.image=[UIImage imageNamed:@"unchecked"];
        }
        else if ([sender tag]==2) {
            tuesday_ImageView.image=[UIImage imageNamed:@"unchecked"];
        }
        else if ([sender tag]==3) {
            wednesday_ImageView.image=[UIImage imageNamed:@"unchecked"];
        }
        else if ([sender tag]==4) {
            thursday_ImageView.image=[UIImage imageNamed:@"unchecked"];
        }
        else if ([sender tag]==5) {
            friday_ImageView.image=[UIImage imageNamed:@"unchecked"];
        }
        else if ([sender tag]==6) {
            saturday_ImageView.image=[UIImage imageNamed:@"unchecked"];
        }
        else if ([sender tag]==7) {
            sunday_ImageView.image=[UIImage imageNamed:@"unchecked"];
        }
    }
    else{
        if ([sender tag]==1) {
            [weekDays_dictionary_here setValue:@"Monday" forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
            monday_ImageView.image=[UIImage imageNamed:@"checked.png"];
        }
        else if ([sender tag]==2) {
            [weekDays_dictionary_here setValue:@"Tuesday" forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
            tuesday_ImageView.image=[UIImage imageNamed:@"checked.png"];
        }
        else if ([sender tag]==3) {
            [weekDays_dictionary_here setValue:@"Wednesday" forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
            wednesday_ImageView.image=[UIImage imageNamed:@"checked.png"];
        }
        else if ([sender tag]==4) {
            [weekDays_dictionary_here setValue:@"Thursday" forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
            thursday_ImageView.image=[UIImage imageNamed:@"checked.png"];
        }
        else if ([sender tag]==5) {
            [weekDays_dictionary_here setValue:@"Friday" forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
            friday_ImageView.image=[UIImage imageNamed:@"checked.png"];
        }
        else if ([sender tag]==6) {
            [weekDays_dictionary_here setValue:@"Saturday" forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
            saturday_ImageView.image=[UIImage imageNamed:@"checked.png"];
        }
        else if ([sender tag]==7) {
            [weekDays_dictionary_here setValue:@"Sunday" forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
            sunday_ImageView.image=[UIImage imageNamed:@"checked.png"];
        }
    }
    
    NSLog(@"----week Day dict-->%@",[weekDays_dictionary_here description]);
}

-(IBAction)createDateTimeButtonPressed:(id)sender
{
    NSLog(@"-createDateTimeButtonPressed---appDelegate.chooseRequest_ID_String-->%@",appDelegate.chooseRequest_ID_String);
    
    if(!appDelegate.isFromContacts)
    {
         if(([_isCompleteRequest isEqualToString:@"false"] && [_inCompleteTab_string isEqualToString:@"Datetimes are In-Complete"]) || [_isCompleteRequest isEqualToString:@"true"]
                 || ([_isCompleteRequest isEqualToString:@"false"] && [_inCompleteTab_string isEqualToString:@"Request is completed but not submitted"]))
        {
            
            if ([appDelegate.chooseRequest_ID_String length] && [startDate_TextField.text length]&& [startDate_TextField.text length] && [endDate_TextField.text length] && [startTime_TextField.text length] && [endTime_TextField.text length] ){
                [self getBetween_dates];
                return;//called 2 times push thats why returned here
            }
            else
            {
                
                if ([appDelegate.chooseRequest_ID_String isEqualToString:@"-- select --"]){
                    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"select_choose_request", TABLE, nil)]; return;}
                else if (![startDate_TextField.text length]){
                    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"select_Start_Date", TABLE, nil)]; return;}
                else if (![endDate_TextField.text length]){
                    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"select_End_Date", TABLE, nil)]; return;}
                else if (![startTime_TextField.text length]){
                    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"select_Start_Time", TABLE, nil)]; return;}
                else if (![endTime_TextField.text length]){
                    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"select_End_Time", TABLE, nil)]; return;}
                
            }
        }
        
        if([appDelegate.chooseRequest_ID_String isEqualToString:@"-- Select --"])
        {
            [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"select_choose_request", TABLE, nil)];
            return;
        }
        else
        {
            [self validate];
        }
    }
    else
    {
        if (!isDateTimeDataAvailable)
        {
            if ([appDelegate.chooseRequest_ID_String isEqualToString:@"-- Select --"])
            {
                [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"select_choose_request", TABLE, nil)];
                return;
            }
            else
            {
              [self validate];
            }
        }
        else if (appDelegate.isFromContacts && !appDelegate.isNewRequest && ![startDate_TextField.text length]&& ![startDate_TextField.text length] && ![endDate_TextField.text length] && ![startTime_TextField.text length] && ![endTime_TextField.text length] )
        {
            if ([appDelegate.chooseRequest_ID_String isEqualToString:@"-- Select --"])
            {
                [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"select_choose_request", TABLE, nil)];
                return;
            }else{
                
                NSDictionary *infoDict=[NSDictionary dictionaryWithObjectsAndKeys:@"5",@"tabValue",[NSNumber numberWithBool:YES],@"isFromContacts",nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:kTabSelected object:nil userInfo:infoDict];
            }
            //[self pushToDatesAndTimes_DetailView];
        }
        else
        {
            if ([appDelegate.chooseRequest_ID_String isEqualToString:@"-- Select --"]){
                [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"select_choose_request", TABLE, nil)]; return;
            }
            else if (![startDate_TextField.text length]){
                [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"select_Start_Date", TABLE, nil)]; return;
            }
            else if (![endDate_TextField.text length])
            {
                [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"select_End_Date", TABLE, nil)]; return;
            }
            else if (![startTime_TextField.text length])
            {
                [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"select_Start_Time", TABLE, nil)]; return;
            }
            else if (![endTime_TextField.text length])
            {
                [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"select_End_Time", TABLE, nil)]; return;
            }
            else
            {
                [self validate];
            }
        }
    }
}

-(void)validate
{
    if ([appDelegate.chooseRequest_ID_String isEqualToString:@"-- select --"]){
        [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"select_choose_request", TABLE, nil)]; return;}
    if (![startDate_TextField.text length]){
        [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"select_Start_Date", TABLE, nil)]; return;}
    if (![endDate_TextField.text length]){
        [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"select_End_Date", TABLE, nil)]; return;}
    if (![startTime_TextField.text length]){
        [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"select_Start_Time", TABLE, nil)]; return;}
    if (![endTime_TextField.text length]){
        [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"select_End_Time", TABLE, nil)]; return;}
    else
    {
        [self getBetween_dates];
    }
}

-(void)getBetween_dates
{
    [createDateTimes_mutArray removeAllObjects];
    @try {
        
        if(weekDays_dictionary_here.count==0)
        {
            [weekDays_dictionary_here setValue:@"Monday" forKey:[NSString stringWithFormat:@"%@",@"1"]];
            [weekDays_dictionary_here setValue:@"Tuesday" forKey:[NSString stringWithFormat:@"%@",@"2"]];
            [weekDays_dictionary_here setValue:@"Wednesday" forKey:[NSString stringWithFormat:@"%@",@"3"]];
            [weekDays_dictionary_here setValue:@"Thursday" forKey:[NSString stringWithFormat:@"%@",@"4"]];
            [weekDays_dictionary_here setValue:@"Friday" forKey:[NSString stringWithFormat:@"%@",@"5"]];
            [weekDays_dictionary_here setValue:@"Saturday" forKey:[NSString stringWithFormat:@"%@",@"6"]];
            [weekDays_dictionary_here setValue:@"Sunday" forKey:[NSString stringWithFormat:@"%@",@"7"]];
        }
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        //[df setDateFormat:@"MM/dd/yyyy"];
        [df setDateFormat:@"MM/dd/yyyy"];//OLD
        NSDate *startDate = [df dateFromString:startDate_TextField.text]; // your start date
        NSDate *endDate =[df dateFromString:endDate_TextField.text];// [NSDate date]; // your end date
        
        [df setDateFormat:@"hh:mm a"];
        
        NSDate *startTime = [df dateFromString:startTime_TextField.text]; // your start time
        NSDate *endTime =[df dateFromString:endTime_TextField.text];// [NSDate date]; // your end time
        
        for(int i = 0; i < [detail_mut_array count] ;i++){
            GISDatesAndTimesObject *date_obj_here = [detail_mut_array  objectAtIndex:i];
            [df setDateFormat:@"MM/dd/yyyy"];
            NSDate *startDate1 = [df dateFromString:date_obj_here.date_String];
            NSDate *endDate1 = [df dateFromString:date_obj_here.date_String];
            [df setDateFormat:@"hh:mm a"];
            
            NSDate *startTime1 = [df dateFromString:date_obj_here.startTime_String];
            NSDate *endTime1 =[df dateFromString:date_obj_here.endTime_String];
            
            if (([startDate1 compare:startDate] == NSOrderedSame) && ([endDate1 compare:endDate] == NSOrderedSame) && ([startTime1 compare:startTime] == NSOrderedSame) && ([endTime1 compare:endTime] == NSOrderedSame) ) {
                
                [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"create_dates_times_Alert",TABLE, nil)];
                return;
            }
            
        }

        
        NSDateComponents *dayDifference = [[NSDateComponents alloc] init];
        
        NSMutableArray *dates = [[NSMutableArray alloc] init] ;
        NSUInteger dayOffset = 1;
        NSDate *nextDate = startDate;
        
        NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit
                                                            fromDate:startDate
                                                              toDate:endDate
                                                             options:0];
        
        //unsigned int unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit;
        //NSDateComponents *comps = [gregorian components:unitFlags fromDate:startDate  toDate:endDate  options:0];
        //int months = [comps month];
        //int days = [comps day];
        
        NSLog(@"StartDate-->%@",startDate);
        NSLog(@"EndDate-->%@",endDate);
        NSLog(@"date-IS->%ld",(long)[components day]);
        
        for (int i=0; i<[components day]+1;i++)
        {
            [dates addObject:nextDate];
            
            [dayDifference setDay:dayOffset++];
            NSDate *d = [[NSCalendar currentCalendar] dateByAddingComponents:dayDifference toDate:startDate options:0];
            nextDate = d;
        }
        
        [df setDateStyle:NSDateFormatterShortStyle];
        
        for (NSDate *date in dates)
        {
            NSLog(@"Dates is ---->%@", [df stringFromDate:date]);
            NSDateFormatter  *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM/dd/yyyy"];
            NSString *strVisitDate = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:date]];
            NSDate *visitDate = [dateFormatter dateFromString:strVisitDate];
            strVisitDate = [dateFormatter stringFromDate:visitDate];
            //Here you can set any date Format as per your need
            [dateFormatter setDateFormat:@"EEEE"];
            NSString *dayString= [dateFormatter stringFromDate:visitDate];
            
            NSLog(@"d*********************   DayString----%@", dayString);
            //BOOL isFound;
            for (int i=1; i<=7; i++)
            {
                if ([weekDays_dictionary_here objectForKey:[NSString stringWithFormat:@"%d",i]])
                {
                    NSString *compareStr=[weekDays_dictionary_here valueForKey:[NSString stringWithFormat:@"%d",i]];
                    if ([dayString isEqualToString:compareStr])
                    {
                        GISDatesAndTimesObject *date_obj_here=[[GISDatesAndTimesObject alloc]init];
                        //date_obj_here.activein_String=@"";
                        //date_obj_here.chooseReq_ID_String=chooseReq_ID_string;
                        //date_obj_here.chooseReq_answer_String=chooseReq_Answer_Label.text;
                        date_obj_here.startTime_String=startTime_TextField.text;
                        date_obj_here.startDate_String=startDate_TextField.text;
                        date_obj_here.endTime_String=endTime_TextField.text;
                        date_obj_here.endDate_String=endDate_TextField.text;
                        date_obj_here.weekDays_dictionary=weekDays_dictionary_here;
                        NSLog(@"#######################Found-->%@",[weekDays_dictionary_here valueForKey:[NSString stringWithFormat:@"%d",i]]);
                        NSString *dayStr=[weekDays_dictionary_here valueForKey:[NSString stringWithFormat:@"%d",i]];
                        date_obj_here.day_String=dayStr;
                        date_obj_here.date_String=[dateformatter stringFromDate:date];
                        [createDateTimes_mutArray addObject:date_obj_here];
                    }
                }
                
            }
        }
        
        NSLog(@"--%@----",[createDateTimes_mutArray description]);
        if (createDateTimes_mutArray.count<1) {
          //   [self getBetween_dates];
            [GISUtility showAlertWithTitle:@"GIS" andMessage:@"No data found to seleced dates"];
        }
        
        //[self pushToDatesAndTimes_DetailView];
    }
    
    @catch (NSException *exception) {
        [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in Dates and Times Save %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
    }
    
    detail_mut_array=[[NSMutableArray alloc]init];
    [detail_mut_array addObjectsFromArray:createDateTimes_mutArray];
    
    [datesTimes_tableView reloadData];
    if (createDateTimes_mutArray.count>0) {
        [self performSelector:@selector(saveButtonPressed:) withObject:nil];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        GISDatesAndTimesObject *dateObj = [detail_mut_array objectAtIndex:alertView.tag];
        if([dateObj.dateTime_ID_String length])
        {
            [self deleteTheDay:dateObj];
            currentObjTag_toDelete=alertView.tag;
        }
        else
        {
            [detail_mut_array removeObjectAtIndex:alertView.tag];
            [datesTimes_tableView reloadData];
        }
    }
}

-(void)deleteTheDay:(GISDatesAndTimesObject *)dateTimeObj
{
    [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
    NSMutableDictionary *mainDict=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *detail_date_Dict=[[NSMutableDictionary alloc]init];
    NSMutableArray *requestor_array=[[NSMutableArray alloc]init];
    NSMutableArray *detail_date_list_Array=[[NSMutableArray alloc]init];
    NSMutableDictionary *detail_Listdict;
    //if (detail_mut_array.count>0)
    {
        //for (int i=0;i<[detail_mut_array count];i++)
        {
            GISDatesAndTimesObject *gisList = dateTimeObj;//[detail_mut_array objectAtIndex:i];
            detail_Listdict=[[NSMutableDictionary alloc]init];
            
            if (gisList.dateTime_ID_String.length==0 || [gisList.dateTime_ID_String isKindOfClass:[NSNull class]])
                [detail_Listdict  setObject:@"" forKey:kDateTime_datetimeID];
            else
                [detail_Listdict  setObject:[GISUtility returningstring:gisList.dateTime_ID_String] forKey:kDateTime_datetimeID];
            
            [detail_Listdict  setObject:[GISUtility returningstring:gisList.dateTime_ID_String] forKey:kDateTime_datetimeID];
            [detail_Listdict  setObject:[GISUtility returningstring:[GISUtility returningstring:appDelegate.chooseRequest_ID_String]] forKey:kDateTime_requestNo];
            
            
            NSDateFormatter  *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM/dd/yyyy"];
            NSString *strVisitDate = [NSString stringWithFormat:@"%@", gisList.date_String];
            NSDate *visitDate = [dateFormatter dateFromString:strVisitDate];
            strVisitDate = [dateFormatter stringFromDate:visitDate];
            //Here you can set any date Format as per your need
            [dateFormatter setDateFormat:@"yyyy/MM/dd"];
            strVisitDate = [dateFormatter stringFromDate:visitDate];
            [detail_Listdict  setObject:[GISUtility returningstring:strVisitDate] forKey:kDateTime_date];
            [detail_Listdict  setObject:@"true" forKey:kDateTime_activein];
            
            [detail_Listdict  setObject:[GISUtility returningstring:gisList.startTime_String] forKey:kDateTime_starttime];
            [detail_Listdict  setObject:[GISUtility returningstring:gisList.endTime_String] forKey:kDateTime_endtime];
            [detail_date_list_Array addObject:detail_Listdict];
        }
    }
    
    [detail_date_Dict setValue:[GISUtility returningstring:login_Obj.requestorID_string] forKey:kDateTime_RequestorID];
    [detail_date_Dict setValue:[GISUtility returningstring:login_Obj.token_string] forKey:kDateTime_token];
    
    
    [requestor_array addObject:detail_date_Dict];
    
    [mainDict setObject:requestor_array forKey:kDateTime_oDatetime];
    [mainDict setObject:detail_date_list_Array forKey:kDateTime_oRequest];
    
    NSLog(@"--------main Dict-->%@",mainDict);
    
    isDelete=YES;
    isUpdated = NO;
    
    [[GISServerManager sharedManager] saveDateTimeData:self withParams:mainDict finishAction:@selector(successmethod_save_Date_Time:) failAction:@selector(failuremethod_save_Date_Time:)];
    
}


-(void)successmethod_save_Date_Time:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"successmethod_save_Date_Time -%@",response.responseJson);
    NSArray *array=response.responseJson;
    NSDictionary *dictNew=[array lastObject];
    NSString *success= [NSString stringWithFormat:@"%@",[dictNew objectForKey:kStatusCode]];
    if ([success isEqualToString:@"200"]) {
        if(isDelete)
        {
            [detail_mut_array removeObjectAtIndex:currentObjTag_toDelete];
            [datesTimes_tableView reloadData];
            [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"date_time_deleted", TABLE, nil)];
        }
        else
        {
            if([appDelegate.datesArray count]>0)
                [appDelegate.datesArray removeAllObjects];
            [appDelegate.datesArray addObjectsFromArray:detail_mut_array];
            
            GISDatesAndTimesObject *dobj=[[GISDatesAndTimesObject alloc]init];
            [appDelegate.datesArray insertObject:dobj atIndex:0];
            
            if(isUpdated){
                
                [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"date_time_updated", TABLE, nil)];
            }else{
                [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"date_time_successed", TABLE, nil)];
            }
            //[self performSelector:@selector(nextButtonPressed:) withObject:nil];
            
            [self clearDateTimes_Data];
            
            NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
            [paramsDict setObject:appDelegate.chooseRequest_ID_String forKey:kID];
            [paramsDict setObject:login_Obj.token_string forKey:kToken];
            [[GISServerManager sharedManager] getDateTimeDetails:self withParams:paramsDict finishAction:@selector(successmethod_get_Date_Time:) failAction:@selector(failuremethod_get_Date_Time:)];
            

        }
    }
    else
    {
        [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_Failed", TABLE, nil)];
    }
    [createJObs_tableView reloadData];
}

-(void)failuremethod_save_Date_Time:(GISJsonRequest *)response
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
    
    if ([[saveUpdateDict objectForKey:kStatusCode] isEqualToString:@"200"]) {
        
        [self removeLoadingView];
        [[GISStoreManager sharedManager]removeDateTimes_detail_Objects];
        
        store=[[GISDatesTimesDetailStore alloc]initWithStoreDictionary:response.responseJson];
        [detail_mut_array removeAllObjects];
        detail_mut_array= [[GISStoreManager sharedManager]getDateTimes_detail_Objects];
        [self sortTheDatesAndTimes];
        
        if (detail_mut_array.count>0) {
            isDateTimeDataAvailable=YES;
        }
        else
        {
            isDateTimeDataAvailable=NO;
        }
        
        if([appDelegate.datesArray count]>0)
            [appDelegate.datesArray removeAllObjects];
        [appDelegate.datesArray addObjectsFromArray:detail_mut_array];
        
        GISDatesAndTimesObject *dobj=[[GISDatesAndTimesObject alloc]init];
        [appDelegate.datesArray insertObject:dobj atIndex:0];
        
        [createJObs_tableView reloadData];
    }
    else if(responseArray.count<1)
    {
        //[GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"no_data",TABLE, nil)];
    }
    else{
        
        
        [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
        [self removeLoadingView];
        //[GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
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
    [datesTimes_tableView reloadData];
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


-(void)editButtonPressed:(id)sender
{
    NSLog(@"tag--%d",[sender tag]);
    selected_row=[sender tag];
    
    GISDatesAndTimesObject *tempObj=[detail_mut_array objectAtIndex:[sender tag]];
    date_temp_string=tempObj.date_String;
    startTime_temp_string=tempObj.startTime_String;
    endTime_temp_string=tempObj.endTime_String;
    day_temp_string=tempObj.day_String;
    
    [datesTimes_tableView reloadData];
}

-(void)deleteButtonPressed:(id)sender
{
    [self performSelector:@selector(cancelButton_Edit_Pressed:) withObject:nil];
    
    UIAlertView *alertVIew = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) message:NSLocalizedStringFromTable(@"do you want to delete", TABLE, nil) delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alertVIew.tag = [sender tag];
    alertVIew.delegate = self;
    [alertVIew show];
}

-(IBAction)dateButton_Edit_Pressed:(id)sender
{
    UIButton *button=(UIButton *)sender;
    id tempCellRef=(GISDatesTimesDetailCell *)[GISUtility findParentTableViewCell:button];//button.superview.superview.superview.superview;
    GISDatesTimesDetailCell *tempCell=(GISDatesTimesDetailCell *)tempCellRef;
    //GISDatesAndTimesObject *tempObj= [detail_mut_array objectAtIndex:[sender tag]];
    btnTag=555;
    UIPopoverController *popOver_temp= [self showPopOver:tempCell:@"datestimes" :date_temp_string :tempCell.date_edit_button_detailView.frame :btnTag];
    [popOver_temp presentPopoverFromRect:CGRectMake(100,308, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
}

-(IBAction)startTimeButton_Edit_Pressed:(id)sender
{
    UIButton *button=(UIButton *)sender;
    id tempCellRef=(GISDatesTimesDetailCell *)[GISUtility findParentTableViewCell:button];//button.superview.superview.superview.superview;
    GISDatesTimesDetailCell *tempCell=(GISDatesTimesDetailCell *)tempCellRef;
    //GISDatesAndTimesObject *tempObj= [detail_mut_array objectAtIndex:[sender tag]];
    btnTag=666;
    UIPopoverController *popOver_temp= [self showPopOver:tempCell:@"timesdates" :startTime_temp_string :tempCell.startTime_edit_button_detailView.frame :btnTag];
    
    [popOver_temp presentPopoverFromRect:CGRectMake(200,308, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
}


-(IBAction)endTimeButton_Edit_Pressed:(id)sender
{
    UIButton *button=(UIButton *)sender;
    id tempCellRef=(GISDatesTimesDetailCell *)[GISUtility findParentTableViewCell:button];//button.superview.superview.superview.superview;
    GISDatesTimesDetailCell *tempCell=(GISDatesTimesDetailCell *)tempCellRef;
    //GISDatesAndTimesObject *tempObj= [detail_mut_array objectAtIndex:[sender tag]];
    btnTag=777;
    UIPopoverController *popOver_temp=[self showPopOver:tempCell:@"timesdates" :endTime_temp_string :tempCell.endTime_edit_button_detailView.frame :btnTag];
    [popOver_temp presentPopoverFromRect:CGRectMake(315,308, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
}

-(UIPopoverController *)showPopOver:(GISDatesTimesDetailCell *)cell :(NSString *)view_str :(NSString *)moveUp_str :(CGRect)frameTemp :(int)tag
{
    tableViewController = [[GISPopOverTableViewController alloc] initWithNibName:@"GISPopOverTableViewController" bundle:nil];
    tableViewController.popOverDelegate=self;
    btnTag=tag;
    tableViewController.view_String=view_str;
    tableViewController.dateTimeMoveUp_string=moveUp_str;
    popover =[[UIPopoverController alloc] initWithContentViewController:tableViewController];
    
    popover.delegate = self;
    popover.popoverContentSize = CGSizeMake(340, 150);
    return  popover;
    
}



-(IBAction)saveButton_Edit_Pressed:(id)sender
{
    GISDatesAndTimesObject *gisList=[detail_mut_array objectAtIndex:[sender tag]];
    
    gisList.date_String=date_temp_string;
    gisList.startTime_String=startTime_temp_string;
    gisList.endTime_String=endTime_temp_string;
    gisList.day_String=day_temp_string;
    
    //[detail_mut_array replaceObjectAtIndex:[sender tag] withObject:gisList];
    [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
    NSMutableDictionary *mainDict=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *detail_date_Dict=[[NSMutableDictionary alloc]init];
    NSMutableArray *requestor_array=[[NSMutableArray alloc]init];
    NSMutableArray *detail_date_list_Array=[[NSMutableArray alloc]init];
    NSMutableDictionary *detail_Listdict;
    //if (detail_mut_array.count>0)
    {
        //for (int i=0;i<[detail_mut_array count];i++)
        {
            // GISDatesAndTimesObject *gisList = [detail_mut_array objectAtIndex:i];
            detail_Listdict=[[NSMutableDictionary alloc]init];
            
            [detail_Listdict  setObject:[GISUtility returningstring:gisList.dateTime_ID_String] forKey:kDateTime_datetimeID];
            [detail_Listdict  setObject:[GISUtility returningstring:appDelegate.chooseRequest_ID_String] forKey:kDateTime_requestNo];
            
            
            NSDateFormatter  *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM/dd/yyyy"];
            NSString *strVisitDate = [NSString stringWithFormat:@"%@", date_temp_string];
            NSDate *visitDate = [dateFormatter dateFromString:strVisitDate];
            strVisitDate = [dateFormatter stringFromDate:visitDate];
            //Here you can set any date Format as per your need
            [dateFormatter setDateFormat:@"yyyy/MM/dd"];
            strVisitDate = [dateFormatter stringFromDate:visitDate];
            [detail_Listdict  setObject:[GISUtility returningstring:strVisitDate] forKey:kDateTime_date];
            
            
            
            [detail_Listdict  setObject:[GISUtility returningstring:startTime_temp_string] forKey:kDateTime_starttime];
            [detail_Listdict  setObject:[GISUtility returningstring:endTime_temp_string] forKey:kDateTime_endtime];
            [detail_date_list_Array addObject:detail_Listdict];
        }
        
    }
    
    [detail_date_Dict setValue:[GISUtility returningstring:login_Obj.requestorID_string] forKey:kDateTime_RequestorID];
    [detail_date_Dict setValue:[GISUtility returningstring:login_Obj.token_string] forKey:kDateTime_token];
    [requestor_array addObject:detail_date_Dict];
    
    [mainDict setObject:requestor_array forKey:kDateTime_oDatetime];
    [mainDict setObject:detail_date_list_Array forKey:kDateTime_oRequest];
    isUpdated = YES;
    
    [self performSelector:@selector(cancelButton_Edit_Pressed:) withObject:nil];
    [[GISServerManager sharedManager] saveDateTimeData:self withParams:mainDict finishAction:@selector(successmethod_save_Date_Time:) failAction:@selector(failuremethod_save_Date_Time:)];
    NSLog(@"--------main Dict-->%@",mainDict);
    isDelete=NO;
    
   
}


-(IBAction)cancelButton_Edit_Pressed:(id)sender
{
    selected_row=999999;
    date_temp_string=@"";
    startTime_temp_string=@"";
    endTime_temp_string=@"";
    day_temp_string=@"";

    [datesTimes_tableView reloadData];
}


-(void)selectedChooseRequestNumber:(NSNotification*)notification
{
    NSDictionary *dict=[notification userInfo];
   
    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
    [paramsDict setObject:[dict valueForKey:@"id"] forKey:kID];
    [paramsDict setObject:login_Obj.token_string forKey:kToken];
    appDelegate.chooseRequest_ID_String=[dict valueForKey:@"id"];
    
    [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
    [[GISServerManager sharedManager] getChooseRequestDetailsData:self withParams:paramsDict finishAction:@selector(successmethod_getChooseRequestDetails:) failAction:@selector(failuremethod_getChooseRequestDetails:)];
    
    [[GISServerManager sharedManager] getDateTimeDetails:self withParams:paramsDict finishAction:@selector(successmethod_get_Date_Time:) failAction:@selector(failuremethod_get_Date_Time:)];
    
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

-(IBAction)saveButtonPressed:(id)sender
{
    @try
    {
        [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
        NSMutableDictionary *mainDict=[[NSMutableDictionary alloc]init];
        NSMutableDictionary *detail_date_Dict=[[NSMutableDictionary alloc]init];
        NSMutableArray *requestor_array=[[NSMutableArray alloc]init];
        NSMutableArray *detail_date_list_Array=[[NSMutableArray alloc]init];
        NSMutableDictionary *detail_Listdict;
        if (detail_mut_array.count>0)
        {
            for (int i=0;i<[detail_mut_array count];i++)
            {
                GISDatesAndTimesObject *gisList = [detail_mut_array objectAtIndex:i];
                detail_Listdict=[[NSMutableDictionary alloc]init];
                
                if (gisList.dateTime_ID_String.length==0 || [gisList.dateTime_ID_String isKindOfClass:[NSNull class]])
                    [detail_Listdict  setObject:@"" forKey:kDateTime_datetimeID];
                else
                    [detail_Listdict  setObject:[GISUtility returningstring:gisList.dateTime_ID_String] forKey:kDateTime_datetimeID];
                
                [detail_Listdict  setObject:[GISUtility returningstring:gisList.dateTime_ID_String] forKey:kDateTime_datetimeID];
                [detail_Listdict  setObject:[GISUtility returningstring:appDelegate.chooseRequest_ID_String] forKey:kDateTime_requestNo];
                
                
                NSDateFormatter  *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"MM/dd/yyyy"];
                NSString *strVisitDate = [NSString stringWithFormat:@"%@", gisList.date_String];
                NSDate *visitDate = [dateFormatter dateFromString:strVisitDate];
                strVisitDate = [dateFormatter stringFromDate:visitDate];
                //Here you can set any date Format as per your need
                [dateFormatter setDateFormat:@"yyyy/MM/dd"];
                strVisitDate = [dateFormatter stringFromDate:visitDate];
                [detail_Listdict  setObject:[GISUtility returningstring:strVisitDate] forKey:kDateTime_date];
                
                
                
                [detail_Listdict  setObject:[GISUtility returningstring:gisList.startTime_String] forKey:kDateTime_starttime];
                [detail_Listdict  setObject:[GISUtility returningstring:gisList.endTime_String] forKey:kDateTime_endtime];
                [detail_date_list_Array addObject:detail_Listdict];
            }
            
        }
        
        [detail_date_Dict setValue:[GISUtility returningstring:login_Obj.requestorID_string] forKey:kDateTime_RequestorID];
        [detail_date_Dict setValue:[GISUtility returningstring:login_Obj.token_string] forKey:kDateTime_token];
        [requestor_array addObject:detail_date_Dict];
        
        [mainDict setObject:requestor_array forKey:kDateTime_oDatetime];
        [mainDict setObject:detail_date_list_Array forKey:kDateTime_oRequest];
        
        NSLog(@"--------main Dict-->%@",mainDict);
        isDelete=NO;
        isUpdated = NO;
        
        [[GISServerManager sharedManager] saveDateTimeData:self withParams:mainDict finishAction:@selector(successmethod_save_Date_Time:) failAction:@selector(failuremethod_save_Date_Time:)];
    }
    @catch (NSException *exception)
    {
        [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in Dates and Times Detail View Save %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kselectedChooseReqNumber object:nil];
}

-(IBAction)createJobsButton_Pressed:(id)sender
{
    isAlljobs_Checked=NO;
    createJobsCheckDictionary=[[NSMutableDictionary alloc]init];
    //createJobs_UIVIew.hidden=NO;
    createJobs_UIVIew.hidden=NO;
    //createJobs_UIVIew.frame=CGRectMake(40, -80, 453, 570);
    //CGRect frame= createJobs_UIVIew.frame;
    //frame.origin.y=-40;
    //createJobs_UIVIew.frame=frame;
    [createJobs_Middle_UIVIew.layer setCornerRadius:10.0f];
    [createJobs_Middle_UIVIew.layer setBorderWidth:0.3f];
    //[self.view addSubview:createJobs_UIVIew];
}

-(IBAction)checkAllJobs_buttonPressed:(id)sender
{
    if (isAlljobs_Checked) {
        isAlljobs_Checked=NO;
        [createJobsCheckDictionary removeAllObjects];
        [alljobs_Checked_button setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    }
    else
    {
        [alljobs_Checked_button setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        
        isAlljobs_Checked=YES;
        [createJobsCheckDictionary removeAllObjects];
        for (int i=0; i<detail_mut_array.count; i++) {
            [createJobsCheckDictionary setObject:[NSString stringWithFormat:@"%ld",(long)i] forKey:[NSString stringWithFormat:@"%ld",(long)i]];
        }
        
    }
    [createJObs_tableView reloadData];
}

-(IBAction)cancelButtonPressed_CreateJobs:(id)sender
{
    createJobs_UIVIew.hidden=YES;
}

-(IBAction)doneButtonPressed_CreateJobs:(id)sender
{
    //createJobs_UIVIew.hidden=YES;
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

-(void)sendCreateJObs_data
{
    NSString *typeOfService_ID_temp_String=@"";
    NSString *payLevel_ID_temp_String=@"";
    NSString *billLevel_ID_temp_String=@"";
    
    
    NSPredicate *predicate_typeOfService=[NSPredicate predicateWithFormat:@"value_String=%@",typeOfServiceProviders_Answer_Label.text];
    NSArray *array_typeOfService=[typeOfServiceProvider_Array filteredArrayUsingPredicate:predicate_typeOfService];
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
    
    for (int i=0;i<[createJobsCheckDictionary count];i++)
    {
        GISDatesAndTimesObject *dobj=[detail_mut_array objectAtIndex:[[createJobsCheckDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)i]]intValue ]];
        for (int i=0; i<count; i++) {
            
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
    
    
    [requestor_Dict setValue:[GISUtility returningstring:login_Obj.requestorID_string] forKey:kLoginRequestorID];
    [requestor_Dict setValue:[GISUtility returningstring:appDelegate.chooseRequest_ID_String ] forKey:kSearchReq_SP_RequestID];
    
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
        
    }
    else{
        
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
    }
    else
    {
        [createJobsCheckDictionary setObject:[NSString stringWithFormat:@"%ld",(long)[sender tag]] forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
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


-(IBAction)nextButtonPressed:(id)sender
{
    appDelegate.isFromContacts = YES;
    
     if([detail_mut_array count] > 0){
        
        NSDictionary *infoDict=[NSDictionary dictionaryWithObjectsAndKeys:@"5",@"tabValue",[NSNumber numberWithBool:YES],@"isFromContacts",nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:kTabSelected object:nil userInfo:infoDict];
        
     }else{
    
         [self performSelector:@selector(createDateTimeButtonPressed:) withObject:nil];
         
     }
    
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    numberOfServiceProviders_string=textField.text;
}

-(void)clearDateTimes_Data
{
    startDate_TextField.text=@"";
    endDate_TextField.text=@"";
    startTime_TextField.text=@"";
    endTime_TextField.text=@"";
    monday_ImageView.image=[UIImage imageNamed:@"unchecked"];
    tuesday_ImageView.image=[UIImage imageNamed:@"unchecked"];
    wednesday_ImageView.image=[UIImage imageNamed:@"unchecked"];
    thursday_ImageView.image=[UIImage imageNamed:@"unchecked"];
    friday_ImageView.image=[UIImage imageNamed:@"unchecked"];
    saturday_ImageView.image=[UIImage imageNamed:@"unchecked"];
    sunday_ImageView.image=[UIImage imageNamed:@"unchecked"];
    [weekDays_dictionary_here removeAllObjects];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
