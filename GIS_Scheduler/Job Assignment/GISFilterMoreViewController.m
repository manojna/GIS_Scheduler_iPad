//
//  GISFilterMoreViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 11/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISFilterMoreViewController.h"
#import "GISDatabaseManager.h"
#import "GISUtility.h"
@interface GISFilterMoreViewController ()

@end

@implementation GISFilterMoreViewController

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
    
    registeredConsumers_array=[[NSMutableArray alloc]init];
    eventType_array=[[NSMutableArray alloc]init];
    serviceProviderType_array=[[NSMutableArray alloc]init];
    serviceProvider_array=[[NSMutableArray alloc]init];
    unitAccount_array=[[NSMutableArray alloc]init];
    
    NSString *registeredConsumers_statement = [[NSString alloc]initWithFormat:@"select * from TBL_REGISTERED_CONSUMERS;"];
    registeredConsumers_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:registeredConsumers_statement] mutableCopy];
    NSString *eventCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_EVENT_TYPE;"];
    eventType_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:eventCode_statement] mutableCopy];
    NSString *spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO"];
    serviceProvider_array = [[[GISDatabaseManager sharedDataManager] getServiceProviderArray:spCode_statement] mutableCopy];
    NSString *typeOfService_statement = [[NSString alloc]initWithFormat:@"select * from TBL_TYPE_OF_SERVICE  ORDER BY ID DESC;"];
    serviceProviderType_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:typeOfService_statement] mutableCopy];
    NSString *unitIDorDep_statement = [[NSString alloc]initWithFormat:@"select * from TBL_UNIT_DEPARTMENT;"];
    unitAccount_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:unitIDorDep_statement] mutableCopy];
    
    
    
}

-(IBAction)pickerButtonPressed:(id)sender
{
    UIButton *button=(UIButton *)sender;
    
    GISPopOverTableViewController *tableViewController1 = [[GISPopOverTableViewController alloc] initWithNibName:@"GISPopOverTableViewController" bundle:nil];
    tableViewController1.popOverDelegate=self;
    
    if([sender tag]==111)
    {
        btnTag=111;
        tableViewController1.popOverArray=eventType_array;
    }
    else if([sender tag]==333)
    {
        btnTag=333;
        tableViewController1.popOverArray=serviceProvider_array;
    }
    else if ([sender tag]==444)
    {
        btnTag=444;
        tableViewController1.popOverArray=registeredConsumers_array;
    }
    else if([sender tag]==555)
    {
        btnTag=555;
        tableViewController1.popOverArray=unitAccount_array;
    }
   
    popover =[[UIPopoverController alloc] initWithContentViewController:tableViewController1];
    
    popover.delegate = self;
    popover.popoverContentSize = CGSizeMake(340, 180);
    [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+button.frame.size.width-14, button.frame.origin.y+24, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

}

-(void)sendTheSelectedPopOverData:(NSString *)id_str value:(NSString *)value_str
{
    [self performSelector:@selector(dismissPopOverNow) withObject:nil afterDelay:0.3];
    if(btnTag==111)
    {
        eventType_AnswerLabel.text=value_str;
        eventType_ID_string=id_str;
    
    }
    else if(btnTag==333)
    {
        serviceProvider_AnswerLabel.text=value_str;
        serviceProvider_ID_string=id_str;
    }
    else if(btnTag==444)
    {
        registeredConsumers_AnswerLabel.text=value_str;
        registeredCOnsumers_ID_string=id_str;
    }
    else if(btnTag==555)
    {
        unitAccount_AnswerLabel.text=value_str;
        unitAccount_ID_string=id_str;
    }
    
}


-(IBAction)radioButton_Pressed:(id)sender
{
    
    if ([sender tag]==666 || [sender tag]==777) {
        if ([sender tag]==666) {
            typeOfAct_string=@"2";
            [internal_btn setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [external_btn setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }
        else
        {
            typeOfAct_string=@"1";
            [external_btn setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [internal_btn setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }
    }
    
    if ([sender tag]==888 || [sender tag]==999) {
        if ([sender tag]==888) {
            onGoing_string=@"1";
            [no_btn_OnGoing setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [yes_btn_OnGoing setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }
        else
        {
            onGoing_string=@"0";
            [yes_btn_OnGoing setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [no_btn_OnGoing setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }
    }
}

-(IBAction)apply_Cancel_ButtonPressed:(id)sender
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    if ([sender tag]==1) {
        
        [dict setObject:[GISUtility returningstring:eventType_ID_string] forKey:@"1"];
        [dict setObject:[GISUtility returningstring:serviceProvider_ID_string] forKey:@"2"];
        [dict setObject:[GISUtility returningstring:registeredCOnsumers_ID_string] forKey:@"3"];
        [dict setObject:[GISUtility returningstring:unitAccount_ID_string] forKey:@"4"];
        [dict setObject:[GISUtility returningstring:typeOfAct_string] forKey:@"5"];
        [dict setObject:[GISUtility returningstring:onGoing_string] forKey:@"6"];
        [_delegate_filter sendFilterMoreValues:dict];
    }
    else
    {
        [_delegate_filter sendFilterMoreValues:dict];
    }
}

-(void)dismissPopOverNow
{
    [popover dismissPopoverAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
