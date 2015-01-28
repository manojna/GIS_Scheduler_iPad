//
//  GISSummaryViewController.m
//  GIS_Scheduler
//
//  Created by Anand on 18/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISSummaryViewController.h"
#import "GISSummaryCell.h"
#import "GISConstants.h"
#import "GISLoginDetailsObject.h"
#import "GISDatabaseManager.h"
#import "GISDropDownsObject.h"
#import "GISStoreManager.h"
#import "PCLogger.h"
#import "GISSummaryAttendeesCell.h"
#import "GISFonts.h"
#import "GISSummaryDatesAndTimesCell.h"
#import "GISSummaryDatesDetailViewCell.h"
#import "GISDatesAndTimesObject.h"
#import "GISJsonRequest.h"
#import "GISConstants.h"
#import "GISUtility.h"
#import "GISJSONProperties.h"
#import "GISServerManager.h"
#import "GISSummaryRequestModificationCell.h"
#import "GISBilingDataObject.h"
#import "GISJobDetailsCell.h"
#import "GISSummaryJobDetailsCell.h"
#import "GISLoadingView.h"
#import "GISAttendeesDetailsStore.h"
#import "GISDatesTimesDetailStore.h"
#import "GISJobDetailsStore.h"

@interface GISSummaryViewController ()

@end

@implementation GISSummaryViewController

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
    
    NSString *requetDetails_statement = [[NSString alloc]initWithFormat:@"select * from TBL_CHOOSE_REQUEST  ORDER BY ID DESC;"];
    
    _chooseReqArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:requetDetails_statement];
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    
    for (GISDropDownsObject *dropDownObj in _chooseReqArray) {
        if ([dropDownObj.value_String isEqualToString:[userDefaults valueForKey:kDropDownValue]]) {
            _choose_req_Id_string=dropDownObj.id_String;
        }
    }

    NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
    NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
    loginObJ=[requetId_array lastObject];
