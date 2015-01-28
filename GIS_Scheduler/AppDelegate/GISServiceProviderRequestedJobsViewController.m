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
    
    serviceProviderName_mutArray=[[NSMutableArray alloc]initWithObjects:@"David, John",@"John,david",@"Swamy,pilla" , nil];
    
    noOfAttendees_mutArray=[[NSMutableArray alloc]initWithObjects:@"2-5",@"6-15",@"16-50", @"50+" , nil];
    noOfAttendees_ID_mutArray=[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3", @"4" , nil];
    
    NSString *requetDetails_statement = [[NSString alloc]initWithFormat:@"select * from TBL_CHOOSE_REQUEST ORDER BY ID DESC;"];
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
}

-(IBAction)pickerButton_pressed:(id)sender
{
    
    UIButton *button=(UIButton *)sender;
    
    GISPopOverTableViewController *tableViewController1 = [[GISPopOverTableViewController alloc] initWithNibName:@"GISPopOverTableViewController" bundle:nil];
    tableViewController1.popOverDelegate=self;
    
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
         tableViewController1.popOverArray=noOfAttendees_mutArray;
        tableViewController1.view_String=[GISUtility returningstring:noOfAttendees_answer_label.text];
        
    }
    else if ([sender tag]==1010)//Create Jobs View Buttons
    {
        btnTag=1010;
         tableViewController1.popOverArray=generalLoaction_mutArray;
        tableViewController1.view_String=[GISUtility returningstring:generalLocation_answer_label.text];
        
    }

    popover =[[UIPopoverController alloc] initWithContentViewController:tableViewController1];
    
    popover.delegate = self;
    popover.popoverContentSize = CGSizeMake(340, 150);
    [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+131, button.frame.origin.y+24, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

-(void)sendTheSelectedPopOverData:(NSString *)id_str value:(NSString *)value_str
{
    [self performSelector:@selector(dismissPopOverNow) withObject:nil afterDelay:0.0];
    if (btnTag==111)
    {
        chooseRequest_ID_answer_label.text=value_str;
        
    }
    else if (btnTag==222)
    {
        serviceProvider_answer_label.text=value_str;
        
    }
    else if (btnTag==333)
    {
        startDate_answer_label.text=value_str;
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
        typeOfService_answer_label.text=value_str;
    }
    else if (btnTag==888)
    {
        eventType_answer_label.text=value_str;
        
    }
    else if (btnTag==999)
    {
        noOfAttendees_answer_label.text=value_str;
        
    }
    else if (btnTag==1010)
    {
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
            openToPublic_str=@"yes";
            [openToPublic_NO_button setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [openToPublic_YES_button setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }
        else
        {
            openToPublic_str=@"no";
            [openToPublic_YES_button setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [openToPublic_NO_button setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }
    }
    
    if ([sender tag]==3 || [sender tag]==4) {
        if ([sender tag]==3) {
            onGoing_str=@"yes";
            [onGoing_NO_button setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [onGoing_YES_button setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }
        else
        {
            onGoing_str=@"no";
            [onGoing_YES_button setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [onGoing_NO_button setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }
    }
    
    if ([sender tag]==5 || [sender tag]==6) {
        if ([sender tag]==5) {
            recordBroadCast_str=@"yes";
            [recordBroadCast_NO_button setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [recordBroadCast_YES_button setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }
        else
        {
            recordBroadCast_str=@"no";
            [recordBroadCast_YES_button setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [recordBroadCast_NO_button setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }
    }
}

-(IBAction)searchButton_pressed:(id)sender
{
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
