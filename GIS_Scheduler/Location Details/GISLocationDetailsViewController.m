//
//  GISLocationDetailsViewController.m
//  GIS_Scheduler
//
//  Created by Anand on 17/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISLocationDetailsViewController.h"
#import "GISLocationDetailsCell.h"
#import "GISLocationOnCampusCell.h"
#import "GISFonts.h"
#import "GISConstants.h"
#import "GISDatabaseManager.h"
#import "GISPopOverTableViewController.h"
#import "GISUtility.h"
#import "GISLoginDetailsObject.h"
#import "GISJSONProperties.h"
#import "GISServerManager.h"
#import "GISJsonRequest.h"
#import "GISStoreManager.h"
#import "GISDropDownStore.h"
#import "PCLogger.h"
#import "GISDatesAndTimesViewController.h"
#import "GISLoadingView.h"

@interface GISLocationDetailsViewController ()

@end

@implementation GISLocationDetailsViewController

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
        
        [_locationDetaislTabelView setContentSize:CGSizeMake(1024, 940)];
        
        NSString *requetDetails_statement = [[NSString alloc]initWithFormat:@"select * from TBL_CHOOSE_REQUEST  ORDER BY ID DESC;"];
        _chooseReqArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:requetDetails_statement];
        
        NSString *generalLocation_statement = [[NSString alloc]initWithFormat:@"select * from TBL_GENERAL_LOCATION  ORDER BY ID DESC;"];
        _generalLocationArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:generalLocation_statement];
        
        NSString *closestMetro_statement = [[NSString alloc]initWithFormat:@"select * from TBL_CLOSEST_METRO  ORDER BY ID DESC;"];
        _closestMetroArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:closestMetro_statement];
        
        NSString *buildingName_statement = [[NSString alloc]initWithFormat:@"select * from TBL_BUILDING_NAME  ORDER BY ID DESC;"];
        _buildingNameArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:buildingName_statement];
        
        _generalLocationdata = NSLocalizedStringFromTable(@"gallaudet_campus", TABLE, nil);
        _buildingNamedata = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
        
        _locationName_Value_string = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
        _closestMetrodata = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
        
         appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication]delegate];
        
        _parkingArray = [[NSMutableArray alloc] init];
        _fields = [[NSMutableString alloc] init];
        _locationNames = [[NSMutableArray alloc] init];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectedChooseRequestNumber:) name:kselectedChooseReqNumber object:nil];


    }

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectedChooseRequestNumber:) name:kselectedChooseReqNumber object:nil];
    
    _generalLocationId_string = @"1";

    
    if([appDelegate.chooseRequest_ID_String length] > 0 && ![appDelegate.chooseRequest_ID_String isEqualToString:@"0"]){
    
        [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
        
        NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
        NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
        GISLoginDetailsObject *unitObj1=[requetId_array lastObject];
        NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
        [paramsDict setObject:appDelegate.chooseRequest_ID_String forKey:kID];
        [paramsDict setObject:unitObj1.token_string forKey:kToken];
        [[GISServerManager sharedManager] getEventDetailsData:self withParams:paramsDict finishAction:@selector(successmethod_getRequestDetails:) failAction:@selector(failuremethod_getRequestDetails:)];
    
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 0;
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISLocationDetailsCell *locationCell;
    
    if(indexPath.section == 0){
        return 0;
    }
    if(indexPath.section == 1){
        
         locationCell=(GISLocationDetailsCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
         return locationCell.frame.size.height;
    }
    return locationCell.frame.size.height;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISLocationDetailsCell *cell;
    
    if(indexPath.section == 1){
        
        if([_generalLocationId_string isEqualToString:@"1"]){
            
            cell=(GISLocationDetailsCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
            if(cell==nil)
            {
                cell=[[[NSBundle mainBundle]loadNibNamed:@"GISLocationDetailsCell" owner:self options:nil]objectAtIndex:0];
            }
            
            NSMutableArray *chooseReqDetailedArray=[[GISStoreManager sharedManager]getChooseRequestDetailsObjects];
            if (chooseReqDetailedArray.count>0) {
                
                _chooseRequestDetailsObj=[chooseReqDetailedArray lastObject];
            }

            
            [cell.buildingNamebtn setTitle:_buildingNamedata forState:UIControlStateNormal];
            [cell.buildingNamebtn setTitleColor:UIColorFromRGB(0x616161) forState:UIControlStateNormal];
            cell.roomNametextField.delegate = self;
            cell.roomnotextField.delegate = self;
            cell.othertextField.delegate = self;
            cell.specialProtocoltextView.delegate = self;
            
            cell.roomNametextField.text = _room_name_string;
            cell.roomnotextField.text = _chooseRequestDetailsObj.RoomNunber_String_chooseReqParsedDetails;
            cell.othertextField.text = _other_string;
            cell.specialProtocoltextView.text = _chooseRequestDetailsObj.SpecialProtocol_String_chooseReqParsedDetails;
            
            [cell.nextButton addTarget:self action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [cell.buildingNamebtn addTarget:self action:@selector(showPopoverDetails:) forControlEvents:UIControlEventTouchUpInside];
            [cell.garageonCampusbtn addTarget:self action:@selector(tickBtnTap:) forControlEvents:UIControlEventTouchUpInside];
            [cell.materedonCampusBtn addTarget:self action:@selector(tickBtnTap:) forControlEvents:UIControlEventTouchUpInside];
            [cell.streetonCampusBtn addTarget:self action:@selector(tickBtnTap:) forControlEvents:UIControlEventTouchUpInside];
            [cell.UnknownonCampusbtn addTarget:self action:@selector(tickBtnTap:) forControlEvents:UIControlEventTouchUpInside];
            if([_parkingArray count]>0)
                [_parkingArray removeAllObjects];
            
            for(int i=0 ;i<[_getParkingOfflocArray count];i++)
            {
                NSString *value = [_getParkingOfflocArray objectAtIndex:i];
                switch ([value intValue]) {
                    case 1:
                        [cell.garageonCampusbtn setBackgroundImage: [UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
                        [_parkingArray addObject:value];
                        break;
                    case 2:
                        [cell.materedonCampusBtn setBackgroundImage: [UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
                        [_parkingArray addObject:value];
                        break;
                    case 3:
                        [cell.streetonCampusBtn setBackgroundImage: [UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
                        [_parkingArray addObject:value];
                        break;
                    case 4:
                        [cell.UnknownonCampusbtn setBackgroundImage: [UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
                        [_parkingArray addObject:value];
                        break;
                    default:
                        break;
                }
            }
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            return cell;
        }else{
            GISLocationOnCampusCell *cell =(GISLocationOnCampusCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
            if(cell==nil)
            {
                cell=[[[NSBundle mainBundle]loadNibNamed:@"GISLocationOnCampusCell" owner:self options:nil]objectAtIndex:0];
            }
            
            [cell.nextButton addTarget:self action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.storeLocationbtn addTarget:self action:@selector(showPopoverDetails:) forControlEvents:UIControlEventTouchUpInside];
            [cell.storeLocationbtn setTitle:_locationName_Value_string forState:UIControlStateNormal];
            [cell.storeLocationbtn setTitleColor:UIColorFromRGB(0x616161) forState:UIControlStateNormal];
            
            [cell.closestMetrobtn addTarget:self action:@selector(showPopoverDetails:) forControlEvents:UIControlEventTouchUpInside];
            [cell.closestMetrobtn setTitle:_closestMetrodata forState:UIControlStateNormal];
            [cell.closestMetrobtn setTitleColor:UIColorFromRGB(0x616161) forState:UIControlStateNormal];
            
            [cell.garagebtn addTarget:self action:@selector(tickBtnTap:) forControlEvents:UIControlEventTouchUpInside];
            [cell.materedBtn addTarget:self action:@selector(tickBtnTap:) forControlEvents:UIControlEventTouchUpInside];
            [cell.streetBtn addTarget:self action:@selector(tickBtnTap:) forControlEvents:UIControlEventTouchUpInside];
            [cell.Unknownbtn addTarget:self action:@selector(tickBtnTap:) forControlEvents:UIControlEventTouchUpInside];
            [cell.transportationyesBtn addTarget:self action:@selector(tickBtnTap:) forControlEvents:UIControlEventTouchUpInside];
            [cell.transportationnoBtn addTarget:self action:@selector(tickBtnTap:) forControlEvents:UIControlEventTouchUpInside];
            
            if([_transportation_string isEqualToString:@"True"]){
                [cell.transportationyesBtn setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
                [cell.transportationnoBtn setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            }else if([_transportation_string isEqualToString:@"False"]){
                [cell.transportationyesBtn setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
                [cell.transportationnoBtn setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
            }
            
            if([_parkingArray count]>0)
                [_parkingArray removeAllObjects];
            
            cell.specialTextview.delegate = self;
            cell.otherinfoTextview.delegate = self;
            cell.address1Textview.delegate = self;
            cell.address2Textview.delegate = self;
            
            cell.citytextField.delegate = self;
            cell.statetextField.delegate = self;
            cell.ziptextField.delegate = self;
            cell.locationtextField.delegate = self;
            
            cell.locationtextField.text = _LocationName_string;
            cell.address1Textview.text = _address1_string;
            cell.address2Textview.text = _address2_string;
            cell.citytextField.text = _city_string;
            cell.statetextField.text = _state_string;
            cell.ziptextField.text = _zip_string;
            cell.specialTextview.text = _special_string;
            cell.otherinfoTextview.text = _otherinfo_string;
            
            for(int i=0 ;i<[_getParkingArray count];i++)
            {
                NSString *value = [_getParkingArray objectAtIndex:i];
                switch ([value intValue]) {
                    case 1:
                        [cell.garagebtn setBackgroundImage: [UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
                        [_parkingArray addObject:value];
                        break;
                    case 2:
                        [cell.materedBtn setBackgroundImage: [UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
                        [_parkingArray addObject:value];
                        break;
                    case 3:
                        [cell.streetBtn setBackgroundImage: [UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
                        [_parkingArray addObject:value];
                        break;
                    case 4:
                        [cell.Unknownbtn setBackgroundImage: [UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
                        [_parkingArray addObject:value];
                        break;
                    default:
                        break;
                }
            }
            
            //        if([login_Obj.userStatus_string isEqualToString:kInternal]){
            //            cell.transportationLabel.hidden=YES;
            //            cell.transportationyesBtn.hidden=YES;
            //            cell.transportationYesLabel.hidden=YES;
            //            cell.transportationnoBtn.hidden=YES;
            //            cell.transportationNoLabel.hidden=YES;
            //        }
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            return cell;
        }
    }

    
    
    return cell;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView;
    if(section == 0){
        headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
        UILabel *genralLocationLabel = [[UILabel alloc] init];
        genralLocationLabel.frame = CGRectMake(50.0, 20.0, 120.0, 27.0);
        [genralLocationLabel setFont:[GISFonts normal]];
        genralLocationLabel.textColor = UIColorFromRGB(0x666666);
        genralLocationLabel.text = NSLocalizedStringFromTable(@"general_location", TABLE, nil);
        [headerView addSubview:genralLocationLabel];
        
        UIButton *generalLocationBtn = [[UIButton alloc] init];
        generalLocationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [generalLocationBtn setBackgroundImage:[UIImage imageNamed:@"choose_request_bg.png"] forState:UIControlStateNormal];
        generalLocationBtn.frame = CGRectMake(175.0, 20.0, 150.0, 27.0);
        generalLocationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        generalLocationBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
        [generalLocationBtn.titleLabel setFont:[GISFonts small]];
        [generalLocationBtn setTitleColor:UIColorFromRGB(0x616161) forState:UIControlStateNormal];
        [generalLocationBtn setTitle:_generalLocationdata forState:UIControlStateNormal];
        [generalLocationBtn setTag:121];
        [generalLocationBtn addTarget:self action:@selector(showPopoverDetails:) forControlEvents:UIControlEventTouchUpInside];
        
        [headerView addSubview:generalLocationBtn];
    }
    
    return headerView;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if(section == 0){
        return 50.0;
    }
    
    return 0;
}

- (IBAction)showPopoverDetails:(id)sender{
    
    UIButton *btn=(UIButton*)sender;
    btn_tag = btn.tag;
    
    GISPopOverTableViewController *tableViewController = [[GISPopOverTableViewController alloc] initWithNibName:@"GISPopOverTableViewController" bundle:nil];
    tableViewController.popOverDelegate = self;
    
    if(btn.tag ==1){
        
         _popover =   [GISUtility showPopOver:(NSMutableArray *)_buildingNameArray viewController:tableViewController];
    }else if(btn_tag == 101){
        _popover =   [GISUtility showPopOver:(NSMutableArray *)_locationNames viewController:tableViewController];
        
    }else if(btn_tag == 102){
        _popover =   [GISUtility showPopOver:(NSMutableArray *)_closestMetroArray viewController:tableViewController];
        
    }else{
        _popover =   [GISUtility showPopOver:(NSMutableArray *)_generalLocationArray viewController:tableViewController];
    }
    _popover.delegate = self;
    if (_popover) {
        [_popover dismissPopoverAnimated:YES];
    }
    
    [_popover presentPopoverFromRect:CGRectMake(btn.frame.origin.x+btn.frame.size.width-15, btn.frame.origin.y+15, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown animated:YES];
}

-(void)sendTheSelectedPopOverData:(NSString *)id_str value:(NSString *)value_str
{
    if(btn_tag == 1){
        
        _buildingNamedata= value_str;
        _buildingname_Id_string = id_str;
        UIButton *buildingNameBtn=(UIButton *)[self.view viewWithTag:1];
        [buildingNameBtn setTitle:_buildingNamedata forState:UIControlStateNormal];
    }else if(btn_tag == 101){
        
        _locationName_Value_string= value_str;
        _locationName_ID_string = id_str;
        UIButton *storeLocationBtn=(UIButton *)[self.view viewWithTag:101];
        [storeLocationBtn setTitle:_locationName_Value_string forState:UIControlStateNormal];
        
        
        for(GISDropDownsObject *unitObj in _locationNames){
            
            if([id_str isEqualToString:unitObj.id_String]){
                
                _requestorLocationId_string=unitObj.id_String;
                _locationName_Value_string = unitObj.value_String;
                
                if ([_requestorLocationId_string length]==0) {
                    _requestorLocationId_string=@"";
                }
                
                NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
                NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
                GISLoginDetailsObject *unitObj1=[requetId_array lastObject];
                NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
                [paramsDict setObject:_requestorLocationId_string forKey:kID];
                [paramsDict setObject:unitObj1.token_string forKey:kToken];
                
                [[GISServerManager sharedManager] getoffCampusLocation_Details_Data:self withParams:paramsDict finishAction:@selector(successmethod_getoffLocationRequestDetails:) failAction:@selector(failuremethod_getoffLocationRequestDetails:)];
            }
        }

    }else if(btn_tag == 102){
        
        _closestMetro_Id_string = id_str;
        _closestMetrodata = value_str;
        UIButton *closestMetroBtn=(UIButton *)[self.view viewWithTag:102];
        [closestMetroBtn setTitle:_closestMetrodata forState:UIControlStateNormal];
    
    }else{
        _generalLocationdata= value_str;
        _generalLocationId_string = id_str;
        UIButton *generalLocationBtn=(UIButton *)[self.view viewWithTag:121];
        [generalLocationBtn setTitle:_generalLocationdata forState:UIControlStateNormal];
        
        
        NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
        NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
        GISLoginDetailsObject *unitObj1=[requetId_array lastObject];
        NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
        [paramsDict setObject:_generalLocationId_string forKey:kID];
        [paramsDict setObject:unitObj1.token_string forKey:kToken];
        [paramsDict setObject:unitObj1.requestorID_string forKey:kLocationrequestorid];
        
        [[GISServerManager sharedManager] getLocation_Details_Data:self withParams:paramsDict finishAction:@selector(successmethod_getLocationRequestDetails:) failAction:@selector(failuremethod_getLocationRequestDetails:)];
    }
    
    if(_popover)
        [_popover dismissPopoverAnimated:YES];
}

-(void)successmethod_getLocationRequestDetails:(GISJsonRequest *)response
{
    NSLog(@"--%@",response.responseJson);
    
    NSDictionary *saveUpdateDict;
    NSArray *responseArray= response.responseJson;
    saveUpdateDict = [responseArray lastObject];
    NSLog(@"successmethod_getLocationRequestDetails Success---%@",saveUpdateDict);
    
    if ([[saveUpdateDict objectForKey:kStatusCode] isEqualToString:@"200"]) {
        
        GISDropDownStore *dropDownStore;
        
        [[GISStoreManager sharedManager] removeLocationNameObjects];
        dropDownStore=[[GISDropDownStore alloc]initWithStoreDictionary:response.responseJson];
        _locationNames = [[GISStoreManager sharedManager] getLocationNameObjects];
        
        NSMutableArray *chooseReqDetailedArray=[[GISStoreManager sharedManager]getChooseRequestDetailsObjects];
        if (chooseReqDetailedArray.count>0) {
            
            _chooseRequestDetailsObj=[chooseReqDetailedArray lastObject];
        }
        
        for (GISDropDownsObject *dropDownObj in _locationNames) {
            if ([dropDownObj.id_String isEqualToString:_chooseRequestDetailsObj.reqLocation_Id_chooseReqParsedDetails]) {
                _locationName_Value_string =  dropDownObj.value_String;
            }
        }
        
    }else{
        
        _locationName_Value_string = @"";
         _LocationName_string = @"";
         _address1_string = @"";
        _address2_string = @"";
         _city_string = @"";
         _state_string = @"";
         _zip_string = @"";
    }
    
    [_locationDetaislTabelView reloadData];
    
}

-(void)failuremethod_getLocationRequestDetails:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"Failure");
    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
}

- (IBAction)tickBtnTap:(id)sender
{    
    UIButton *btn=(UIButton*)sender;
    int item_value;
    
    if(btn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
        
        
    }
    else
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        if(btn.tag == 555 || btn.tag == 570){
            item_value = 1;
            [_parkingArray addObject:[NSString stringWithFormat:@"%d",item_value]];
        }else if(btn.tag == 556 || btn.tag == 571){
            item_value = 2;
            [_parkingArray addObject:[NSString stringWithFormat:@"%d",item_value]];
        }else if(btn.tag == 557 || btn.tag == 572){
            item_value = 3;
            [_parkingArray addObject:[NSString stringWithFormat:@"%d",item_value]];
        }else if(btn.tag == 558 || btn.tag == 573){
            item_value = 4;
            [_parkingArray addObject:[NSString stringWithFormat:@"%d",item_value]];
        }else if(btn.tag == 574){
            _transportation_string = @"true";
            UIButton *btnn=(UIButton *)[self.view viewWithTag:575];
            if(btnn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])
            {
                [btnn setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            }
            UIAlertView *alertVIew = [[UIAlertView alloc] initWithTitle:@"Transportation? :" message:@"" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
            alertVIew.alertViewStyle = UIAlertViewStylePlainTextInput;
            alertVIew.tag = btn.tag;
            alertVIew.delegate = self;
            [alertVIew show];
            
            
        }else if(btn.tag == 575){
            _transportation_string = @"false";
            
            UIButton *btnn=(UIButton *)[self.view viewWithTag:574];
            if(btnn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])
            {
                [btnn setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            }
            
            [btn setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
            
            
        }
    }
}

-(void)nextButtonPressed:(id)sender
{
    if ([_inCompleteTab_string isEqualToString:@"Request is completed but not submitted"]) {
        
    }
    else if(!appDelegate.isFromContacts){
        if([_isCompleteRequest isEqualToString:@"false"] && ![_inCompleteTab_string isEqualToString:@"Locations Details are In-Complete"]){
            if(![_inCompleteTab_string isEqualToString:@"Datetimes are In-Complete"]){
                
                [GISUtility showAlertWithTitle:@"" andMessage:_inCompleteTab_string];
                return;
            }
        }
    }
    
    [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
    
    [self saveLocationsData];
}

-(void)saveLocationsData
{
    @try {
//        if((appDelegate.isFromContacts && !appDelegate.isNewRequest) || (appDelegate.isFromContacts && appDelegate.isNewRequest) || [_isCompleteRequest isEqualToString:@"true"] || ([_isCompleteRequest isEqualToString:@"false"] && [_inCompleteTab_string isEqualToString:@"Locations Details are In-Complete"]) || [_inCompleteTab_string isEqualToString:@"Datetimes are In-Complete"]||[_inCompleteTab_string isEqualToString:@"Request is completed but not submitted"]){
        
    if(!appDelegate.isNewRequest || (appDelegate.isFromContacts || appDelegate.isNewRequest)){
        
            _parkingstring = [[NSMutableString alloc] init];
            
            if([_transportation_string length] >0)
                _transportation_string = @"";
            if([_transportationYes_string length] > 0)
                _transportationYes_string = @"";
            
            NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
            
            NSMutableArray *chooseDetailsArray = [[NSMutableArray alloc] initWithArray:[[GISStoreManager sharedManager]getChooseRequestDetailsObjects]];
            
            _chooseRequestDetailsObj = [chooseDetailsArray lastObject];
            
            NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
            NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
            GISLoginDetailsObject *unitObj=[requetId_array lastObject];
            
            [paramsDict setObject:unitObj.requestorID_string forKey:keventDetails_requestID];
            [paramsDict setObject:_chooseRequestDetailsObj.unitID_String_chooseReqParsedDetails forKey:kunitid];
            [paramsDict setObject:appDelegate.chooseRequest_ID_String forKey:keventDetails_requestNo];
            [paramsDict setObject:unitObj.token_string forKey:keventDetails_token];
            [paramsDict setObject:_chooseRequestDetailsObj.statusID_String_chooseReqParsedDetails forKey:kstatusid];
            [paramsDict setObject:_chooseRequestDetailsObj.CapNoOfUsers_String_chooseReqParsedDetails forKey:keventDetails_capnoofUsers];
            [paramsDict setObject:_chooseRequestDetailsObj.CapViewOptions_String_chooseReqParsedDetails forKey:keventDetails_captionView];
            [paramsDict setObject:_chooseRequestDetailsObj.CaptionTypeID_String_chooseReqParsedDetails forKey:keventDetails_captiontype];
            [paramsDict setObject:_chooseRequestDetailsObj.dressCodeID_String_chooseReqParsedDetails forKey:keventDetails_dresscodeId];
            [paramsDict setObject:_chooseRequestDetailsObj.eventDescription_String_chooseReqParsedDetails forKey:keventDetails_eventDesc];
            [paramsDict setObject:_chooseRequestDetailsObj.eventName_String_chooseReqParsedDetails forKey:keventDetails_eventName];
            [paramsDict setObject:_chooseRequestDetailsObj.eventTypeID_String_chooseReqParsedDetails forKey:keventDetails_eventId];
            [paramsDict setObject:_chooseRequestDetailsObj.onGoing_String_chooseReqParsedDetails forKey:keventDetails_onGoing];
            [paramsDict setObject:_chooseRequestDetailsObj.openToPublic_String_chooseReqParsedDetails forKey:keventDetails_eventPublic];
            [paramsDict setObject:_chooseRequestDetailsObj.OtherServiceID_String_chooseReqParsedDetails forKey:keventDetails_otherServices];
            [paramsDict setObject:_chooseRequestDetailsObj.otherTechnologies_String_chooseReqParsedDetails forKey:keventDetails_Othertech];
            [paramsDict setObject:_chooseRequestDetailsObj.recBroadcast_String_chooseReqParsedDetails forKey:keventDetails_broadcast];
            [paramsDict setObject:_chooseRequestDetailsObj.recBroadcastYes_String_chooseReqParsedDetails forKey:keventDetails_recordBroadcastYes];
            [paramsDict setObject:_chooseRequestDetailsObj.courseID_String_chooseReqParsedDetails forKey:keventDetails_CourseId];
            
            if([_generalLocationId_string isEqualToString:@"1"]){
                [_parkingstring setString:@""];
                for(int i=0; i <[_parkingArray count];i++){
                    //othertechvalueStr = [[otherTechStr objectAtIndex:i] componentsJoinedByString:@","];
                    [_parkingstring appendFormat:@"%@%@",[_parkingArray objectAtIndex:i],@","];
                }
                NSRange range = [_parkingstring rangeOfString:@"," options:NSBackwardsSearch];
                if (range.location == NSNotFound) {
                    //  [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,maxRange-1)];
                } else {
                    [_parkingstring setString:[_parkingstring substringToIndex:range.location]];
                }
                
                if([_other_string length] == 0){
                    _other_string = @"";
                }
                if([_generalLocationId_string length] == 0){
                    _generalLocationId_string = @"";
                }
                if([_buildingname_Id_string length] == 0){
                    _buildingname_Id_string = @"";
                }
                if([_room_name_string length] == 0 ){
                    _room_name_string = @"";
                }
                if([_room_no_string length] == 0){
                    _room_no_string = @"";
                }
                if([_specialProtocol_string length] == 0){
                    _specialProtocol_string = @"";
                }
                if([_requestorLocationId_string length] == 0){
                    _requestorLocationId_string = @"";
                }
                if([_transportation_string length] == 0){
                    _transportation_string = @"";
                }
                if([_transportationYes_string length] == 0){
                    _transportationYes_string = @"";
                }
                
                [paramsDict setObject:@"" forKey:kLocation_closestmetro];
                //[paramsDict setObject:@"" forKey:kLocation_eventname];
                [paramsDict setObject:@"" forKey:kLocation_offcampaddress1];
                [paramsDict setObject:@"" forKey:kLocation_offcampaddress2];
                [paramsDict setObject:@"" forKey:kLocation_offcampcity];
                [paramsDict setObject:@"" forKey:kLocation_offcamplocname];
                [paramsDict setObject:@"" forKey:kLocation_offcampstate];
                [paramsDict setObject:@"" forKey:kLocation_offcampzip];
                [paramsDict setObject:_requestorLocationId_string forKey:kLocation_reqlocationid];
                [paramsDict setObject:_other_string forKey:kLocation_other];
                [paramsDict setObject:_generalLocationId_string forKey:kLocation_generallocationid];
                [paramsDict setObject:_buildingname_Id_string forKey:kLocation_buildingid];
                [paramsDict setObject:@"" forKey:kLocation_other_info];
                [paramsDict setObject:_room_name_string forKey:kLocation_roomname];
                [paramsDict setObject:_room_no_string forKey:kLocation_roomnunber];
                [paramsDict setObject:_specialProtocol_string forKey:kLocation_specialprotocol];
                [paramsDict setObject:_parkingstring forKey:kLocation_parking];
                [paramsDict setObject:_transportation_string forKey:kLocation_transport];
                [paramsDict setObject:_transportationYes_string forKey:kLocation_transportnotes];
                
            }else{
                
                [_parkingstring setString:@""];
                
                for(int i=0; i <[_parkingArray count];i++){
                    //othertechvalueStr = [[otherTechStr objectAtIndex:i] componentsJoinedByString:@","];
                    [_parkingstring appendFormat:@"%@%@",[_parkingArray objectAtIndex:i],@","];
                }
                NSRange range = [_parkingstring rangeOfString:@"," options:NSBackwardsSearch];
                if (range.location == NSNotFound) {
                    //  [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,maxRange-1)];
                } else {
                    [_parkingstring setString:[_parkingstring substringToIndex:range.location]];
                }
                
                if([_address1_string length] == 0){
                    _address1_string = @"";
                }
                if([_address2_string length] == 0){
                    _address2_string = @"";
                }
                if([_city_string length] == 0){
                    _city_string = @"";
                }
                if([_LocationName_string length] == 0 ){
                    _LocationName_string = @"";
                }
                if([_state_string length] == 0){
                    _state_string = @"";
                }
                if([_zip_string length] == 0){
                    _zip_string = @"";
                }
                if([_generalLocationId_string length] == 0){
                    _generalLocationId_string = @"";
                }
                if([_special_string length] == 0){
                    _special_string = @"";
                }
                if([_otherinfo_string length] == 0 ){
                    _otherinfo_string = @"";
                }
                if([_requestorLocationId_string length] == 0){
                    _requestorLocationId_string = @"";
                }
                if([_closestMetro_Id_string length] == 0){
                    _closestMetro_Id_string = @"";
                }
                if([_transportation_string length] == 0){
                    _transportation_string = @"";
                }if([_transportationYes_string length] == 0){
                    _transportationYes_string = @"";
                }
                
                
                [paramsDict setObject:_closestMetro_Id_string forKey:kLocation_closestmetro];
                //[paramsDict setObject:@"" forKey:kLocation_eventname];
                [paramsDict setObject:_address1_string forKey:kLocation_offcampaddress1];
                [paramsDict setObject:_address2_string forKey:kLocation_offcampaddress2];
                [paramsDict setObject:_city_string forKey:kLocation_offcampcity];
                [paramsDict setObject:_LocationName_string forKey:kLocation_offcamplocname];
                [paramsDict setObject:_state_string forKey:kLocation_offcampstate];
                [paramsDict setObject:_zip_string forKey:kLocation_offcampzip];
                [paramsDict setObject:_requestorLocationId_string forKey:kLocation_reqlocationid];
                [paramsDict setObject:_generalLocationId_string forKey:kLocation_generallocationid];
                [paramsDict setObject:@"" forKey:kLocation_buildingid];
                [paramsDict setObject:@"" forKey:kLocation_other];
                [paramsDict setObject:@"" forKey:kLocation_roomname];
                [paramsDict setObject:@"" forKey:kLocation_roomnunber];
                [paramsDict setObject:_special_string forKey:kLocation_specialprotocol];
                [paramsDict setObject:_parkingstring forKey:kLocation_parking];
                [paramsDict setObject:_otherinfo_string forKey:kLocation_other_info];
                [paramsDict setObject:_transportation_string forKey:kLocation_transport];
                [paramsDict setObject:_transportationYes_string forKey:kLocation_transportnotes];
                
            }
            if([_generalLocationdata length]>0){
                
                if([_generalLocationId_string isEqualToString:@"1"]){
                    if(![_buildingNamedata isEqualToString:NSLocalizedStringFromTable(@"empty_selection", TABLE, nil)]){
                        [[GISServerManager sharedManager] saveLocationData:self withParams:paramsDict finishAction:@selector(successmethod_saveLocationDataRequest:) failAction:@selector(failuremethod_saveLocationDataRequest:)];
                    }else{
                        if([_fields length]>0)
                            [_fields setString:@""];
                        
                        if([_buildingNamedata isEqualToString:NSLocalizedStringFromTable(@"empty_selection", TABLE, nil)])
                            [_fields appendFormat:@"%@%@",@"Building Name",@", \n"];
                        
                        [GISUtility showAlertWithTitle:@"" andMessage:[NSString stringWithFormat:NSLocalizedStringFromTable(@"enter_valid_details",TABLE, nil),_fields]];
                        [self removeLoadingView];
                        
                    }
                }else{
                    if([_LocationName_string length]>0 && [_address1_string length]>0
                       && [_city_string length] >0 && [_zip_string length] >0 && [_state_string length] >0){
                        
                        [[GISServerManager sharedManager] saveLocationData:self withParams:paramsDict finishAction:@selector(successmethod_saveLocationDataRequest:) failAction:@selector(failuremethod_saveLocationDataRequest:)];
                    }else{
                        if([_fields length]>0)
                            [_fields setString:@""];
                        
                        if([_LocationName_string length] == 0)
                            [_fields appendFormat:@"%@%@",@"Location Name",@", \n"];
                        if([_address1_string length] == 0)
                            [_fields appendFormat:@"%@%@",@"Address1",@", \n"];
                        if([_city_string length] == 0)
                            [_fields appendFormat:@"%@%@",@"City",@", \n"];
                        if([_state_string length] == 0)
                            [_fields appendFormat:@"%@%@",@"State",@", \n"];
                        if([_zip_string length] == 0)
                            [_fields appendFormat:@"%@",@"Zip"];
                        
                        [GISUtility showAlertWithTitle:@"" andMessage:[NSString stringWithFormat:NSLocalizedStringFromTable(@"enter_valid_details",TABLE, nil),_fields]];
                        
                        [self removeLoadingView];
                        
                    }
                    
                }
            }else{
                
                if([_fields length]>0)
                    [_fields setString:@""];
                
                if([_generalLocationdata length] == 0)
                    [_fields appendFormat:@"%@%@",@"General Location",@", \n"];
                
                [GISUtility showAlertWithTitle:@"" andMessage:[NSString stringWithFormat:NSLocalizedStringFromTable(@"enter_valid_details",TABLE, nil),_fields]];
                [self removeLoadingView];
                
            }
        }
        
        else{
            [self removeLoadingView];
            
            [GISUtility showAlertWithTitle:@"" andMessage:@"Select Choose Request"];
            
        }
    }
    @catch (NSException *exception)
    {
        [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in Location Details action %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
    }
    
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField.tag == 55 || textField.tag == 66 || textField.tag == 77){
        
        NSDictionary *infoDict=[NSDictionary dictionaryWithObjectsAndKeys:@"-210",@"yValue",nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:kMoveUp object:nil userInfo:infoDict];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.tag == 55 || textField.tag == 66 || textField.tag == 77){
        
        NSDictionary *infoDict=[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"yValue",nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:kMoveUp object:nil userInfo:infoDict];
    }
    if(textField.tag == 3){
        _room_name_string  = textField.text;
    }else if(textField.tag == 2){
        _room_no_string = textField.text;
    }else if(textField.tag == 4){
        _other_string = textField.text;
    }else if(textField.tag == 44){
        _LocationName_string = textField.text;
    }else if(textField.tag == 55){
        _city_string = textField.text;
    }else if(textField.tag == 66){
        _state_string = textField.text;
    }else if(textField.tag == 77){
        _zip_string = textField.text;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
     return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.tag == 2 || textField.tag == 77){
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        if(newLength >6)
            return (newLength > 6) ? NO : YES;
        /*  limit to only numeric characters  */
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
        for (int i = 0; i < [string length]; i++) {
            unichar c = [string characterAtIndex:i];
            if ([myCharSet characterIsMember:c]) {
                return YES;
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter Numbers Only" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
                [alert show];
                return NO;
            }
        }
        
        /*  limit the users input to only 9 characters  */
    }else{
        return YES;
    }
    return YES;
}



- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSLog(@"textViewShouldBeginEditing:");
 
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    NSLog(@"textViewDidBeginEditing:");
    
    if(textView.tag == 569 || textView.tag == 555 || textView.tag == 5)
    {
        NSDictionary *infoDict=[NSDictionary dictionaryWithObjectsAndKeys:@"-210",@"yValue",nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:kMoveUp object:nil userInfo:infoDict];
    }

}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    NSLog(@"textViewShouldEndEditing:");
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"textViewDidEndEditing:");
    
    if(textView.tag == 569 || textView.tag == 555 || textView.tag == 5)
    {
        NSDictionary *infoDict=[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"yValue",nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:kMoveUp object:nil userInfo:infoDict];
    }
  
    [textView resignFirstResponder];
    
    if(textView.tag == 5)
    {
        _specialProtocol_string = textView.text;
    }else if(textView.tag == 562)
    {
        _address1_string = textView.text;
    }else if(textView.tag == 563)
    {
        _address2_string = textView.text;
    }else if(textView.tag == 569)
    {
        _otherinfo_string = textView.text;
    }else if(textView.tag == 555)
    {
        _special_string = textView.text;
    }
    
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

-(void)successmethod_saveLocationDataRequest:(GISJsonRequest *)response
{
    NSDictionary *saveUpdateDict;
    NSArray *responseArray= response.responseJson;
    saveUpdateDict = [responseArray lastObject];
    NSLog(@"successmethod_saveUpdateRequest Success---%@",saveUpdateDict);
    
    if ([[saveUpdateDict objectForKey:kStatusCode] isEqualToString:@"200"]) {
        
        NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
        [userDefaults synchronize];
        [userDefaults setValue:[saveUpdateDict valueForKey:kDropDownValue] forKey:kDropDownValue];
        [userDefaults setValue:[saveUpdateDict valueForKey:kDropDownID] forKey:kDropDownID];
        
        appDelegate.isFromlocation  = YES;
        GISDatesAndTimesViewController *datesAndTimesViewController;
        [self removeLoadingView];
        appDelegate.isFromContacts = YES;
        
        datesAndTimesViewController =[[GISDatesAndTimesViewController alloc]initWithNibName:@"GISDatesAndTimesViewController" bundle:nil];
        
        NSDictionary *infoDict=[NSDictionary dictionaryWithObjectsAndKeys:@"4",@"tabValue",[NSNumber numberWithBool:YES],@"isFromContacts",nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:kTabSelected object:nil userInfo:infoDict];
        
    }else{
        appDelegate.isFromlocation  = NO;
        [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_Failed",TABLE, nil)];
        [self removeLoadingView];
    }
}

-(void)failuremethod_saveLocationDataRequest:(GISJsonRequest *)response
{
    [self removeLoadingView];
    appDelegate.isFromlocation  = NO;
    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_Failed",TABLE, nil)];
}

-(void)successmethod_getoffLocationRequestDetails:(GISJsonRequest *)response
{
    NSLog(@"successmethod_getRequestDetails Success---%@",response.responseJson);
    
    if ([response.responseJson isKindOfClass:[NSArray class]])
    {
        id array=response.responseJson;
        NSDictionary *dictHere=[array lastObject];
        if ([[dictHere objectForKey:kStatusCode] isEqualToString:@"200"]) {
            
            NSMutableArray *chooseReqDetailedArray=[[GISStoreManager sharedManager]getChooseRequestDetailsObjects];
            if (chooseReqDetailedArray.count>0) {
                
                _chooseRequestDetailsObj=[chooseReqDetailedArray lastObject];
            }
            
            _address1_string = [dictHere objectForKey:kOffLoc_Address1];
            _address2_string = [dictHere objectForKey:kOffLoc_Address2];
            _LocationName_string = [dictHere objectForKey:kOffLoc_LocationName];
            _city_string = [dictHere objectForKey:kOffLoc_City];
            _state_string = [dictHere objectForKey:kOffLoc_State];
            _zip_string = [dictHere objectForKey:kOffLoc_Zip];
            _closestMetro_Id_string = [dictHere objectForKey:kOffLoc_Closestmetro];
            
            for (GISDropDownsObject *dropDownObj in _closestMetroArray) {
                if ([dropDownObj.id_String isEqualToString:_closestMetro_Id_string]) {
                    _closestMetrodata =  dropDownObj.value_String;
                }
            }
            
            [_locationDetaislTabelView reloadData];
        }
    }
    
}

-(void)failuremethod_getoffLocationRequestDetails:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"Failure");
    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
}

-(void) getLocationDetails{
    
    @try {
        
        //NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
        NSMutableArray *chooseReqDetailedArray=[[GISStoreManager sharedManager]getChooseRequestDetailsObjects];
        if (chooseReqDetailedArray.count>0) {
            
            _chooseRequestDetailsObj=[chooseReqDetailedArray lastObject];
            NSLog(@"----now--%@",_chooseRequestDetailsObj.inCompleteTab_String_chooseReqParsedDetails);
            
            for (GISDropDownsObject *dropDownObj in _chooseReqArray) {
                if ([dropDownObj.value_String isEqualToString:_chooseRequestDetailsObj.requestNo_String_chooseReqParsedDetails]) {
                    _choose_req_Id_string=dropDownObj.id_String;
                    _chooseRequestData = dropDownObj.value_String;
                }
            }
            
            for (GISDropDownsObject *dropDownObj in _generalLocationArray) {
                if ([dropDownObj.id_String isEqualToString:_chooseRequestDetailsObj.generalLocation_String_chooseReqParsedDetails]) {
                    _generalLocationId_string = dropDownObj.id_String;
                    _generalLocationdata =  dropDownObj.value_String;
                }
            }
            
            
            if([_chooseRequestDetailsObj.generalLocation_String_chooseReqParsedDetails length] == 0)
                _generalLocationId_string = @"1";
            
            
            NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
            NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
            GISLoginDetailsObject *unitObj1=[requetId_array lastObject];
            NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
            [paramsDict setObject:unitObj1.token_string forKey:kToken];
            [paramsDict setObject:_generalLocationId_string forKey:kID];
            [paramsDict setObject:unitObj1.requestorID_string forKey:kLocationrequestorid];
            
            [[GISServerManager sharedManager] getLocation_Details_Data:self withParams:paramsDict finishAction:@selector(successmethod_getLocationRequestDetails:) failAction:@selector(failuremethod_getLocationRequestDetails:)];
            
            
            for (GISDropDownsObject *dropDownObj in _closestMetroArray) {
                if ([dropDownObj.id_String isEqualToString:_chooseRequestDetailsObj.ClosestMetro_String_chooseReqParsedDetails]) {
                    _closestMetro_Id_string = dropDownObj.id_String;
                    _closestMetrodata =  dropDownObj.value_String;
                }
            }
            
            for (GISDropDownsObject *dropDownObj in _buildingNameArray) {
                if ([dropDownObj.id_String isEqualToString:_chooseRequestDetailsObj.building_Id_String_chooseReqParsedDetails]) {
                    _buildingNamedata =  dropDownObj.value_String;
                    _buildingname_Id_string = dropDownObj.id_String;
                }
            }
            
            if([_chooseRequestDetailsObj.ClosestMetro_String_chooseReqParsedDetails length] == 0)
                _closestMetrodata = @"";

            
            _LocationName_string =[self returningstring:_chooseRequestDetailsObj.offCamp_LocationName_String_chooseReqParsedDetails];
            _address1_string = [self returningstring:_chooseRequestDetailsObj.offCamp_address1_String_chooseReqParsedDetails];
            _address2_string = [self returningstring:_chooseRequestDetailsObj.offCamp_address2_String_chooseReqParsedDetails];
            _city_string = [self returningstring:_chooseRequestDetailsObj.offCamp_city_String_chooseReqParsedDetails];
            _state_string = [self returningstring:_chooseRequestDetailsObj.offCamp_state_String_chooseReqParsedDetails];
            _zip_string = [self returningstring:_chooseRequestDetailsObj.offCamp_zip_String_chooseReqParsedDetails];
            _otherinfo_string =[self returningstring:_chooseRequestDetailsObj.otherInfo_String_chooseReqParsedDetails];
            _other_string =  [self returningstring:_chooseRequestDetailsObj.other_String_chooseReqParsedDetails];
            _parking_value_String =[self returningstring:_chooseRequestDetailsObj.parking_String_chooseReqParsedDetails];
            _room_name_string = [self returningstring:_chooseRequestDetailsObj.RoomName_String_chooseReqParsedDetails];
            _room_no_string = [self returningstring:_chooseRequestDetailsObj.RoomNunber_String_chooseReqParsedDetails];
            _requestorLocationId_string = [self returningstring:_chooseRequestDetailsObj.reqLocation_Id_chooseReqParsedDetails];
            
            _transportation_string = [self returningstring:_chooseRequestDetailsObj.transportation_String_chooseReqParsedDetails];
            
            _transportationYes_string = [self returningstring:_chooseRequestDetailsObj.transportationYes_String_chooseReqParsedDetails];
            
            if([_generalLocationId_string isEqualToString:@"1"]){
                
                _specialProtocol_string = [self returningstring:_chooseRequestDetailsObj.SpecialProtocol_String_chooseReqParsedDetails];
                
                if([_parking_value_String length] >0){
                    _getParkingOfflocArray = [[NSMutableArray alloc] initWithArray:[_parking_value_String componentsSeparatedByString:@","]];
                    if([_parkingArray count]>0)
                        [_parkingArray removeAllObjects];
                }
            }else{
                
                _special_string = [self returningstring:_chooseRequestDetailsObj.SpecialProtocol_String_chooseReqParsedDetails];
                
                if([_parking_value_String length] >0){
                    _getParkingArray = [[NSMutableArray alloc] initWithArray:[_parking_value_String componentsSeparatedByString:@","]];
                    if([_parkingArray count]>0)
                        [_parkingArray removeAllObjects];
                }
            }
        }
        
        [self removeLoadingView];
    }
    @catch (NSException *exception) {
        [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in get locationdetails action %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
    }
    
}

-(NSString *)returningstring:(id)string
{
    if ([string length] == 0)
    {
        return @"";
    }
    else
    {
        if (![string isKindOfClass:[NSString class]])
        {
            NSString *str= [string stringValue];
            return str;
        }
        else
        {
            return string;
        }
    }
    
}

-(void)selectedChooseRequestNumber:(NSNotification*)notification
{
    NSDictionary *dict=[notification userInfo];
    [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
    NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
    NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
    GISLoginDetailsObject *unitObj1=[requetId_array lastObject];
    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
    [paramsDict setObject:appDelegate.chooseRequest_ID_String forKey:kID];
    [paramsDict setObject:unitObj1.token_string forKey:kToken];
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults synchronize];
    [userDefaults setValue:[dict valueForKey:@"value"] forKey:kDropDownValue];
    [userDefaults setValue:[dict valueForKey:@"id"] forKey:kDropDownID];
    
    [[GISServerManager sharedManager] getEventDetailsData:self withParams:paramsDict finishAction:@selector(successmethod_getRequestDetails:) failAction:@selector(failuremethod_getRequestDetails:)];
    
}
-(void)successmethod_getRequestDetails:(GISJsonRequest *)response
{
    NSLog(@"successmethod_getRequestDetails Success---%@",response.responseJson);
    [[GISStoreManager sharedManager] removeChooseRequestDetailsObjects];
    _chooseRequestDetailsObj=[[GISChooseRequestDetailsObject alloc]initWithStoreChooseRequestDetailsDictionary:response.responseJson];
    [[GISStoreManager sharedManager]addChooseRequestDetailsObject:_chooseRequestDetailsObj];
    
    [self removeLoadingView];
    
    appDelegate.createdDateString = _chooseRequestDetailsObj.createdDate_String_chooseReqParsedDetails;
    appDelegate.createdByString = [NSString stringWithFormat:@"%@ %@", _chooseRequestDetailsObj.reqFirstName_String_chooseReqParsedDetails,_chooseRequestDetailsObj.reqLastName_String_chooseReqParsedDetails];
    appDelegate.statusString = _chooseRequestDetailsObj.requestStatus_String_chooseReqParsedDetails;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:kRequestInfo object:nil];
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults setValue:_chooseRequestDetailsObj.unitID_String_chooseReqParsedDetails forKey:kunitid];
    [self getLocationDetails];
}

-(void)failuremethod_getRequestDetails:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"Failure");
    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kselectedChooseReqNumber object:nil];
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