//    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
//    if ([_choose_req_Id_string length]==0) {
//        _choose_req_Id_string=@"";
//    }
//    [paramsDict setObject:_choose_req_Id_string forKey:kID];
//    [paramsDict setObject:loginObJ.token_string forKey:kToken];
//    
//    [[GISServerManager sharedManager] getEventDetailsData:self withParams:paramsDict finishAction:@selector(successmethod_getRequestEventDetails:) failAction:@selector(failuremethod_getRequestEventDetails:)];
    
    serviceRequestData = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    
    _serviceTypeArray  = [[NSArray alloc] initWithObjects:@"OnHold",@"Submit to GIS Admin Approval", nil];
    
    _serviceTypeSaveArray  = [[NSArray alloc] initWithObjects:@"OnHold",@"Save", nil];
    
    detail_mut_array = [[NSMutableArray alloc] init];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectedChooseRequestNumber:) name:kselectedChooseReqNumber object:nil];
    
    NSMutableArray *chooseReqDetailedArray=[[GISStoreManager sharedManager]getChooseRequestDetailsObjects];
    if (chooseReqDetailedArray.count>0) {
        _chooseRequestDetailsObj=[chooseReqDetailedArray lastObject];
    }
    
    if([appDelegate.chooseRequest_ID_String length] > 0 && ![appDelegate.chooseRequest_ID_String isEqualToString:@"0"]){
        
        
        [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];

        NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
        [paramsDict setObject:appDelegate.chooseRequest_ID_String forKey:kID];
        [paramsDict setObject:loginObJ.token_string forKey:kToken];
        [[GISServerManager sharedManager] getEventDetailsData:self withParams:paramsDict finishAction:@selector(successmethod_getRequestDetails:) failAction:@selector(failuremethod_getRequestDetails:)];

    }else{
        
        if([appDelegate.datesArray count]>0)
            [appDelegate.datesArray removeAllObjects];
        
        if([appDelegate.attendeesArray count]>0)
            [appDelegate.attendeesArray removeAllObjects];
        
        if([appDelegate.jobDetailsArray count]>0)
            [appDelegate.jobDetailsArray removeAllObjects];
        
        row_value = 0;
    }
    
    row_value = 1;
    
    [_summary_tableView reloadData];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 2)
        return [appDelegate.attendeesArray count];
    else if(section == 4)
        return [appDelegate.datesArray count];
    else if(section == 6)
        return 0;
    else if(section == 5)
    {
        if(appDelegate.isNewRequest)
            return 0;
        else
            return [appDelegate.jobDetailsArray count];
    }
    return row_value;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISSummaryCell *summaryCell;
    if(indexPath.section == 1) {
        
        summaryCell=(GISSummaryCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return summaryCell.frame.size.height;
        
    }else if(indexPath.section == 0){
        
        summaryCell=(GISSummaryCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return summaryCell.frame.size.height - 70;

    
    }else if(indexPath.section == 3){
        
        summaryCell=(GISSummaryCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        if ([_generalLocationId_string isEqualToString:@"1"])
            return summaryCell.frame.size.height-120;
        
        return summaryCell.frame.size.height-100;
        
    }else if(indexPath.section == 2){
        
        GISSummaryAttendeesCell *attendeesCell=(GISSummaryAttendeesCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        
        return attendeesCell.frame.size.height;
    }else if(indexPath.section == 4){
        
        GISSummaryDatesDetailViewCell *datesDetailCell=(GISSummaryDatesDetailViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        
        return datesDetailCell.frame.size.height;
    }else if(indexPath.section == 5){
        
        if(appDelegate.isNewRequest)
            return 0;
        
        GISJobDetailsCell *jobDetailsCell=(GISJobDetailsCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return jobDetailsCell.frame.size.height;
    }
    
    return summaryCell.frame.size.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISSummaryCell *cell;
    if(indexPath.section == 0 || indexPath.section == 1  || indexPath.section == 3){
        cell=(GISSummaryCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if(cell==nil)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISSummaryCell" owner:self options:nil]objectAtIndex:0];
        }
    }
    
    cell.descriptionTextview.hidden = TRUE;
    if(indexPath.section == 0){
        
        cell.section_label.text =  NSLocalizedStringFromTable(@"contact_billing_info", TABLE, nil);
        
       // NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
       // NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
       // GISLoginDetailsObject *unitObj1=[requetId_array lastObject];
        
        
        
        NSMutableArray *chooseReqDetailedArray=[[GISStoreManager sharedManager]getChooseRequestDetailsObjects];
        if (chooseReqDetailedArray.count>0) {
            _chooseRequestDetailsObj=[chooseReqDetailedArray lastObject];
        }
        
        NSString *unitIDorDep_statement = [[NSString alloc]initWithFormat:@"select * from TBL_UNIT_DEPARTMENT ;"];
        NSArray *department_mut_array = [[GISDatabaseManager sharedDataManager] getDropDownArray:unitIDorDep_statement] ;
        
        for (GISDropDownsObject *dropDownObj in department_mut_array) {
            if ([dropDownObj.id_String isEqualToString:_chooseRequestDetailsObj.unitID_String_chooseReqParsedDetails]) {
               // cell.unitacNumber_label .text =  dropDownObj.value_String;
            }
        }
        
        GISBilingDataObject *billingdataObj;
        NSArray *billingArray = [[GISStoreManager sharedManager] getBillingDataObject];
        billingdataObj = [billingArray lastObject];
        
        if([appDelegate.chooseRequest_ID_String length] > 0 && ![appDelegate.chooseRequest_ID_String isEqualToString:@"0"]){
            
            cell.unitacNumber_ans_label .text = _chooseRequestDetailsObj.unitID_String_chooseReqParsedDetails;
            cell.firstName_ans_label.text = billingdataObj.buh_firstName_String;
            cell.lastName_ans_label.text = billingdataObj.buh_lastName_String;
            cell.email_ans_label.text = billingdataObj.buh_email_String;
            cell.address1_ans_label.text = billingdataObj.buh_address1_String;
            cell.address2_ans_label.text = billingdataObj.buh_address2_String;
            cell.zip_ans_label.text = billingdataObj.buh_zip_String;
            cell.city_ans_label.text = billingdataObj.buh_city_String;
            cell.state_ans_label.text = billingdataObj.buh_state_String;
            cell.requestor_ans_label.text = appDelegate.createdByString;
        }
        
        [cell.edit_button setTag:indexPath.section];
        [cell.edit_button addTarget:self action:@selector(editButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
    }else if(indexPath.section == 1){
        
        NSString *openToPublicStr;
        NSString *recorededORBroadcastStr;
        NSString *otherServicesStr;
        
        cell.descriptionTextview.hidden = FALSE;
        cell.descriptionTextview.editable = NO;
        
        cell.section_label.text =  NSLocalizedStringFromTable(@"event_details", TABLE, nil);
        cell.requestor_label.text =  NSLocalizedStringFromTable(@"event_name", TABLE, nil);
        cell.unitacNumber_label.text =  NSLocalizedStringFromTable(@"event_type", TABLE, nil);
        cell.firstName_label.text =  NSLocalizedStringFromTable(@"open_toPublic", TABLE, nil);
        cell.lastName_label.text =  NSLocalizedStringFromTable(@"course_id", TABLE, nil);
        cell.email_label.text =  NSLocalizedStringFromTable(@"dress_Code", TABLE, nil);
        cell.zip_label.text =  NSLocalizedStringFromTable(@"recorede_braoadcast", TABLE, nil);
        cell.address1_label.text =  NSLocalizedStringFromTable(@"other_technologies", TABLE, nil);
        cell.address2_label.text =  NSLocalizedStringFromTable(@"other_services", TABLE, nil);
        cell.city_label.text =  NSLocalizedStringFromTable(@"description", TABLE, nil);
        cell.state_label.hidden = YES;
        
        
        if([appDelegate.chooseRequest_ID_String length] > 0 && ![appDelegate.chooseRequest_ID_String isEqualToString:@"0"]){
            NSMutableArray *chooseReqDetailedArray=[[GISStoreManager sharedManager]getChooseRequestDetailsObjects];
            if (chooseReqDetailedArray.count>0) {
                _chooseRequestDetailsObj=[chooseReqDetailedArray lastObject];
            }
            NSString *eventCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_EVENT_TYPE;"];
            NSString *dressCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_DRESS_CODE;"];
            
            _eventTypeArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:eventCode_statement];
            _dresscodeArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:dressCode_statement];
            
            for (GISDropDownsObject *dropDownObj in _eventTypeArray) {
                if ([dropDownObj.id_String isEqualToString:_chooseRequestDetailsObj.eventTypeID_String_chooseReqParsedDetails]) {
                    cell.unitacNumber_ans_label.text = dropDownObj.value_String;
                }
            }
            
            for (GISDropDownsObject *dropDownObj in _dresscodeArray) {
                if ([dropDownObj.id_String isEqualToString:_chooseRequestDetailsObj.dressCodeID_String_chooseReqParsedDetails]) {
                    cell.email_ans_label.text = dropDownObj.value_String;
                }
            }
            NSMutableString *otherArrayString = [[NSMutableString alloc] init];
            [otherArrayString setString:@""];
            
            if([_chooseRequestDetailsObj.otherTechnologies_String_chooseReqParsedDetails length]>0){
                NSArray *otherArray = [_chooseRequestDetailsObj.otherTechnologies_String_chooseReqParsedDetails componentsSeparatedByString:@","];
                
                for(int i=0;i<[otherArray count];i++){
                    if([[otherArray objectAtIndex:i] isEqualToString:@"1"]){
                        
                        [otherArrayString appendString:@"FMSystem,"];
                    }
                    if([[otherArray objectAtIndex:i] isEqualToString:@"2"]){
                        
                        [otherArrayString appendString:@"MicroPhone,"];
                    }
                    if([[otherArray objectAtIndex:i] isEqualToString:@"3"]){
                        
                        [otherArrayString appendString:@"Phone Conferencing,"];
                    }
                    if([[otherArray objectAtIndex:i] isEqualToString:@"4"]){
                        
                        [otherArrayString appendString:@"Webinar "];
                    }
                }
            }
            
            if([_chooseRequestDetailsObj.recBroadcast_String_chooseReqParsedDetails isEqualToString:@"true"])
                recorededORBroadcastStr = @"Yes";
            else if([_chooseRequestDetailsObj.recBroadcast_String_chooseReqParsedDetails isEqualToString:@"false"])
                recorededORBroadcastStr = @"NO";

            if([_chooseRequestDetailsObj.openToPublic_String_chooseReqParsedDetails isEqualToString:@"true"])
                openToPublicStr = @"Yes";
            else if([_chooseRequestDetailsObj.openToPublic_String_chooseReqParsedDetails isEqualToString:@"false"])
                openToPublicStr = @"No";
            
            if([_chooseRequestDetailsObj.OtherServiceID_String_chooseReqParsedDetails isEqualToString:@"1"]){
                
                otherServicesStr = @"Captioning";
            }else if([_chooseRequestDetailsObj.OtherServiceID_String_chooseReqParsedDetails isEqualToString:@"2"]){
                otherServicesStr = @"VRI";
            }
            
            cell.requestor_ans_label.text = _chooseRequestDetailsObj.eventName_String_chooseReqParsedDetails;
            cell.zip_ans_label.text = recorededORBroadcastStr;
            cell.descriptionTextview.text = _chooseRequestDetailsObj.eventDescription_String_chooseReqParsedDetails;
            cell.lastName_ans_label.text = _chooseRequestDetailsObj.courseID_String_chooseReqParsedDetails;
            cell.firstName_ans_label.text = openToPublicStr;
            cell.address1_ans_label.text = otherArrayString;
            cell.address2_ans_label.text = otherServicesStr;
        }
        [cell.edit_button setTag:indexPath.section];
        [cell.edit_button addTarget:self action:@selector(editButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
    }else if(indexPath.section == 2){
        
        GISSummaryAttendeesCell *summarycell=(GISSummaryAttendeesCell *)[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if(summarycell==nil)
        {
            summarycell=[[[NSBundle mainBundle]loadNibNamed:@"GISSummaryAttendeesCell" owner:self options:nil]objectAtIndex:0];
        }

    
        GISAttendees_ListObject *attendeesObj;
        @try {
            attendeesObj = [appDelegate.attendeesArray objectAtIndex:indexPath.row];
        }
        @catch (NSException *exception) {
            [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in SummaryView CellForRowAtIndexPath section 3--> %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
        }
        //cell.requestor_label.text = [NSString stringWithFormat:@"%d",(int)indexPath.row +1];
        
        summarycell.firstName_label.text =  NSLocalizedStringFromTable(@"first_name", TABLE, nil);
        summarycell.lastName_label .text =  NSLocalizedStringFromTable(@"last_name", TABLE, nil);
        summarycell.modeOf_communication_label.text =  NSLocalizedStringFromTable(@"mode_of_communication", TABLE, nil);
        summarycell.directly_utilized_label.text =  NSLocalizedStringFromTable(@"directly_utilized_Services", TABLE, nil);
        summarycell.email_label.text =  NSLocalizedStringFromTable(@"service_Needed", TABLE, nil);
        summarycell.other_services_label.text =  NSLocalizedStringFromTable(@"email", TABLE, nil);
        
        summarycell.firstName_ans_label.text = attendeesObj.firstname_String;
        summarycell.lastName_ans_label.text = attendeesObj.lastname_String;
        summarycell.modeOf_communication_ans_label.text = attendeesObj.modeOf_String;
        summarycell.directly_utilized_ans_label.text = attendeesObj.directly_utilzed_String;
        summarycell.email_ans_label.text = attendeesObj.servicesNeeded_String;
        summarycell.other_services_ans_label.text = attendeesObj.email_String;
        
        summarycell.attendee_count_label.text = [NSString stringWithFormat:@"%d" ,indexPath.row+1];
        
        summarycell.selectionStyle=UITableViewCellSelectionStyleNone;
     
        return summarycell;
    }else if(indexPath.section == 3){
        
        NSMutableArray *chooseReqDetailedArray=[[GISStoreManager sharedManager]getChooseRequestDetailsObjects];
        if (chooseReqDetailedArray.count>0) {
            _chooseRequestDetailsObj=[chooseReqDetailedArray lastObject];
        }
        
        NSString *buildingName_statement = [[NSString alloc]initWithFormat:@"select * from TBL_BUILDING_NAME  ORDER BY ID DESC;"];
        _buildingNameArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:buildingName_statement];
        
        for (GISDropDownsObject *dropDownObj in _buildingNameArray) {
            if ([dropDownObj.id_String isEqualToString:_chooseRequestDetailsObj.building_Id_String_chooseReqParsedDetails]) {
                _buildingNameString =  dropDownObj.value_String;
            }
        }
        NSString *generalLocation_statement = [[NSString alloc]initWithFormat:@"select * from TBL_GENERAL_LOCATION  ORDER BY ID DESC;"];
        _generalLocationArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:generalLocation_statement];
        
        for (GISDropDownsObject *dropDownObj in _generalLocationArray) {
            if ([dropDownObj.id_String isEqualToString:_chooseRequestDetailsObj.generalLocation_String_chooseReqParsedDetails]) {
                _generalLocationId_string=dropDownObj.id_String;
                _generalLocationValue_string = dropDownObj.value_String;
            }
        }
        
        NSString *closestMetro_statement = [[NSString alloc]initWithFormat:@"select * from TBL_CLOSEST_METRO  ORDER BY ID DESC;"];
        _closestMetroArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:closestMetro_statement];
        
        for (GISDropDownsObject *dropDownObj in _closestMetroArray) {
            if ([dropDownObj.id_String isEqualToString:_chooseRequestDetailsObj.ClosestMetro_String_chooseReqParsedDetails]) {
                _closestMetroId_string=dropDownObj.id_String;
                _closestMetroValue_string = dropDownObj.value_String;
            }
        }
        
        cell.section_label.text =  NSLocalizedStringFromTable(@"location_Details", TABLE, nil);
        
        if ([_generalLocationId_string isEqualToString:@"1"]) {
            
            cell.requestor_label.text = @"Room Number :";
            cell.unitacNumber_label.text = @"Building Name :";
            cell.firstName_label.text = @"General Location :";
            cell.lastName_label.text = @"Room Name :";
            cell.email_label.text = @"Other :";
            
            if([appDelegate.chooseRequest_ID_String length] > 0 && ![appDelegate.chooseRequest_ID_String isEqualToString:@"0"]){
                cell.requestor_ans_label.text = _chooseRequestDetailsObj.RoomNunber_String_chooseReqParsedDetails;
                cell.unitacNumber_ans_label.text = _buildingNameString;
                cell.firstName_ans_label.text = _generalLocationValue_string;
                cell.lastName_ans_label.text = _chooseRequestDetailsObj.RoomName_String_chooseReqParsedDetails;
                cell.email_ans_label.text = _chooseRequestDetailsObj.other_String_chooseReqParsedDetails;
            }
            
            cell.address1_label.hidden = YES;
            cell.address2_label.hidden = YES;
            cell.city_label.hidden = YES;
            cell.state_label.hidden = YES;
            cell.zip_label.hidden = YES;
            
            
        }else{

            cell.requestor_label.text = @"Store Location :";
            cell.unitacNumber_label.text = @"General Location :";
            cell.firstName_label.text = @"Address1 :";
            cell.lastName_label.text = @"Address2 :";
            cell.email_label.text = @"City :";
            cell.address1_label.text = @"Zip :";
            cell.zip_label.text = @"State :";
            cell.address2_label.text = @"Closest Metro :";
            
            
            if([appDelegate.chooseRequest_ID_String length] > 0 && ![appDelegate.chooseRequest_ID_String isEqualToString:@"0"]){
                cell.requestor_ans_label.text = _chooseRequestDetailsObj.offCamp_LocationName_String_chooseReqParsedDetails;
                cell.unitacNumber_ans_label.text = _generalLocationValue_string;
                cell.firstName_ans_label.text = _chooseRequestDetailsObj.offCamp_address1_String_chooseReqParsedDetails;
                cell.lastName_ans_label.text = _chooseRequestDetailsObj.offCamp_address2_String_chooseReqParsedDetails;
                cell.email_ans_label.text = _chooseRequestDetailsObj.offCamp_city_String_chooseReqParsedDetails;
                cell.address1_ans_label.text = _chooseRequestDetailsObj.offCamp_zip_String_chooseReqParsedDetails;
                cell.zip_ans_label.text = _chooseRequestDetailsObj.offCamp_state_String_chooseReqParsedDetails;
                 cell.address2_ans_label.text = _closestMetroValue_string;
            }
            
            cell.address2_label.hidden = NO;
            cell.city_label.hidden = NO;
            cell.state_label.hidden = NO;
            cell.zip_label.hidden = NO;

            
        }
        
        [cell.edit_button setTag:indexPath.section];
        [cell.edit_button addTarget:self action:@selector(editButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

    }else if(indexPath.section == 4){

        GISSummaryDatesDetailViewCell *summaryDatescell=(GISSummaryDatesDetailViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell19"];

        if(summaryDatescell==nil)
        {
            summaryDatescell=[[[NSBundle mainBundle]loadNibNamed:@"GISSummaryDatesDetailViewCell" owner:self options:nil]objectAtIndex:0];
        }
        
        
        GISDatesAndTimesObject *datesAndTimesObj;
        @try {
            datesAndTimesObj = [appDelegate.datesArray objectAtIndex:indexPath.row];
        }
        @catch (NSException *exception) {
            [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in SummaryView CellForRowAtIndexPath section 3--> %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
        }
 
        summaryDatescell.date_label.text = [GISUtility returningstring:datesAndTimesObj.day_String];
        summaryDatescell.day_label.text = [GISUtility returningstring:datesAndTimesObj.date_String];
        summaryDatescell.startTime_label.text =[GISUtility returningstring:datesAndTimesObj.startTime_String];
        summaryDatescell.endTime_label.text = [GISUtility returningstring:datesAndTimesObj.endTime_String];

        
        summaryDatescell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return summaryDatescell;

        
    } if(indexPath.section == 5){
        
        GISJobDetailsCell *cell=(GISJobDetailsCell *)[tableView dequeueReusableCellWithIdentifier:@"cell86"];
        
        if(cell==nil)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISJobDetailsCell" owner:self options:nil]objectAtIndex:0];
        }
        
        GISJobDetailsObject *temp_obj_jobDetails=[appDelegate.jobDetailsArray objectAtIndex:indexPath.row];
        cell.job_ID_Label.text=temp_obj_jobDetails.jobNumber_string;
        cell.job_date_Label.text=temp_obj_jobDetails.jobDate_string;
        cell.start_time_Label.text=temp_obj_jobDetails.startTime_string;
        cell.end_time_Label.text=temp_obj_jobDetails.endTime_string;
        cell.typeOf_service_Label.text=temp_obj_jobDetails.typeOfService_string;
        cell.service_provider_Label.text=temp_obj_jobDetails.serviceProvider_string;
        cell.payType_Label.text=temp_obj_jobDetails.payType_string;
        cell.timely_Label.text=temp_obj_jobDetails.timely_string;
        cell.billAmt_Label.text=temp_obj_jobDetails.billAmount_string;
        
        cell.typeOf_service_UIView.hidden = YES;
        cell.serviceProvider_UIView.hidden = YES;
        cell.payType_UIView.hidden = YES;
        cell.editButton.hidden = YES;
        cell.edit_imageView.hidden = YES;
        [cell.deleteButton addTarget:self action:@selector(deleteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [cell.deleteButton setTag:indexPath.row];
        
        return cell;
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* headerView;
    
    if(section == 4){
        
        UIView *headerView1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
        
        NSArray *datesViewArray =  [[NSBundle mainBundle] loadNibNamed:@"GISSummaryDatesAndTimesCell" owner:self options:nil];
        
        UIView *datesView = [datesViewArray lastObject];

        
        UIButton *edit_button = (UIButton *)[datesView viewWithTag:555];
        [edit_button setTag:section];
        [edit_button addTarget:self action:@selector(editButtonPressed:) forControlEvents:UIControlEventTouchUpInside];


        [headerView1 addSubview:datesView];
        
        return headerView1;
        
    }else  if(section == 5){
        
        UIView *headerView1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
        
        NSArray *jobDetailsViewArray =  [[NSBundle mainBundle] loadNibNamed:@"GISSummaryJobDetailsCell" owner:self options:nil];
        
        UIView *jobsView = [jobDetailsViewArray lastObject];
        
        
        UIButton *edit_button = (UIButton *)[jobsView viewWithTag:556];
        [edit_button setTag:section];
        [edit_button addTarget:self action:@selector(editButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [headerView1 addSubview:jobsView];
        
        return headerView1;
        
    }
    else if(section == 2){
        headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
        UILabel* headerLabel = [[UILabel alloc] init];
        headerLabel.frame = CGRectMake(8, 0, 320, 20);
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.textColor = UIColorFromRGB(0x00457c);
        headerLabel.font = [GISFonts large];
        [headerLabel setTextAlignment:NSTextAlignmentLeft];
        headerLabel.text = NSLocalizedStringFromTable(@"attendees", TABLE, nil);
        [headerView addSubview:headerLabel];
        
        UIView *leftLine_view=[[UIView alloc]init];
        
        leftLine_view.backgroundColor=UIColorFromRGB(0xDEDEDE);
        
        headerLabel.textColor = UIColorFromRGB(0x00457c);
        leftLine_view.frame=CGRectMake(8, headerLabel.frame.size.height+headerLabel.frame.origin.y+10, 693, 2);
        [headerView addSubview:leftLine_view];
        
        
        UIButton *infoButton = [[UIButton alloc] init];
        infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [infoButton setBackgroundImage:[UIImage imageNamed:@"summary_edit.png"] forState:UIControlStateNormal];
        infoButton.frame = CGRectMake(678, 0.0, 17.0, 17.0);
        [infoButton setTag:2];
        [infoButton addTarget:self action:@selector(editButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:infoButton];
        
    }if(section == 6){
        
        UIView *headerView2=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
        
        UIButton *addButton1 = [[UIButton alloc] init];
        addButton1 = [UIButton buttonWithType:UIButtonTypeCustom];

        
        if(!appDelegate.isNewRequest){
            
            [addButton1 setBackgroundImage:[UIImage imageNamed:@"choose_request_bg.png"] forState:UIControlStateNormal];
            [addButton1 addTarget:self
                          action:@selector(showPopoverDetails:)
                forControlEvents:UIControlEventTouchUpInside];
            addButton1.frame = CGRectMake(294, 60.0, 150.0, 27.0);
            addButton1 .contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
            [addButton1.titleLabel setFont:[GISFonts small]];
            [addButton1 setTitleColor:UIColorFromRGB(0x616161) forState:UIControlStateNormal];
            [addButton1 setTitle:serviceRequestData forState:UIControlStateNormal];
            [addButton1 setTag:11115];
            [headerView2 addSubview:addButton1];
            
            UIButton *nextButton = [[UIButton alloc] init];
            nextButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [nextButton addTarget:self
                           action:@selector(nextButtonPressed:)
                 forControlEvents:UIControlEventTouchUpInside];
            nextButton.frame = CGRectMake(470.0, 60.0, 120.0, 30.0);
            
            
            [nextButton setTitle:NSLocalizedStringFromTable(@"next",TABLE, nil) forState:UIControlStateNormal];
            [nextButton setTitleColor:UIColorFromRGB(0xe8d4a2) forState:UIControlStateNormal];
            nextButton.titleLabel.font=[GISFonts larger];
            [nextButton.layer setCornerRadius:3.0f];
            [nextButton setTag:5588];
            [nextButton setEnabled:FALSE];
            nextButton.backgroundColor=[UIColor grayColor];
            [headerView2 addSubview:nextButton];

        }else{
            addButton1.backgroundColor=UIColorFromRGB(0x01971c);
            [addButton1 setTitle:@"Submit to GIS" forState:UIControlStateNormal];
            [addButton1 setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
            [addButton1.layer setCornerRadius:5.0f];
            addButton1.titleLabel.font=[GISFonts larger];
            [addButton1 addTarget:self
                           action:@selector(submitButnPressed:)
                 forControlEvents:UIControlEventTouchUpInside];
            addButton1.frame = CGRectMake(350.0, 60.0, 150.0, 30.0);
            [addButton1 setTag:11116];
            addButton1.enabled = YES;
            
            
            if ([_chooseRequestDetailsObj.isCompleteRequest_String_chooseReqParsedDetails isEqualToString:@"true"]) {
                
                if(!isCheckMark){
                    addButton1.enabled = NO;
                    addButton1.backgroundColor=[UIColor grayColor];
                }
            }
            
            [headerView2 addSubview:addButton1];
        }
        
        return headerView2;
    }

    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 2)
        return 35;
    if(section == 4)
        return 50;
    if(section == 6)
        return 100;
    if(section == 5){
        if(appDelegate.isNewRequest)
            return 0;
        
        return 50;
    }

    return 0;
}

-(void)nextButtonPressed:(id)sender{
    
    if(!appDelegate.isNewRequest){
        
        UIButton *nextbutton=(UIButton *)sender;
        
        @try {
            
            if([appDelegate.jobDetailsArray count] == 0){
                [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_cannnot_submitted",TABLE, nil)];
                return;
            }
            
            
            isSubmitClicked = YES;
            
            NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
            NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
            GISLoginDetailsObject *unitObj1=[requetId_array lastObject];
            NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
            [paramsDict setObject:appDelegate.chooseRequest_ID_String forKey:kDateTime_requestNo];
            [paramsDict setObject:unitObj1.token_string forKey:kToken];
            NSString *status_ID;
            if([nextbutton.titleLabel.text isEqualToString:@"OnHold"]){
                status_ID = @"5";
                [paramsDict setObject:status_ID forKey:kstatusid];
            }else{
                [paramsDict setObject:@"1" forKey:kstatusid];
            }
            
            [[GISServerManager sharedManager] submitViewEditRequest:self withParams:paramsDict finishAction:@selector(successmethod_submitVieweditRequest:) failAction:@selector(failuremethod_submitVieweditRequest:)];
        }
        @catch (NSException *exception) {
            [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in get summary submit action %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
        }
        
        NSDictionary *infoDict=[NSDictionary dictionaryWithObjectsAndKeys:@"6",@"tabValue",[NSNumber numberWithBool:YES],@"isFromContacts",nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:kTabSelected object:nil userInfo:infoDict];
    }else{
        NSDictionary *infoDict=[NSDictionary dictionaryWithObjectsAndKeys:@"5",@"tabValue",[NSNumber numberWithBool:YES],@"isFromContacts",nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:kTabSelected object:nil userInfo:infoDict];
        isSubmitClicked = NO;
    }
}

-(void)submitButnPressed:(id)sender{
    
    @try {
        
        if([sender tag] == 11116){
            NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
            NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
            GISLoginDetailsObject *unitObj1=[requetId_array lastObject];
            NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
            [paramsDict setObject:appDelegate.chooseRequest_ID_String forKey:kDateTime_requestNo];
            [paramsDict setObject:unitObj1.token_string forKey:kToken];
            NSString *status_ID;
            status_ID = @"1";
            [paramsDict setObject:status_ID forKey:kstatusid];
            
            [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
            
            [[GISServerManager sharedManager] saveUpdateRequestData:self withParams:paramsDict finishAction:@selector(successmethod_saveUpdateRequest:) failAction:@selector(failuremethod_saveUpdateRequest:)];
        }
    }
    @catch (NSException *exception) {
        [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in get summary submit action %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
    }
}

-(void)successmethod_saveUpdateRequest:(GISJsonRequest *)response
{
    //id json =response.responseJson;
    
    NSDictionary *saveUpdateDict;
    
    NSArray *responseArray= response.responseJson;
    saveUpdateDict = [responseArray lastObject];
    if (![[saveUpdateDict objectForKey:kStatusCode] isEqualToString:@"400"]) {
        
        [self removeLoadingView];
        
        isRequestSubmitted=YES;
        [_summary_tableView reloadData];
        [GISUtility showAlertWithTitle:@"" andMessage:@"Request Submit Successfully"];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:kRequestInfo object:nil];
        
        NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
        NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
        GISLoginDetailsObject *unitObj1=[requetId_array lastObject];
        NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
        [paramsDict setObject:_choose_req_Id_string forKey:kID];
        [paramsDict setObject:unitObj1.token_string forKey:kToken];
        
        [[GISServerManager sharedManager] getEventDetailsData:self withParams:paramsDict finishAction:@selector(successmethod_getRequestDetails:) failAction:@selector(failuremethod_getRequestDetails:)];

    }
    if ([[saveUpdateDict objectForKey:kStatusCode] isEqualToString:@"400"]) {
        
        [self removeLoadingView];
        [GISUtility showAlertWithTitle:@"" andMessage:@"Request Submit failed"];
    }
}

-(void)failuremethod_saveUpdateRequest:(GISJsonRequest *)response
{
    [GISUtility showAlertWithTitle:@"" andMessage:@"Error with Request Submit"];
    NSLog(@"Failure");
    [self removeLoadingView];
}

-(void)successmethod_getRequestEventDetails:(GISJsonRequest *)response
{
    NSLog(@"successmethod_getRequestDetails Success---%@",response.responseJson);
    
    NSDictionary *saveUpdateDict;
    NSArray *responseArray= response.responseJson;
    saveUpdateDict = [responseArray lastObject];
    
    if ([[saveUpdateDict objectForKey:kStatusCode] isEqualToString:@"200"]) {
        
        [self removeLoadingView];
        [[GISStoreManager sharedManager] removeChooseRequestDetailsObjects];
        _chooseRequestDetailsObj=[[GISChooseRequestDetailsObject alloc]initWithStoreChooseRequestDetailsDictionary:response.responseJson];
        [[GISStoreManager sharedManager]addChooseRequestDetailsObject:_chooseRequestDetailsObj];
        if ([_chooseRequestDetailsObj.requestStatus_String_chooseReqParsedDetails isEqualToString:@"In-Complete"]) {
            isRequestSubmitted=NO;
        }
        else if ([_chooseRequestDetailsObj.requestStatus_String_chooseReqParsedDetails isEqualToString:@"Completed"]) {
            isRequestSubmitted=YES;
        }
    }else{
        [self removeLoadingView];
    }
}

-(void)failuremethod_getRequestEventDetails:(GISJsonRequest *)response
{
    NSLog(@"Failure");
    
    [self removeLoadingView];
    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
}

-(void)checkMark_buttonClicked
{
    if (isCheckMark)
        isCheckMark=NO;
    else
        isCheckMark=YES;
    
    [_summary_tableView reloadData];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    NSDictionary *infoDict=[NSDictionary dictionaryWithObjectsAndKeys:@"-210",@"yValue",nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:kMoveUp object:nil userInfo:infoDict];
    
    if ([textView.text isEqualToString:@"Add Notes"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    [textView becomeFirstResponder];
    
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
   
    NSDictionary *infoDict=[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"yValue",nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:kMoveUp object:nil userInfo:infoDict];
    
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Add Notes";
        textView.textColor = UIColorFromRGB(0x00457c);
    }
    [textView resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSCharacterSet *doneButtonCharacterSet = [NSCharacterSet newlineCharacterSet];
    NSRange replacementTextRange = [text rangeOfCharacterFromSet:doneButtonCharacterSet];
    NSUInteger location = replacementTextRange.location;
    
    if (textView.text.length + text.length > 140){
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

-(void)successmethod_getRequestDetails:(GISJsonRequest *)response
{
    NSLog(@"successmethod_getRequestDetails Success---%@",response.responseJson);
    
    NSDictionary *saveUpdateDict;
    NSArray *responseArray= response.responseJson;
    saveUpdateDict = [responseArray lastObject];
    
    if ([[saveUpdateDict objectForKey:kStatusCode] isEqualToString:@"200"]) {
        
        [[GISStoreManager sharedManager] removeChooseRequestDetailsObjects];
        _chooseRequestDetailsObj=[[GISChooseRequestDetailsObject alloc]initWithStoreChooseRequestDetailsDictionary:response.responseJson];
        [[GISStoreManager sharedManager]addChooseRequestDetailsObject:_chooseRequestDetailsObj];
        
        appDelegate.createdDateString = _chooseRequestDetailsObj.createdDate_String_chooseReqParsedDetails;
        appDelegate.createdByString = [NSString stringWithFormat:@"%@ %@", _chooseRequestDetailsObj.reqFirstName_String_chooseReqParsedDetails,_chooseRequestDetailsObj.reqLastName_String_chooseReqParsedDetails];
        appDelegate.statusString = _chooseRequestDetailsObj.requestStatus_String_chooseReqParsedDetails;
        
        [[NSNotificationCenter defaultCenter]postNotificationName:kRequestInfo object:nil];
        
        NSMutableDictionary *paramsDicts=[[NSMutableDictionary alloc]init];
        [paramsDicts setObject:_chooseRequestDetailsObj.unitID_String_chooseReqParsedDetails forKey:kID];
        [paramsDicts setObject:loginObJ.token_string forKey:kToken];
        [[GISServerManager sharedManager] getBillingsData:self withParams:paramsDicts finishAction:@selector(successmethod_BillingsData:) failAction:@selector(failuremethod_BillingsData:)];

    }else{
        
        [self removeLoadingView];
        [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
    }
}

-(void)failuremethod_getRequestDetails:(GISJsonRequest *)response
{
    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
    NSLog(@"Failure");
    [self removeLoadingView];
}

-(void)successmethod_BillingsData:(GISJsonRequest *)response
{
    NSLog(@"Success---%@----",response.responseJson);
    
    NSDictionary *saveUpdateDict;
    
    NSArray *responseArray= response.responseJson;
    saveUpdateDict = [responseArray lastObject];
    if ([[saveUpdateDict objectForKey:kStatusCode] isEqualToString:@"400"]) {
        
        [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
        
    }else{
        
        [self loadTableWithBuildingdata:response.responseJson];
    }
}

-(void)failuremethod_BillingsData:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"Failure");
    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
}

-(void)loadTableWithBuildingdata:(id)sender
{
    [[GISStoreManager sharedManager]removeBillingDataObjects];
    GISBilingDataObject *billingDataObj=[[GISBilingDataObject alloc]initWithStoreBillingDataDictionary:sender];
    [[GISStoreManager sharedManager]addBillingDataObject:billingDataObj];
    
    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
    
    [paramsDict setObject:appDelegate.chooseRequest_ID_String forKey:kID];
    [paramsDict setObject:loginObJ.token_string forKey:kToken];
    
    [[GISServerManager sharedManager] getAttendees_Details_Data:self withParams:paramsDict finishAction:@selector(successmethod_get_Attendees_Details:) failAction:@selector(failuremethod_get_Attendees_Details:)];
    
}

- (IBAction)showPopoverDetails:(id)sender{
    
    UITableView *table = (UITableView*)[[[[[sender superview] superview] superview] superview] superview];
    
    GISPopOverTableViewController *tableViewController = [[GISPopOverTableViewController alloc] initWithNibName:@"GISPopOverTableViewController" bundle:nil];
    
    
    tableViewController.popOverDelegate = self;
    
    if([appDelegate.statusString isEqualToString:@"Approved"])
        _popover =   [GISUtility showPopOver:(NSMutableArray *)_serviceTypeSaveArray viewController:tableViewController];
    else
         _popover =   [GISUtility showPopOver:(NSMutableArray *)_serviceTypeArray viewController:tableViewController];
    
    _popover.delegate = self;
    _popover.popoverContentSize = CGSizeMake(300, 100);
    
    
    if (_popover) {
        [_popover dismissPopoverAnimated:YES];
    }
    
    [_popover presentPopoverFromRect:CGRectMake(415, table.frame.origin.y+table.frame.size.height-30, 1, 1) inView:table permittedArrowDirections:UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown animated:YES];
    
}

-(void)sendTheSelectedPopOverData:(NSString *)id_str value:(NSString *)value_str
{
    //eventTypedata= value_str;
    
//    CGSize stringsize = [value_str sizeWithAttributes:<#(NSDictionary *)#>:[GISFonts normal]];
//    //or whatever font you're using
//    [button setFrame:CGRectMake(10,0,stringsize.width, stringsize.height)];
    UIButton *serviceTypeBtn=(UIButton *)[self.view viewWithTag:11115];
    UIButton *nextBtn=(UIButton *)[self.view viewWithTag:5588];
    [serviceTypeBtn setTitle:value_str forState:UIControlStateNormal];
    [nextBtn setTitle:value_str forState:UIControlStateNormal];
    [nextBtn setEnabled:YES];
    nextBtn.backgroundColor=UIColorFromRGB(0x00457c);
    
    nextString = value_str;

    //_eventTypeId_string=id_str;

    if(_popover)
        [_popover dismissPopoverAnimated:YES];
    
    // [_eventDetaislTabelView reloadData];
    
}

-(IBAction)editButtonPressed:(id)sender{
    
    NSDictionary *infoDict=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",[sender tag]],@"tabValue",nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:kTabSelected object:nil userInfo:infoDict];
}

-(void)successmethod_submitVieweditRequest:(GISJsonRequest *)response
{    
    NSDictionary *saveUpdateDict;
    
    NSArray *responseArray= response.responseJson;
    saveUpdateDict = [responseArray lastObject];
    if (![[saveUpdateDict objectForKey:kStatusCode] isEqualToString:@"400"]) {
        
        [GISUtility showAlertWithTitle:@"" andMessage:[NSString stringWithFormat:@"Request %@ Successfully",nextString]];
    }
    if ([[saveUpdateDict objectForKey:kStatusCode] isEqualToString:@"400"]) {
        
        [GISUtility showAlertWithTitle:@"" andMessage:[NSString stringWithFormat:@"Request %@ failed",nextString]];
    }
}

-(void)failuremethod_submitVieweditRequest:(GISJsonRequest *)response
{
    UIButton *nextBtn=(UIButton *)[self.view viewWithTag:5588];
    [GISUtility showAlertWithTitle:@"" andMessage:[NSString stringWithFormat:@"Error with Request %@",nextBtn.titleLabel.text]];
    NSLog(@"Failure");
    [self removeLoadingView];
}

-(void)selectedChooseRequestNumber:(NSNotification*)notification
{
    NSDictionary *dict=[notification userInfo];

    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
    [paramsDict setObject:appDelegate.chooseRequest_ID_String forKey:kID];
    [paramsDict setObject:loginObJ.token_string forKey:kToken];
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults synchronize];
    [userDefaults setValue:[dict valueForKey:@"value"] forKey:kDropDownValue];
    [userDefaults setValue:[dict valueForKey:@"id"] forKey:kDropDownID];
    
    [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
    
    [[GISServerManager sharedManager] getEventDetailsData:self withParams:paramsDict finishAction:@selector(successmethod_getRequestDetails:) failAction:@selector(failuremethod_getRequestDetails:)];
    
}

-(void)successmethod_get_Attendees_Details:(GISJsonRequest *)response
{
    NSDictionary *saveUpdateDict;
    GISAttendeesDetailsStore *store;
    NSArray *responseArray= response.responseJson;
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];

    
    if([responseArray count]>0){
        
        saveUpdateDict = [responseArray lastObject];
        
        if ([[saveUpdateDict objectForKey:kStatusCode] isEqualToString:@"200"]) {
            
            NSLog(@"successmethod_get_Attendees_Details Success---%@",response.responseJson);
            [[GISStoreManager sharedManager]removeAttendees_Details_Objects];
            store =[[GISAttendeesDetailsStore alloc]initWithStoreDictionary:response.responseJson];
            NSArray *attendeesList_mutArray= [[GISStoreManager sharedManager]getAttendees_Details_Objects];
            
            if([appDelegate.attendeesArray count]>0)
                [appDelegate.attendeesArray removeAllObjects];
            [appDelegate.attendeesArray addObjectsFromArray:attendeesList_mutArray];
        }
    }else{
        
        if([appDelegate.attendeesArray count]>0)
            [appDelegate.attendeesArray removeAllObjects];
        //[self removeLoadingView];
    }
    
    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
    [paramsDict setObject:[userDefaults valueForKey:kDropDownID] forKey:kID];
    [paramsDict setObject:loginObJ.token_string forKey:kToken];
    
    [[GISServerManager sharedManager] getDateTimeDetails:self withParams:paramsDict finishAction:@selector(successmethod_get_Date_Time:) failAction:@selector(failuremethod_get_Date_Time:)];


}
-(void)failuremethod_get_Attendees_Details:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"Failure");
    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
}

-(void)successmethod_get_Date_Time:(GISJsonRequest *)response
{
    NSLog(@"successmethod_get_Date_Time Success---%@",response.responseJson);
    
    NSDictionary *saveUpdateDict;
    GISDatesTimesDetailStore *store;

    NSArray *responseArray= response.responseJson;
    saveUpdateDict = [responseArray lastObject];
    
    if ([[saveUpdateDict objectForKey:kStatusCode] isEqualToString:@"200"]) {
        
        [[GISStoreManager sharedManager]removeDateTimes_detail_Objects];
        store=[[GISDatesTimesDetailStore alloc]initWithStoreDictionary:response.responseJson];
        detail_mut_array= [[GISStoreManager sharedManager]getDateTimes_detail_Objects];
        
        [self sortTheDatesAndTimes];
    
        if([appDelegate.datesArray count]>0)
            [appDelegate.datesArray removeAllObjects];
        [appDelegate.datesArray addObjectsFromArray:detail_mut_array];
        
        GISDatesAndTimesObject *dobj=[[GISDatesAndTimesObject alloc]init];
        [appDelegate.datesArray insertObject:dobj atIndex:0];
        
        NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
        [paramsDict setObject:appDelegate.chooseRequest_ID_String forKey:KRequestId];
        [paramsDict setObject:loginObJ.token_string forKey:kToken];
        [[GISServerManager sharedManager] getJobDetails_data:self withParams:paramsDict finishAction:@selector(successmethod_getJobDetails_data:) failAction:@selector(failuremethod_getJobDetails_data:)];
    }
    else{
        
        [self removeLoadingView];
        [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
    }
}


-(void)failuremethod_get_Date_Time:(GISJsonRequest *)response
{
    NSLog(@"Failure");
    [self removeLoadingView];
    [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
    
}

-(void)successmethod_getJobDetails_data:(GISJsonRequest *)response
{
    NSDictionary *saveUpdateDict;
    NSArray *responseArray= response.responseJson;
    NSMutableArray *jobDetails_Array = [[NSMutableArray alloc] init];
    
    if([appDelegate.jobDetailsArray count]>0)
        [appDelegate.jobDetailsArray removeAllObjects];
    
    if([responseArray count]>0){
        saveUpdateDict = [responseArray lastObject];
        
        if ([[saveUpdateDict objectForKey:kStatusCode] isEqualToString:@"200"]) {
            
            NSLog(@"successmethod_getJobDetails_data Success---%@",response.responseJson);
            [[GISStoreManager sharedManager]removeJobDetailsObjects];
            GISJobDetailsStore *jobDetailsStore;
            jobDetailsStore=[[GISJobDetailsStore alloc]initWithJsonDictionary:response.responseJson];
           [jobDetails_Array addObjectsFromArray:[[GISStoreManager sharedManager]getJobDetailsObjects]];
            
            [appDelegate.jobDetailsArray addObjectsFromArray:jobDetails_Array];
            
            GISJobDetailsObject *dobj=[[GISJobDetailsObject alloc]init];
            [appDelegate.jobDetailsArray insertObject:dobj atIndex:0];
            
            [self removeLoadingView];
            [_summary_tableView reloadData];
            
        }
        else{
            
            [self removeLoadingView];
            [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
        }
    }else{
        [self removeLoadingView];
        [_summary_tableView reloadData];
    }
}

-(void)failuremethod_getJobDetails_data:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"Failure");
    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
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
        GISJobDetailsObject *jobObj = [appDelegate.jobDetailsArray objectAtIndex:alertView.tag];
        if([jobObj.jobID_string length] == 0)
        {
        }
        else
        {
            NSMutableDictionary *delete_eventdict;
            delete_eventdict=[[NSMutableDictionary alloc]init];
            
            GISJobDetailsObject *tempObj=[appDelegate.jobDetailsArray objectAtIndex:alertView.tag];
            
            [delete_eventdict setObject:tempObj.jobID_string forKey:kJobDetais_JobID];
            [delete_eventdict setObject:@"true" forKey:kJobDetais_deleteJob];
            
            [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
            [[GISServerManager sharedManager] deleteJobs:self withParams:delete_eventdict finishAction:@selector(successmethod_deleteJobs:) failAction:@selector(failuremethod_deleteJobs:)];
            
        }
    }
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
        
        [self getJobDetails_Data :[GISUtility returningstring:appDelegate.chooseRequest_ID_String] :loginObJ.token_string:@"":@"":@""];
        
    }
}
-(void)failuremethod_deleteJobs:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"Failure");
    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
}

-(void)getJobDetails_Data:(NSString *)chooseRequest_idStr :(NSString*)token :(NSString *)serviceProviderID :(NSString *)jobDate :(NSString *)filledUnfilled_str
{
    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
    [paramsDict setObject:chooseRequest_idStr forKey:KRequestId];
    [paramsDict setObject:token forKey:kToken];
    [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
    [[GISServerManager sharedManager] getJobDetails_data:self withParams:paramsDict finishAction:@selector(successmethod_getJobDetails_data:) failAction:@selector(failuremethod_getJobDetails_data:)];
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

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kselectedChooseReqNumber object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
