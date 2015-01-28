//
//  GISPopOverTableViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 21/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISPopOverTableViewController.h"
#import "GISDropDownsObject.h"
#import "GISConstants.h"
#import "GISServiceProviderObject.h"
#import "GISContactsInfoObject.h"
#import "GISDatabaseManager.h"
#import "GISJSONProperties.h"

@interface GISPopOverTableViewController ()

@end

@implementation GISPopOverTableViewController

@synthesize popOverTableView;

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
    
    self.filteredArray = [[NSMutableArray alloc] init];
}
- (void)viewWillAppear:(BOOL)animated
{
    self.preferredContentSize=popOverTableView.contentSize;
    popOverTableView.delegate = self;
    [super viewWillAppear:animated];
    
    dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MM/dd/yyyy"];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 325, 300)];
    datePicker.date = [NSDate date];
    
    if ([self.view_String isEqualToString:@"timesdates"])
    {
        datePicker.datePickerMode = UIDatePickerModeTime;
        
        [dateformatter setDateFormat:@"hh:mm a"];
        
        if ([self.dateTimeMoveUp_string length]) {
            NSDate *tempDate=[dateformatter dateFromString:self.dateTimeMoveUp_string];
            [datePicker setDate:tempDate];
        }
        else
        {
            datePicker.date=[NSDate date];
        }
        
    }
    else
    {
        datePicker.datePickerMode = UIDatePickerModeDate;

        if ([self.dateTimeMoveUp_string length]) {
            NSDate *date = [dateformatter dateFromString:self.dateTimeMoveUp_string];
            [datePicker setDate:date];
        }
        else
        {
            datePicker.date= [NSDate date];
        }
        
    }
    
    
    [datePicker addTarget:self
                   action:@selector(datePickerChange:)
         forControlEvents:UIControlEventValueChanged];
    
    if ([self.view_String isEqualToString:@"datestimes"]||[self.view_String isEqualToString:@"timesdates"]) {
        popOverTableView.scrollEnabled=NO;
        popOverSearchBar.hidden = YES;
        CGRect frame =  self.popOverView.frame;
        frame.origin.y = 0;
        frame.size.height = 250;
        self.popOverView.frame = frame;
        [self.popOver_TableView removeFromSuperview];
        [self.popOverView addSubview:datePicker];
    }else{
        
        [datePicker removeFromSuperview];
        
        if(!([[self.popOverArray lastObject] isKindOfClass:[GISDropDownsObject class]] || [[self.popOverArray lastObject] isKindOfClass:[GISContactsInfoObject class]] ||
             [[self.popOverArray lastObject] isKindOfClass:[GISServiceProviderObject class]]))
        {
            popOverSearchBar.hidden = YES;
            CGRect frame =  self.popOverView.frame;
            frame.origin.y = 0;
            frame.size.height = 210;
            self.popOverView.frame = frame;
            
        }
        if([[self.popOverArray lastObject] isKindOfClass:[GISDropDownsObject class]]){
            GISDropDownsObject *dropDownObject = [self.popOverArray lastObject];
            if ([dropDownObject.type_String isEqual:kServiceType_serviceProvider]) {
                
                popOverSearchBar.hidden = YES;
                CGRect frame =  self.popOverView.frame;
                frame.origin.y = 0;
                frame.size.height = 210;
                self.popOverView.frame = frame;

            }
        }
        
    }
}

-(void)datePickerChange:(id)sender
{
    NSLog(@"Called DateTime-->%@",datePicker.date);
    [self.popOverDelegate sendTheSelectedPopOverData:@"" value:[dateformatter stringFromDate:datePicker.date]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.view_String isEqualToString:@"datestimes"]||[self.view_String isEqualToString:@"timesdates"]) {
        return 250;
    }
    return 35;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [self.filteredArray count];
    }
    
    if ([self.view_String isEqualToString:@"datestimes"]||[self.view_String isEqualToString:@"timesdates"]) {
        return 0;
    }
    return [self.popOverArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.view_String isEqualToString:@"datestimes"]||[self.view_String isEqualToString:@"timesdates"]) {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"popOver"];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"popPver"];
        }
        [cell.contentView addSubview:datePicker];
        return cell;
    }
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"popOver"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"popPver"];
    }

    if([[self.popOverArray objectAtIndex:indexPath.row] isKindOfClass:[GISDropDownsObject class]])
    {
        GISDropDownsObject *dropDownObj;
        if (tableView == self.searchDisplayController.searchResultsTableView)
        {
            dropDownObj=[self.filteredArray objectAtIndex:indexPath.row];
        }else{
            
            dropDownObj=[self.popOverArray objectAtIndex:indexPath.row];
        }
        cell.textLabel.text=dropDownObj.value_String;
    }
    else if([[self.popOverArray objectAtIndex:indexPath.row] isKindOfClass:[GISContactsInfoObject class]])
    {
        GISContactsInfoObject *contactInfoObj;
        if (tableView == self.searchDisplayController.searchResultsTableView)
        {
            contactInfoObj=[self.filteredArray objectAtIndex:indexPath.row];
        }else{
            contactInfoObj=[self.popOverArray objectAtIndex:indexPath.row];
        }
        cell.textLabel.text=contactInfoObj.contactNo_String;
    }
    else if([[self.popOverArray objectAtIndex:indexPath.row] isKindOfClass:[GISServiceProviderObject class]])
    {
        GISServiceProviderObject *spObj;
        
        if (tableView == self.searchDisplayController.searchResultsTableView)
        {
            spObj = [self.filteredArray objectAtIndex:[indexPath row]];
        }else{
            
            spObj=[self.popOverArray objectAtIndex:indexPath.row];
            
        }
        cell.textLabel.text=spObj.service_Provider_String;
    }
    else
    {
        cell.textLabel.text=[self.popOverArray objectAtIndex:indexPath.row];

        
        self.tableHeightConstraint.constant = 80;
        [popOverTableView needsUpdateConstraints];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self.popOverArray objectAtIndex:indexPath.row] isKindOfClass:[GISDropDownsObject class]])
    {
        GISDropDownsObject *dropDownObj;
        if (tableView == self.searchDisplayController.searchResultsTableView)
        {
            dropDownObj=[self.filteredArray objectAtIndex:indexPath.row];
        }else{
            
            dropDownObj=[self.popOverArray objectAtIndex:indexPath.row];
        }
        [self.popOverDelegate sendTheSelectedPopOverData:dropDownObj.id_String value:dropDownObj.value_String];
    }
    else if([[self.popOverArray objectAtIndex:indexPath.row] isKindOfClass:[GISContactsInfoObject class]])
    {
        GISContactsInfoObject *contactInfoObj;
        if (tableView == self.searchDisplayController.searchResultsTableView)
        {
            contactInfoObj = [self.filteredArray  objectAtIndex:indexPath.row];
        }else{
            
            contactInfoObj = [self.popOverArray objectAtIndex:indexPath.row];
        }
        
        [self.popOverDelegate sendTheSelectedPopOverData:contactInfoObj.contactTypeId_String value:contactInfoObj.contactNo_String];
    }
    else if([[self.popOverArray objectAtIndex:indexPath.row] isKindOfClass:[GISServiceProviderObject class]])
    {
        GISServiceProviderObject *spObj;
        if(tableView ==  self.searchDisplayController.searchResultsTableView) {
            
            spObj=[self.filteredArray objectAtIndex:indexPath.row];
            
        }else{
            spObj=[self.popOverArray objectAtIndex:indexPath.row];
        }
        
        [self.popOverDelegate sendTheSelectedPopOverData:spObj.id_String value:spObj.service_Provider_String];
        
    }else if(appDelegate.isNoofAttendees){
        
        [self.popOverDelegate sendTheSelectedPopOverData:[_noOfAttendeesIdArray objectAtIndex:indexPath.row] value:[self.popOverArray objectAtIndex:indexPath.row]];
    }
    else
    {
        [self.popOverDelegate sendTheSelectedPopOverData:@"" value:[self.popOverArray objectAtIndex:indexPath.row]];
    }
    
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [self.filteredArray removeAllObjects];

	
    if([[self.popOverArray lastObject] isKindOfClass:[GISServiceProviderObject class]])
    {
        NSString *spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO WHERE SERVICE_PROVIDER like '%@'",[NSString stringWithFormat:@"%%%@%%",searchText]];
        NSArray *tempArray = [[GISDatabaseManager sharedDataManager] getServiceProviderArray:spCode_statement];
        
        self.filteredArray = [NSMutableArray arrayWithArray:tempArray];

        
    }
    if([[self.popOverArray lastObject] isKindOfClass:[GISDropDownsObject class]])
    {
        NSArray *tempArray;
        GISDropDownsObject *dropDownObject = [self.popOverArray lastObject];
        
        if ([dropDownObject.type_String  isEqual:kBuildingNames]) {
            
            NSString *requetDetails_statement = [[NSString alloc]initWithFormat:@"select * from TBL_BUILDING_NAME WHERE VALUE like '%@'",[NSString stringWithFormat:@"%%%@%%",searchText]];
            tempArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:requetDetails_statement];
        }
        else if ([dropDownObject.type_String isEqual:kDressCode]) {
   
            NSString *requetDetails_statement = [[NSString alloc]initWithFormat:@"select * from TBL_DRESS_CODE WHERE VALUE like '%@'",[NSString stringWithFormat:@"%%%@%%",searchText]];
            tempArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:requetDetails_statement];
        }
        else if ([dropDownObject.type_String isEqual:kLocationCode]) {
      
            NSString *requetDetails_statement = [[NSString alloc]initWithFormat:@"select * from TBL_GENERAL_LOCATION WHERE VALUE like '%@'",[NSString stringWithFormat:@"%%%@%%",searchText]];
            tempArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:requetDetails_statement];
        }
        else if ([dropDownObject.type_String isEqual:kEventType]) {

            NSString *requetDetails_statement = [[NSString alloc]initWithFormat:@"select * from TBL_EVENT_TYPE WHERE VALUE like '%@'",[NSString stringWithFormat:@"%%%@%%",searchText]];
            tempArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:requetDetails_statement];
        }
        else if ([dropDownObject.type_String isEqual:kunitOrDep]) {
    
            NSString *requetDetails_statement = [[NSString alloc]initWithFormat:@"select * from TBL_UNIT_DEPARTMENT WHERE VALUE like '%@'",[NSString stringWithFormat:@"%%%@%%",searchText]];
            tempArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:requetDetails_statement];
        }
        else if ([dropDownObject.type_String isEqual:kRequestNumbers]) {

            NSString *requetDetails_statement = [[NSString alloc]initWithFormat:@"select * from TBL_CHOOSE_REQUEST WHERE VALUE  like '%@'",[NSString stringWithFormat:@"%%%@%%",searchText]];
           tempArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:requetDetails_statement];
        }
        //
        else if ([dropDownObject.type_String isEqual:kMode_of_Communication]) {
            
            NSString *requetDetails_statement = [[NSString alloc]initWithFormat:@"select * from TBL_MODE_OF_COMMUNICATION WHERE VALUE  like '%@'",[NSString stringWithFormat:@"%%%@%%",searchText]];
            tempArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:requetDetails_statement];
            
        }
        else if ([dropDownObject.type_String isEqual:kServiceProvider_GenderPref]) {
       
            NSString *requetDetails_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROV_GENDER_PREFERENCE WHERE VALUE  like '%@'",[NSString stringWithFormat:@"%%%@%%",searchText]];
            tempArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:requetDetails_statement];
        }
        else if ([dropDownObject.type_String isEqual:kService_Needed]) {

            NSString *requetDetails_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_NEEDED WHERE VALUE  like '%@'",[NSString stringWithFormat:@"%%%@%%",searchText]];
            tempArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:requetDetails_statement];
        }
        else if ([dropDownObject.type_String isEqual:kClosest_metro]) {

            NSString *requetDetails_statement = [[NSString alloc]initWithFormat:@"select * from TBL_CLOSEST_METRO WHERE VALUE  like '%@'",[NSString stringWithFormat:@"%%%@%%",searchText]];
            tempArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:requetDetails_statement];
        }
        else if ([dropDownObject.type_String isEqual:kLocationName]) {

        }
        else if ([dropDownObject.type_String isEqual:kPrimary_Audience]) {
 
            NSString *requetDetails_statement = [[NSString alloc]initWithFormat:@"select * from TBL_PRIMARY_AUDIENCE WHERE VALUE  like '%@'",[NSString stringWithFormat:@"%%%@%%",searchText]];
            tempArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:requetDetails_statement];
        }
        else if ([dropDownObject.type_String isEqual:kSkill_Level]) {
     
            NSString *requetDetails_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SKILL_LEVEL WHERE VALUE  like '%@'",[NSString stringWithFormat:@"%%%@%%",searchText]];
            tempArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:requetDetails_statement];
        }
        else if ([dropDownObject.type_String isEqual:kPay_Level]) {

            NSString *requetDetails_statement = [[NSString alloc]initWithFormat:@"select * from TBL_PAY_LEVEL WHERE VALUE  like '%@'",[NSString stringWithFormat:@"%%%@%%",searchText]];
            tempArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:requetDetails_statement];
        }
        else if ([dropDownObject.type_String isEqual:kBill_Level]) {
            
            NSString *requetDetails_statement = [[NSString alloc]initWithFormat:@"select * from TBL_BILL_LEVEL WHERE VALUE  like '%@'",[NSString stringWithFormat:@"%%%@%%",searchText]];
            tempArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:requetDetails_statement];
        }
        else if ([dropDownObject.type_String isEqual:kPayStatus_ExpStatus]) {
      
        }
        else if ([dropDownObject.type_String isEqual:kServiceType_serviceProvider]) {
            
            NSString *requetDetails_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_TYPE_SERVICE_PROVIDER WHERE VALUE  like '%@'",[NSString stringWithFormat:@"%%%@%%",searchText]];
            tempArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:requetDetails_statement];
   
        }
        else if ([dropDownObject.type_String isEqual:kRequest_Number_Search]) {
      
        }
        else if ([dropDownObject.type_String isEqual:kPayType]) {
        
            NSString *requetDetails_statement = [[NSString alloc]initWithFormat:@"select * from TBL_PAY_TYPE WHERE VALUE  like '%@'",[NSString stringWithFormat:@"%%%@%%",searchText]];
            tempArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:requetDetails_statement];
        }
        else if ([dropDownObject.type_String isEqual:kTypeOfService]) {

        }
        else if ([dropDownObject.type_String isEqual:kServiceType_Registerd_Consumers]) {
    
        }
        else if ([dropDownObject.type_String isEqual:kRequestors]) {
       
        }
        else if ([dropDownObject.type_String isEqual:kMode]) {
           
        }
        else if ([dropDownObject.type_String isEqual:kCreated_By]) {
          
        }
        else if ([dropDownObject.type_String isEqual:kRequestor_Type]) {
           
        }
        
        self.filteredArray = [NSMutableArray arrayWithArray:tempArray];

    }
    else if([[self.popOverArray lastObject] isKindOfClass:[GISContactsInfoObject class]])
    {

        NSString *spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_CONTACTS_INFO WHERE CONTACT_NO like '%@'",[NSString stringWithFormat:@"%%%@%%",searchText]];
        NSArray *tempArray = [[GISDatabaseManager sharedDataManager] getContactsArray:spCode_statement];
        
        self.filteredArray = [NSMutableArray arrayWithArray:tempArray];
        
    }

}


#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
