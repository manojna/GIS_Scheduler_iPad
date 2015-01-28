//
//  GISEventDetailsViewController.m
//  GIS_Scheduler
//
//  Created by Anand on 15/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISEventDetailsViewController.h"
#import "GISEventDetailsCell.h"
#import "GISPreparationMaterialCell.h"
#import "GISDatabaseManager.h"
#import "GISUtility.h"
#import "GISConstants.h"
#import "GISFonts.h"
#import "GISNetworkUtility.h"
#import "GISLoginDetailsObject.h"
#import "GISJSONProperties.h"
#import "GISStoreManager.h"
#import "GISServerManager.h"
#import "PCLogger.h"
#import "GISJsonRequest.h"
#import "GISAttendeesViewController.h"
#import "GISLoadingView.h"
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetRepresentation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "GISProperties.h"
#import "GISJSONProperties.h"

#define RECORDED_TYPE 9632
#define REENTER_TYPE 7632

@interface GISEventDetailsViewController ()

@end

@implementation GISEventDetailsViewController

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
    
    self.navigationItem.backBarButtonItem=nil;
    
    appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
    NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
    login_Obj=[requetId_array lastObject];


    [_eventDetaislTabelView setContentSize:CGSizeMake(1024, 880)];
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    _eventdetails_unitIdStr = [userDefaults valueForKey:kunitid];
    
    _otherServicesArray = [[NSArray alloc] initWithObjects:NSLocalizedStringFromTable(@"empty_selection", TABLE, nil),@"Captioning",@"VRI", nil];
    _viewingTypeArray = [[NSArray alloc] initWithObjects:NSLocalizedStringFromTable(@"empty_selection", TABLE, nil),@"Individuals", nil];
    _captionTypeArray = [[NSArray alloc] initWithObjects:NSLocalizedStringFromTable(@"empty_selection", TABLE, nil),@"Onsite", nil];
    
    eventTypedata = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    dresscodeData = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    otherServicesdata = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    captionData = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    viewingTypeData = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
    
    otherTechStr = [[NSMutableArray alloc] init];
    _othertechvalueStr = [[NSMutableString alloc] init];
    _fields = [[NSMutableString alloc] init];
    
    _open_toPublicStr = @"";
     _outsideAgencyStr = @"";
    
     material_types_Array=[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4", nil];
    
    GISBilingDataObject *billingDataObj;
    NSMutableArray *billingArray=[[GISStoreManager sharedManager]getBillingDataObject];
    billingDataObj=[billingArray lastObject];
    
    NSString *mailStr;
    NSRange newRange = [billingDataObj.buh_email_String rangeOfString:@"@"];
    if(newRange.location != NSNotFound) {
        mailStr = [billingDataObj.buh_email_String substringFromIndex:newRange.location+1];
    }
    
    if([mailStr length]>0){
        NSRange nRange = [mailStr rangeOfString:@"."];
        if(nRange.location != NSNotFound) {
            unitString = [mailStr substringFromIndex:nRange.location];
        }
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectedChooseRequestNumber:) name:kselectedChooseReqNumber object:nil];
    
    NSString *eventCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_EVENT_TYPE;"];
    NSString *dressCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_DRESS_CODE;"];
    
    _eventTypeArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:eventCode_statement];
    _dresscodeArray = [[GISDatabaseManager sharedDataManager] getDropDownArray:dressCode_statement];
    
    if([appDelegate.chooseRequest_ID_String length] > 0 && ![appDelegate.chooseRequest_ID_String isEqualToString:@"0"]){
            
        NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
        NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
        
        GISLoginDetailsObject *unitObj1=[requetId_array lastObject];
        NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
        [paramsDict setObject:appDelegate.chooseRequest_ID_String forKey:kID];
        [paramsDict setObject:unitObj1.token_string forKey:kToken];
        
        [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
        
        [[GISServerManager sharedManager] getEventDetailsData:self withParams:paramsDict finishAction:@selector(successmethod_getRequestDetails:) failAction:@selector(failuremethod_getRequestDetails:)];
        
    }else{
        
        if([_open_toPublicStr length] == 0)
            _open_toPublicStr = @"";
        if([_dressCode_Id_string length] == 0)
            _dressCode_Id_string = @"";
        if([_eventTypeId_string length] == 0)
            _eventTypeId_string = @"";
        if([_on_goingStr length] == 0)
            _on_goingStr = @"";
        if([_re_broadcastStr length] == 0)
            _re_broadcastStr= @"";
        if([_outsideAgencyStr length] == 0)
            _outsideAgencyStr = @"";
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISEventDetailsCell *eventCell;
    if(indexPath.section == 0){
        
        eventCell=(GISEventDetailsCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return eventCell.frame.size.height;
    }
    if(indexPath.section == 1){
        
      GISPreparationMaterialCell * preparationMaterialCell=(GISPreparationMaterialCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return preparationMaterialCell.frame.size.height;

    }
    
    return eventCell.frame.size.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISEventDetailsCell *cell;
    if(indexPath.section == 0){
        cell=(GISEventDetailsCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if(cell==nil)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISEventDetailsCell" owner:self options:nil]objectAtIndex:0];
        }

        if([unitString isEqualToString:@".edu"]){
            
            [cell.outSideAgency_label setHidden:FALSE];
            [cell.outSideAgencyno_label setHidden:FALSE];
            [cell.outSideAgencyyes_label setHidden:FALSE];
            [cell.outsideAgency1 setHidden:FALSE];
            [cell.outsideAgency2 setHidden:FALSE];
        }
        
        [cell.opentoPublicbtn1 addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.opentoPublicbtn2 addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.recorded1 addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.recorded2 addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.onGoing1 addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.ongoing2 addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.fmSystembtn addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.microPhonebtn addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.phnConferencebtn addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.webinarbtn addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.outsideAgency1 addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.outsideAgency2 addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.eventTypebtn addTarget:self action:@selector(showPopoverDetails:) forControlEvents:UIControlEventTouchUpInside];
        [cell.dressCodebtn addTarget:self action:@selector(showPopoverDetails:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.eventTypebtn setTitle:eventTypedata forState:UIControlStateNormal];
        [cell.dressCodebtn setTitle:dresscodeData forState:UIControlStateNormal];
        [cell.eventName_textField setDelegate:self];
        [cell.course_textField setDelegate:self];
        
        cell.eventName_textField.text = evevntNamedata;
        cell.course_textField.text = courseIdData;
        
        [cell.eventTypebtn setTag:1];
        [cell.dressCodebtn setTag:2];
        
        [cell.opentoPublicbtn1 setTag:3];
        [cell.opentoPublicbtn2 setTag:4];
        [cell.recorded1 setTag:5];
        [cell.recorded2 setTag:6];
        [cell.onGoing1 setTag:7];
        [cell.ongoing2 setTag:8];
        [cell.fmSystembtn setTag:9];
        [cell.microPhonebtn setTag:10];
        [cell.phnConferencebtn setTag:11];
        [cell.webinarbtn setTag:12];
        [cell.broadcastYesSelcted  setTag:555];
        [cell.outsideAgency1 setTag:57];
        [cell.outsideAgency2 setTag:58];
        
        if([_open_toPublicStr isEqualToString:@"true"]){
            
            [cell.opentoPublicbtn1 setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }else if([_open_toPublicStr isEqualToString:@"false"]){
            [cell.opentoPublicbtn2 setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }
        
        
        if([_re_broadcastStr isEqualToString:@"true"]){
            cell.broadcastYesSelcted.text = _broadcastType_Str;
            [cell.recorded1 setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }else if([_re_broadcastStr isEqualToString:@"false"]){
             cell.broadcastYesSelcted.text = @"";
             [cell.recorded2 setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }
        
        if([_on_goingStr isEqualToString:@"true"]){
            
            [cell.onGoing1 setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }else if([_on_goingStr isEqualToString:@"false"]){
            [cell.ongoing2 setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }
        
        if([_outsideAgencyStr isEqualToString:@"true"]){
            
            [cell.outsideAgency1 setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }else if([_outsideAgencyStr isEqualToString:@"false"]){
            [cell.outsideAgency2 setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }
        
        
        if([otherTechStr count] >0){
            _otherTechArray = [[NSArray alloc] initWithArray:otherTechStr];
            
            
            for(int i=0 ;i<[_otherTechArray count];i++)
            {
                NSString *value = [_otherTechArray objectAtIndex:i];
                switch ([value intValue]) {
                    case 1:
                        [cell.fmSystembtn setBackgroundImage: [UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
                        break;
                    case 2:
                        [cell.microPhonebtn setBackgroundImage: [UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
                        break;
                    case 3:
                        [cell.phnConferencebtn setBackgroundImage: [UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
                        break;
                    case 4:
                        [cell.webinarbtn setBackgroundImage: [UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
                        break;
                    default:
                        break;
                }
            }
        }
    }
    
    if(indexPath.section == 1){
       GISPreparationMaterialCell *cell=(GISPreparationMaterialCell *)[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if(cell==nil)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISPreparationMaterialCell" owner:self options:nil]objectAtIndex:0];
        }
        
        [cell.otherServicesbtn addTarget:self action:@selector(showPopoverDetails:) forControlEvents:UIControlEventTouchUpInside];
        [cell.captionTypebtn addTarget:self action:@selector(showPopoverDetails:) forControlEvents:UIControlEventTouchUpInside];
        [cell.viewingTypebtn addTarget:self action:@selector(showPopoverDetails:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.documentbtn addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.blackboardAccessbtn addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.websitebtn addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [cell.othersbtn addTarget:self action:@selector(previousVersionBtnTap:) forControlEvents:UIControlEventTouchUpInside];

        if([_otherServices_Str isEqualToString:@"1"]){
            [cell.otherServicesbtn setTitle:@"Captioning" forState:UIControlStateNormal];
            cell.captionTypebtn.enabled = TRUE;
        }else if([_otherServices_Str isEqualToString:@"2"]){
            [cell.otherServicesbtn setTitle:@"VRI" forState:UIControlStateNormal];
            cell.captionTypebtn.enabled = FALSE;
        }else{
            [cell.otherServicesbtn setTitle:@"" forState:UIControlStateNormal];
            cell.captionTypebtn.enabled = TRUE;
            
        }
        
        [cell.otherServicesbtn setTitle:otherServicesdata forState:UIControlStateNormal];
        [cell.captionTypebtn setTitle:captionData forState:UIControlStateNormal];
        [cell.viewingTypebtn setTitle:viewingTypeData forState:UIControlStateNormal];
        
        [cell.documentbtn setTag:44];
        [cell.blackboardAccessbtn setTag:111];
        [cell.websitebtn setTag:22];
        [cell.othersbtn setTag:33];
        
        [cell.otherServicesbtn setTag:13];
        [cell.captionTypebtn setTag:14];
        [cell.viewingTypebtn setTag:15];
        
        cell.descriptionTextView.text = descriptionData;
        
        [cell.descriptionTextView setDelegate:self];
        
        [cell.noOfUsersTextField setTag:666];
        [cell.noOfUsersTextField setDelegate:self];
        cell.noOfUsersTextField.text = noOfUsersData;
        
        [cell.nextButton addTarget:self action:@selector(nextButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if([chooseRequest_Detailed_DetailsObj.website_String_chooseReqParsedDetails length]>0)
        {
            [cell.websitebtn  setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
            cell.websiteTextField.text = chooseRequest_Detailed_DetailsObj.website_String_chooseReqParsedDetails;
            _websiteStr = chooseRequest_Detailed_DetailsObj.website_String_chooseReqParsedDetails;
            
            [cell.websiteTextField setHidden:NO];
        }else{
            [cell.websitebtn  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            cell.websiteTextField.text = chooseRequest_Detailed_DetailsObj.website_String_chooseReqParsedDetails;
            _websiteStr = chooseRequest_Detailed_DetailsObj.website_String_chooseReqParsedDetails;
            
            [cell.websiteTextField setHidden:YES];
        }
        
        if([chooseRequest_Detailed_DetailsObj.balckboardAccess_String_chooseReqParsedDetails length]>0)
        {
            [cell.blackboardAccessbtn  setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
            cell.blackboardAccessTextField.text = chooseRequest_Detailed_DetailsObj.balckboardAccess_String_chooseReqParsedDetails;
            _blackboard_accessStr = chooseRequest_Detailed_DetailsObj.balckboardAccess_String_chooseReqParsedDetails;
            
            [cell.blackboardAccessTextField setHidden:NO];
        }else{
            [cell.blackboardAccessbtn  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            cell.blackboardAccessTextField.text = chooseRequest_Detailed_DetailsObj.balckboardAccess_String_chooseReqParsedDetails;
            _blackboard_accessStr = chooseRequest_Detailed_DetailsObj.balckboardAccess_String_chooseReqParsedDetails;
            
            [cell.blackboardAccessTextField setHidden:YES];
        }
        if([chooseRequest_Detailed_DetailsObj.other_materialType_String_chooseReqParsedDetails length]>0)
        {
            [cell.othersbtn  setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
            cell.othersTextField.text = chooseRequest_Detailed_DetailsObj.other_materialType_String_chooseReqParsedDetails;
            _other_Str = chooseRequest_Detailed_DetailsObj.other_materialType_String_chooseReqParsedDetails;
            
            [cell.othersTextField setHidden:NO];
        }else{
            [cell.othersbtn  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            cell.othersTextField.text = chooseRequest_Detailed_DetailsObj.other_materialType_String_chooseReqParsedDetails;
            _other_Str = chooseRequest_Detailed_DetailsObj.other_materialType_String_chooseReqParsedDetails;
            
            [cell.othersTextField setHidden:YES];
            
        }
        if([chooseRequest_Detailed_DetailsObj.document_String_chooseReqParsedDetails length]>0)
        {
            [cell.documentbtn  setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
            _document_Str = chooseRequest_Detailed_DetailsObj.document_String_chooseReqParsedDetails;
            
            NSRange range = [_document_Str rangeOfString:@"~" options:NSBackwardsSearch];
            if (range.location == NSNotFound) {
                
            } else {
                NSString *filepath = [_document_Str substringFromIndex:[_document_Str rangeOfString:@"~"options:NSBackwardsSearch].location+1];
                _document_Str = filepath;
            }
            
            cell.document_attach_label.text = _document_Str;
        }else{
            [cell.documentbtn  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            cell.document_attach_label.text = chooseRequest_Detailed_DetailsObj.document_String_chooseReqParsedDetails;
            _document_Str = chooseRequest_Detailed_DetailsObj.document_String_chooseReqParsedDetails;
            
        }

        cell.selectionStyle=UITableViewCellSelectionStyleNone;

        
        return cell;
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    
    return cell;
}


- (IBAction)previousVersionBtnTap:(id)sender{
    
    int item_value;

    
    UIButton *btn=(UIButton*)sender;
    
    NSIndexPath *indexPath = [_eventDetaislTabelView indexPathForCell:(UITableViewCell *)[[[btn superview] superview] superview]];
    
    GISPreparationMaterialCell *preparationCell = (GISPreparationMaterialCell *)[_eventDetaislTabelView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
    
    if(btn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
        UILabel *broadcastSelectedLabel=(UILabel *)[self.view viewWithTag:555];

        
        if(btn.tag == 111){
            
            [preparationCell.blackboardAccessTextField setHidden:TRUE];
        }else if(btn.tag == 22){
            [preparationCell.websiteTextField setHidden:TRUE];
            
        }else if(btn.tag == 33){
            [preparationCell.othersTextField setHidden:TRUE];
        }else if(btn.tag == 44){
            preparationCell.document_attach_label.text = @"";
            _document_Str = @"";
        }
        
        if(btn.tag == 3){
            _open_toPublicStr = @" ";
        }else if(btn.tag == 4){
            _open_toPublicStr = @" ";
        }else if(btn.tag == 5){
            _re_broadcastStr = @" ";
            broadCastSelected = NO;
            [broadcastSelectedLabel setText:@""];
        }else if(btn.tag == 6){
            _re_broadcastStr = @" ";
            broadCastSelected = NO;
            [broadcastSelectedLabel setText:@""];
        }else if(btn.tag == 7){
            _on_goingStr = @" ";
        }else if(btn.tag == 8){
            _on_goingStr = @" ";
        }else if(btn.tag == 57){
            _outsideAgencyStr = @"";
        }else if(btn.tag == 58){
            _outsideAgencyStr = @"";
        }else if(btn.tag == 9){
            item_value = 1;
            if([otherTechStr count]>0)
            {
                [otherTechStr removeObject:[NSString stringWithFormat:@"%d",item_value]];
                
            }
        }else if(btn.tag == 10){
            item_value = 2;
            if([otherTechStr count]>0)
            {
                [otherTechStr removeObject:[NSString stringWithFormat:@"%d",item_value]];
                
            }
        }else if(btn.tag == 11){
            item_value = 3;
            if([otherTechStr count]>0)
            {
                [otherTechStr removeObject:[NSString stringWithFormat:@"%d",item_value]];
                
            }
        }else if(btn.tag == 12){
            item_value = 4;
            if([otherTechStr count]>0)
            {
                [otherTechStr removeObject:[NSString stringWithFormat:@"%d",item_value]];
                
            }
        }
        
        NSLog(@"other tech string valuee ----------- %@",otherTechStr);


        
    }
    else
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];

        if(btn.tag == 111){
            
            [preparationCell.blackboardAccessTextField setHidden:FALSE];
        }else if(btn.tag == 22){
            [preparationCell.websiteTextField setHidden:FALSE];
            
        }else if(btn.tag == 33){
            [preparationCell.othersTextField setHidden:FALSE];
        }else if(btn.tag == 44){
            
            UIButton *document_btn=(UIButton *)[self.view viewWithTag:btn.tag];
            id tempCellRef=(GISPreparationMaterialCell *)[GISUtility findParentTableViewCell:document_btn];//document_btn.superview.superview.superview;
          GISPreparationMaterialCell *preparationCell=(GISPreparationMaterialCell *)tempCellRef;
            
            if ([self.popover isPopoverVisible]) {
                [self.popover dismissPopoverAnimated:YES];
            } else {
                if ([UIImagePickerController isSourceTypeAvailable:
                     UIImagePickerControllerSourceTypeSavedPhotosAlbum])
                {
                    UIImagePickerController *imagePicker =
                    [[UIImagePickerController alloc] init];
                    imagePicker.delegate = self;
                    imagePicker.sourceType =
                    UIImagePickerControllerSourceTypePhotoLibrary;
                    imagePicker.mediaTypes = [NSArray arrayWithObjects:
                                              (NSString *) kUTTypeImage,
                                              nil];
                    imagePicker.allowsEditing = NO;
                    
                    self.popover = [[UIPopoverController alloc]
                                              initWithContentViewController:imagePicker];
                    
                    self.popover.delegate = self;
                    
                    [self.popover
                     presentPopoverFromRect:document_btn.frame inView:preparationCell.contentView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                }
            }

            
        }else if(btn.tag == 3){
            _open_toPublicStr = @"true";
            UIButton *btnn=(UIButton *)[self.view viewWithTag:4];
            if(btnn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])
            {
                [btnn setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            }
            
        }else if(btn.tag == 4){
            _open_toPublicStr = @"false";
            UIButton *btnn=(UIButton *)[self.view viewWithTag:3];
            if(btnn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])
            {
                [btnn setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            }
        }else if(btn.tag == 5){
            _re_broadcastStr = @"true";
            UIButton *btnn=(UIButton *)[self.view viewWithTag:6];
            if(btnn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])
            {
                [btnn setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            }
            [self showBroadcastAlertView];
            
        }else if(btn.tag == 6){
            _re_broadcastStr = @"false";
            UIButton *btnn=(UIButton *)[self.view viewWithTag:5];
            if(btnn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])
            {
                [btnn setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            }
            
            UILabel *broadcastSelectedLabel=(UILabel *)[self.view viewWithTag:555];
            [broadcastSelectedLabel setText:@""];
            
            broadCastSelected = NO;
            
        }else if(btn.tag == 7){
            _on_goingStr = @"true";
            UIButton *btnn=(UIButton *)[self.view viewWithTag:8];
            if(btnn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])
            {
                [btnn setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            }
            
        }else if(btn.tag == 8){
            _on_goingStr = @"false";
            UIButton *btnn=(UIButton *)[self.view viewWithTag:7];
            if(btnn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])
            {
                [btnn setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            }
        }else if(btn.tag == 57){
            _outsideAgencyStr = @"true";
            UIButton *btnn=(UIButton *)[self.view viewWithTag:58];
            if(btnn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])
            {
                [btnn setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            }
            
        }else if(btn.tag == 58){
            _outsideAgencyStr = @"false";
            UIButton *btnn=(UIButton *)[self.view viewWithTag:57];
            if(btnn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])
            {
                [btnn setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            }
        }else if(btn.tag == 9){
            item_value = 1;
            [otherTechStr addObject:[NSString stringWithFormat:@"%d",item_value]];
        }else if(btn.tag == 10){
            item_value = 2;
            [otherTechStr addObject:[NSString stringWithFormat:@"%d",item_value]];
        }else if(btn.tag == 11){
            item_value = 3;
            [otherTechStr addObject:[NSString stringWithFormat:@"%d",item_value]];
        }else if(btn.tag == 12){
            item_value = 4;
            [otherTechStr addObject:[NSString stringWithFormat:@"%d",item_value]];
        }
    }
}

- (IBAction)showPopoverDetails:(id)sender{
    
    UIButton *btn=(UIButton*)sender;
    
    btn_tag = btn.tag;
    
    GISPopOverTableViewController *tableViewController = [[GISPopOverTableViewController alloc] initWithNibName:@"GISPopOverTableViewController" bundle:nil];
    
    tableViewController.popOverDelegate = self;
    if(btn.tag == 1){
        _popover =   [GISUtility showPopOver:(NSMutableArray *)_eventTypeArray viewController:tableViewController];
    }else if(btn.tag == 2){
        _popover =   [GISUtility showPopOver:(NSMutableArray *)_dresscodeArray viewController:tableViewController];
    }else if(btn.tag == 13){
        _popover =   [GISUtility showPopOver:(NSMutableArray *)_otherServicesArray viewController:tableViewController];
        _popover.popoverContentSize = CGSizeMake(300, 120);
    }else if(btn.tag == 14){
        _popover =   [GISUtility showPopOver:(NSMutableArray *)_captionTypeArray viewController:tableViewController];
        _popover.popoverContentSize = CGSizeMake(300, 80);
    }else if(btn.tag == 15){
        _popover =   [GISUtility showPopOver:(NSMutableArray *)_viewingTypeArray viewController:tableViewController];
        _popover.popoverContentSize = CGSizeMake(300, 80);
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
        eventTypedata= value_str;
        UIButton *eventTypeBtn=(UIButton *)[self.view viewWithTag:1];
        [eventTypeBtn setTitle:eventTypedata forState:UIControlStateNormal];
        _eventTypeId_string=id_str;
       
    }else if(btn_tag == 2){
        dresscodeData = value_str;
        UIButton *dressCodeBtn=(UIButton *)[self.view viewWithTag:2];
        [dressCodeBtn setTitle:dresscodeData forState:UIControlStateNormal];
        _dressCode_Id_string=id_str;
    }else if(btn_tag == 13){
        otherServicesdata = value_str;
        UIButton *otherServicesBtn=(UIButton *)[self.view viewWithTag:13];
         UIButton *captionBtn=(UIButton *)[self.view viewWithTag:14];
        [otherServicesBtn setTitle:otherServicesdata forState:UIControlStateNormal];
        if([otherServicesdata isEqualToString:@"VRI"]){
            _otherServices_Str = @"2";
            captionBtn.enabled = FALSE;
        }else if([otherServicesdata isEqualToString:NSLocalizedStringFromTable(@"empty_selection", TABLE, nil)]){
            _otherServices_Str = @"0";
            captionData = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
            viewingTypeData = NSLocalizedStringFromTable(@"empty_selection", TABLE, nil);
            
            UIButton *captionBtn=(UIButton *)[self.view viewWithTag:14];
            [captionBtn setTitle:captionData forState:UIControlStateNormal];
            UIButton *viewTypeBtn=(UIButton *)[self.view viewWithTag:15];
            [viewTypeBtn setTitle:viewingTypeData forState:UIControlStateNormal];

        }else{
            _otherServices_Str = @"1";
            captionBtn.enabled = TRUE;
        }
        
    }else if(btn_tag == 14){
        captionData = value_str;
        UIButton *captionBtn=(UIButton *)[self.view viewWithTag:14];
        [captionBtn setTitle:captionData forState:UIControlStateNormal];
    }else if(btn_tag == 15){
        viewingTypeData = value_str;
        UIButton *viewTypeBtn=(UIButton *)[self.view viewWithTag:15];
        [viewTypeBtn setTitle:viewingTypeData forState:UIControlStateNormal];
    }
    
    if(_popover)
        [_popover dismissPopoverAnimated:YES];
    
   // [_eventDetaislTabelView reloadData];
    
}

- (void)showBroadcastAlertView{
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"type_Of_Record_Broadcast", TABLE, nil) message:@"" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    _alertCustomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 210, 110)];
    
    UIButton *addButton = [[UIButton alloc] init];
    addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
    [addButton addTarget:self
                  action:@selector(previousVersionBtnTap:)
        forControlEvents:UIControlEventTouchUpInside];
    addButton.frame = CGRectMake(70.0, 5.0, 28.0, 28.0);
    addButton.tag = 16;
    [_alertCustomView addSubview:addButton];
    
    UILabel* headerLabel = [[UILabel alloc] init];
    headerLabel.frame = CGRectMake(addButton.frame.origin.x+5, 10, 80, 15);
    headerLabel.textColor = UIColorFromRGB(0x666666);
    headerLabel.font = [GISFonts normal];
    headerLabel.text=@"Audio";
    [headerLabel setTextAlignment:NSTextAlignmentCenter];
    [_alertCustomView addSubview:headerLabel];
    
    UIButton *addButton1 = [[UIButton alloc] init];
    addButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton1 setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
    [addButton1 addTarget:self
                   action:@selector(previousVersionBtnTap:)
         forControlEvents:UIControlEventTouchUpInside];
    addButton1.frame = CGRectMake(70.0, 40.0, 28.0, 28.0);
    addButton1.tag = 17;
    [_alertCustomView addSubview:addButton1];
    
    UILabel* headerLabel1 = [[UILabel alloc] init];
    headerLabel1.frame = CGRectMake(addButton1.frame.origin.x+5, 45, 80, 15);
    headerLabel1.textColor = UIColorFromRGB(0x666666);
    headerLabel1.font = [GISFonts normal];
    headerLabel1.text=@"Video";
    [headerLabel1 setTextAlignment:NSTextAlignmentCenter];
    [_alertCustomView addSubview:headerLabel1];
    
    UIButton *addButton2 = [[UIButton alloc] init];
    addButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton2 setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
    [addButton2 addTarget:self
                   action:@selector(previousVersionBtnTap:)
         forControlEvents:UIControlEventTouchUpInside];
    addButton2.frame = CGRectMake(70.0, 75.0, 28.0, 28.0);
    addButton2.tag = 18;
    [_alertCustomView addSubview:addButton2];
    
    UILabel* headerLabel2 = [[UILabel alloc] init];
    headerLabel2.frame = CGRectMake(addButton2.frame.origin.x+5, 80, 80, 15);
    headerLabel2.textColor = UIColorFromRGB(0x666666);
    headerLabel2.font = [GISFonts normal];
    headerLabel2.text=@"Both";
    [headerLabel2 setTextAlignment:NSTextAlignmentCenter];
    [_alertCustomView addSubview:headerLabel2];
    
    [av setValue:_alertCustomView forKey:@"accessoryView"];
    av.delegate = self;
    av.tag = RECORDED_TYPE;
    [av show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == RECORDED_TYPE && buttonIndex == 1)
    {
        UIButton *btnn=(UIButton *)[_alertCustomView viewWithTag:16];
        UIButton *btnn1=(UIButton *)[_alertCustomView viewWithTag:17];
        UIButton *btnn2=(UIButton *)[_alertCustomView viewWithTag:18];
        
        broadCastSelected = YES;
        UILabel *broadcastSelectedLabel=(UILabel *)[self.view viewWithTag:555];
        
        if(btnn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])
        {
            _broadcastType_Str = @"Audio";
            
        }else if(btnn1.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])
        {
            _broadcastType_Str = @"Video";
            
        }else if(btnn2.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])
        {
            _broadcastType_Str = @"Both";
        }else{
            
            broadCastSelected = NO;
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) message:NSLocalizedStringFromTable(@"please select one option", TABLE, nil) delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil, nil];
            alert.tag = REENTER_TYPE;
            alert.delegate = self;
            [alert show];
        }
        
        [broadcastSelectedLabel setText:_broadcastType_Str];

        
    }else if(alertView.tag == RECORDED_TYPE && buttonIndex == 0)
    {
        broadCastSelected = NO;
    }else if(alertView.tag == 20 && buttonIndex == 1)
    {
        _blackboard_accessStr = [alertView textFieldAtIndex:0].text;
    }else if(alertView.tag == 21 && buttonIndex == 1)
    {
        _websiteStr = [alertView textFieldAtIndex:0].text;
    }else if(alertView.tag == 22 && buttonIndex == 1){
        
        _other_Str = [alertView textFieldAtIndex:0].text;
    }else if(alertView.tag == REENTER_TYPE && buttonIndex == 0){
        
        [self showBroadcastAlertView];
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSLog(@"textViewShouldBeginEditing:");
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    NSLog(@"textViewDidBeginEditing:");
    NSDictionary *infoDict=[NSDictionary dictionaryWithObjectsAndKeys:@"-360",@"yValue",nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:kMoveUp object:nil userInfo:infoDict];
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    NSLog(@"textViewShouldEndEditing:");
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"textViewDidEndEditing:");
    NSDictionary *infoDict=[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"yValue",nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:kMoveUp object:nil userInfo:infoDict];
    
    [textView resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSCharacterSet *doneButtonCharacterSet = [NSCharacterSet newlineCharacterSet];
    NSRange replacementTextRange = [text rangeOfCharacterFromSet:doneButtonCharacterSet];
    NSUInteger location = replacementTextRange.location;
    
    if (textView.text.length + text.length > 540){
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

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    // Get the cell in which the textfield is embedded
    if(textField.tag == 666){
        NSDictionary *infoDict=[NSDictionary dictionaryWithObjectsAndKeys:@"-290",@"yValue",nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:kMoveUp object:nil userInfo:infoDict];
    }else if(textField.tag != 100 && textField.tag != 101){
        
        NSDictionary *infoDict=[NSDictionary dictionaryWithObjectsAndKeys:@"-210",@"yValue",nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:kMoveUp object:nil userInfo:infoDict];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.tag != 100 && textField.tag != 101){
        // Get the cell in which the textfield is embedded
        NSDictionary *infoDict=[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"yValue",nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:kMoveUp object:nil userInfo:infoDict];
    }
    
    
    if(textField.tag == 100)
        evevntNamedata = textField.text;
    if(textField.tag == 101)
        courseIdData = textField.text;
    if(textField.tag == 222)
        _blackboard_accessStr= textField.text;
    if(textField.tag == 333)
        _websiteStr = textField.text;
    if(textField.tag == 444)
        _other_Str = textField.text;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.tag == 666){
        /*  limit to only numeric characters  */
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        for (int i = 0; i < [string length]; i++) {
            unichar c = [string characterAtIndex:i];
            if ([myCharSet characterIsMember:c]) {
                return YES;
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedStringFromTable(@"please enter Numbers Only", TABLE, nil) delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
                [alert show];
                return NO;
            }
        }
        
        /*  limit the users input to only 9 characters  */
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 9) ? NO : YES;
    }else{
        return YES;
    }
    return NO;
}

- (IBAction)nextButtonClicked:(id)sender{
    
    appDelegate.isFromContacts = YES;
    
    [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
    
    if([appDelegate.chooseRequest_ID_String length]>0 && ![appDelegate.chooseRequest_ID_String isEqualToString:NSLocalizedStringFromTable(@"empty_selection", TABLE, nil)]){
        [self saveEventDetailsData];
    }else{
        
        [self removeLoadingView];
        [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"select_choose_request", TABLE, nil)];
    }
}

-(void)saveEventDetailsData
{
    @try {
        
        if ([[GISNetworkUtility sharedManager] checkNetworkAvailability])
        {
            NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
            //NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
            //NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
            //GISLoginDetailsObject *login_Objs=[requetId_array lastObject];
            
            UITextField *eventNameTextField=(UITextField *)[self.view viewWithTag:100];
            UITextField *courseTextField=(UITextField *)[self.view viewWithTag:101];
            UITextView *descriptionTextView=(UITextView *)[self.view viewWithTag:102];
            UIButton *viewingTypebtn=(UIButton *)[self.view viewWithTag:15];
            UIButton *captioningTypebtn=(UIButton *)[self.view viewWithTag:14];
            UITextField *ofUserstextField=(UITextField *)[self.view viewWithTag:666];
            UILabel *documnet_selected_label=(UILabel *)[self.view viewWithTag:888];
            UITextField *blackBoardTextField=(UITextField *)[self.view viewWithTag:222];
            UITextField *webSiteField=(UITextField *)[self.view viewWithTag:333];
            UITextField *otherMaterilaTypeTextField=(UITextField *)[self.view viewWithTag:444];
            
            UIButton *blackBoardAccessbtn=(UIButton *)[self.view viewWithTag:111];
            UIButton *websitebtn=(UIButton *)[self.view viewWithTag:22];
            UIButton *othersbtn=(UIButton *)[self.view viewWithTag:33];
            UIButton *documentbtn=(UIButton *)[self.view viewWithTag:44];
            
            
            if([eventNameTextField.text length] == 0 || [descriptionTextView.text length] == 0 || [_open_toPublicStr length] == 0 || [_dressCode_Id_string length] == 0 || [_eventTypeId_string length] == 0 || [_re_broadcastStr length] == 0  ||([blackBoardTextField.text length] == 0 && blackBoardAccessbtn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])|| ([webSiteField.text length] == 0 &&websitebtn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])|| ([otherMaterilaTypeTextField.text length] == 0 && othersbtn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"]) || [_re_broadcastStr length] == 0 || (documentbtn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"]&& [documnet_selected_label.text length]==0))
            {
                if([_fields length]>0)
                    [_fields setString:@""];
                
                if([eventNameTextField.text length] == 0)
                    [_fields appendFormat:@"%@%@",@"EventName",@", \n"];
                if([descriptionTextView.text length] == 0)
                    [_fields appendFormat:@"%@%@",@"EventDescription",@", \n"];
                if([_open_toPublicStr length] == 0)
                    [_fields appendFormat:@"%@%@",@"OpenToPublic",@", \n"];
                if([_dressCode_Id_string length] == 0)
                    [_fields appendFormat:@"%@%@",@"Dresscode",@", \n"];
                if([_eventTypeId_string length] == 0)
                    [_fields appendFormat:@"%@%@",@"EventType",@", \n"];
                if([_re_broadcastStr length] == 0)
                    [_fields appendFormat:@"%@%@",@"Recorded/Broadcast",@","];

                if(documentbtn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"] && [documnet_selected_label.text length]==0)
                    [_fields appendFormat:@"%@%@",@"Document",@", \n"];
                if([blackBoardTextField.text length] == 0 && blackBoardAccessbtn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])
                    [_fields appendFormat:@"%@%@",@"Blackboard Access",@", \n"];
                if([webSiteField.text length] == 0 && websitebtn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])
                    [_fields appendFormat:@"%@%@",@"Website",@", \n"];
                if([otherMaterilaTypeTextField.text length] == 0 && othersbtn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"])
                    [_fields appendFormat:@"%@%@",@"Other",@", \n"];
                
                if([unitString isEqualToString:@".edu"]){
                    if([_outsideAgencyStr length] == 0)
                        [_fields appendFormat:@"%@",@"Outside Agency"];
                }
                
                [self removeLoadingView];
                [GISUtility showAlertWithTitle:@"" andMessage:[NSString stringWithFormat:NSLocalizedStringFromTable(@"enter_valid_details",TABLE, nil),_fields]];
                return;
            }
            
            if([unitString isEqualToString:@".edu"] && [_outsideAgencyStr length] == 0){
                
                [_fields setString:@"Outside Agency"];
                [self removeLoadingView];
                [GISUtility showAlertWithTitle:@"" andMessage:[NSString stringWithFormat:NSLocalizedStringFromTable(@"enter_valid_details",TABLE, nil),_fields]];
                return;
            }
            
            if(blackBoardAccessbtn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"]||websitebtn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"]|| othersbtn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"] || documentbtn.currentBackgroundImage == [UIImage imageNamed:@"radio_button_filled.png"]){
                
                [self saveMaterialRequest];
            }
            
            
            [_othertechvalueStr setString:@""];
            for(int i=0; i <[otherTechStr count];i++){
                //othertechvalueStr = [[otherTechStr objectAtIndex:i] componentsJoinedByString:@","];
                [_othertechvalueStr appendFormat:@"%@%@",[otherTechStr objectAtIndex:i],@","];
            }
            NSRange range = [_othertechvalueStr rangeOfString:@"," options:NSBackwardsSearch];
            if (range.location == NSNotFound) {
            } else {
                [_othertechvalueStr setString:[_othertechvalueStr substringToIndex:range.location]];
            }
            _eventdetails_viewOptions=viewingTypebtn.titleLabel.text;
            
            NSMutableArray *chooseReqDetailedArray=[[GISStoreManager sharedManager]getChooseRequestDetailsObjects];
            if (chooseReqDetailedArray.count>0) {
                chooseRequest_Detailed_DetailsObj=[chooseReqDetailedArray lastObject];
            }
            
            if([_eventdetails_statusStr length]== 0)
                _eventdetails_statusStr = @"6";
            
            
            NSLog(@"otherTech str --------- %@",_othertechvalueStr);
            
            
            [paramsDict setObject:appDelegate.chooseRequest_ID_String forKey:keventDetails_requestNo];
            [paramsDict setObject:login_Obj.requestorID_string forKey:keventDetails_requestID];
            [paramsDict setObject:_eventdetails_unitIdStr forKey:keventDetails_unitId];
            [paramsDict setObject:eventNameTextField.text forKey:keventDetails_eventName];
            [paramsDict setObject:_eventTypeId_string forKey:keventDetails_eventId];
            [paramsDict setObject:_open_toPublicStr forKey:keventDetails_eventPublic];
            [paramsDict setObject:_eventdetails_statusStr forKey:keventDetails_statusId];
            [paramsDict setObject:_dressCode_Id_string forKey:keventDetails_dresscodeId];
            [paramsDict setObject:_re_broadcastStr forKey:keventDetails_broadcast];
            [paramsDict setObject:_on_goingStr forKey:keventDetails_onGoing];
            [paramsDict setObject:_othertechvalueStr forKey:keventDetails_Othertech];
            [paramsDict setObject:courseTextField.text forKey:keventDetails_CourseId];
            [paramsDict setObject:descriptionTextView.text forKey:keventDetails_eventDesc];
            [paramsDict setObject:_outsideAgencyStr forKey:keventDetails_OutsideAgency];
            [paramsDict setObject:login_Obj.token_string forKey:keventDetails_token];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.reqLocation_Id_chooseReqParsedDetails] forKey:kChooseReqDetails_reqlocationid];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.generalLocation_String_chooseReqParsedDetails] forKey:kChooseReqDetails_generallocationid];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.building_Id_String_chooseReqParsedDetails] forKey:kChooseReqDetails_buildingid];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.RoomNunber_String_chooseReqParsedDetails] forKey:kChooseReqDetails_roomnunber];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.RoomName_String_chooseReqParsedDetails] forKey:kChooseReqDetails_roomname];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.other_String_chooseReqParsedDetails] forKey:kChooseReqDetails_other];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.offCamp_LocationName_String_chooseReqParsedDetails] forKey:kChooseReqDetails_offcamplocname];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.offCamp_address1_String_chooseReqParsedDetails] forKey:kChooseReqDetails_offcampaddress1];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.offCamp_address2_String_chooseReqParsedDetails] forKey:kChooseReqDetails_offcampaddress2];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.offCamp_state_String_chooseReqParsedDetails] forKey:kChooseReqDetails_offcampstate];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.offCamp_city_String_chooseReqParsedDetails] forKey:kChooseReqDetails_offcampcity];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.offCamp_zip_String_chooseReqParsedDetails] forKey:kChooseReqDetails_offcampzip];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.ClosestMetro_String_chooseReqParsedDetails] forKey:kChooseReqDetails_closestmetro];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.parking_String_chooseReqParsedDetails] forKey:kChooseReqDetails_parking];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.SpecialProtocol_String_chooseReqParsedDetails] forKey:kChooseReqDetails_specialprotocol];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.otherInfo_String_chooseReqParsedDetails] forKey:kChooseReqDetails_other_info];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.offLoc_ID_String_chooseReqParsedDetails] forKey:kChooseReqDetails_OffCampLocID];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.transportation_String_chooseReqParsedDetails] forKey:kChooseReqDetails_Transport];
            [paramsDict setObject:[self returningstring:chooseRequest_Detailed_DetailsObj.transportationYes_String_chooseReqParsedDetails] forKey:kChooseReqDetails_transportnotes];
            
            if([_otherServices_Str length]>0 && ![_otherServices_Str isEqualToString:@"0"]){
                [paramsDict setObject:_otherServices_Str forKey:keventDetails_otherServices];
                if(![_otherServices_Str isEqualToString:@"2"]){
                    
                    NSString *captionTypeStr = captioningTypebtn.titleLabel.text;
                    if([captionTypeStr length]>0)
                        [paramsDict setObject:captionTypeStr forKey:keventDetails_captiontype];
                    else
                        [paramsDict setObject:@"" forKey:keventDetails_captiontype];
                }
            }
            else{
                [paramsDict setObject:@"" forKey:keventDetails_otherServices];
                [paramsDict setObject:@"" forKey:keventDetails_captiontype];
            }
            if([_eventdetails_viewOptions length]>0 && ![_eventdetails_viewOptions  isEqualToString:NSLocalizedStringFromTable(@"empty_selection", TABLE, nil)]){
                [paramsDict setObject:_eventdetails_viewOptions forKey:keventDetails_captionView];
            }
            else{
                [paramsDict setObject:@"" forKey:keventDetails_captionView];
            }
            
            
            [paramsDict setObject:ofUserstextField.text forKey:keventDetails_capnoofUsers];
            if([_broadcastType_Str length]>0)
                [paramsDict setObject:_broadcastType_Str forKey:keventDetails_recordBroadcastYes];
            else
                [paramsDict setObject:@"" forKey:keventDetails_recordBroadcastYes];
            
            if([_otherServices_Str length] > 0 &&  ![_otherServices_Str isEqualToString:@"0"])
            {
                if([_otherServices_Str isEqualToString:@"2"]){
                    if([viewingTypebtn.titleLabel.text isEqualToString:
                        NSLocalizedStringFromTable(@"empty_selection", TABLE, nil)] || [ofUserstextField.text length] == 0)
                    {
                        if([_fields length]>0)
                            [_fields setString:@""];
                        if([viewingTypebtn.titleLabel.text isEqualToString:
                            NSLocalizedStringFromTable(@"empty_selection", TABLE, nil)])
                            [_fields appendFormat:@"%@%@",@"Viewing Type",@", \n"];
                        if([ofUserstextField.text length] == 0)
                            [_fields appendFormat:@"%@%@",@"No Of Users",@", \n"];
                        
                        [self removeLoadingView];
                        [GISUtility showAlertWithTitle:@"" andMessage:[NSString stringWithFormat:NSLocalizedStringFromTable(@"enter_valid_details",TABLE, nil),_fields]];
                    }else{
                        [[GISServerManager sharedManager] saveEventDetailsData:self withParams:paramsDict finishAction:@selector(successmethod_eventDetailsRequest:) failAction:@selector(failuremethod_eventDetailsRequest:)];
                    }
                }else if([_otherServices_Str isEqualToString:@"1"]){
                    if([viewingTypebtn.titleLabel.text isEqualToString:
                        NSLocalizedStringFromTable(@"empty_selection", TABLE, nil)]
                       || [captioningTypebtn.titleLabel.text isEqualToString:NSLocalizedStringFromTable(@"empty_selection", TABLE, nil)]
                       || [ofUserstextField.text length] == 0)
                    {
                        if([_fields length]>0)
                            [_fields setString:@""];
                        
                        if([viewingTypebtn.titleLabel.text isEqualToString:
                            NSLocalizedStringFromTable(@"empty_selection", TABLE, nil)])
                            [_fields appendFormat:@"%@%@",@"Viewing Type",@", \n"];
                        if([ofUserstextField.text length] == 0)
                            [_fields appendFormat:@"%@%@",@"No Of Users",@", \n"];
                        if([captioningTypebtn.titleLabel.text isEqualToString:NSLocalizedStringFromTable(@"empty_selection", TABLE, nil)])
                            [_fields appendFormat:@"%@%@",@"Captioning Type",@","];
                        
                        [self removeLoadingView];
                        [GISUtility showAlertWithTitle:@"" andMessage:[NSString stringWithFormat:NSLocalizedStringFromTable(@"enter_valid_details",TABLE, nil),_fields]];
                    }else{
                        [[GISServerManager sharedManager] saveEventDetailsData:self withParams:paramsDict finishAction:@selector(successmethod_eventDetailsRequest:) failAction:@selector(failuremethod_eventDetailsRequest:)];
                    }
                }
                
            }else{
                
                [[GISServerManager sharedManager] saveEventDetailsData:self withParams:paramsDict finishAction:@selector(successmethod_eventDetailsRequest:) failAction:@selector(failuremethod_eventDetailsRequest:)];
            }
        }else{
            
            [self removeLoadingView];
            [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"network_connection",TABLE, nil)];
        }
    }
    @catch (NSException *exception)
    {
        [self removeLoadingView];
        [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in Event Details action %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
    }
}


-(void)successmethod_eventDetailsRequest:(GISJsonRequest *)response
{
    NSDictionary *saveUpdateDict;
    NSArray *responseArray= response.responseJson;
    saveUpdateDict = [responseArray lastObject];
    NSLog(@"successmethod_saveUpdateRequest Success---%@",saveUpdateDict);
    
    GISAttendeesViewController *attendeesViewController;
    
    if ([[saveUpdateDict objectForKey:kStatusCode] isEqualToString:@"200"]) {
        
        attendeesViewController =[[GISAttendeesViewController alloc]initWithNibName:@"GISAttendeesViewController" bundle:nil];
        
        [self removeLoadingView];
        
        NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
        [userDefaults synchronize];
        [userDefaults setValue:[saveUpdateDict valueForKey:kDropDownValue] forKey:kDropDownValue];
        [userDefaults setValue:[saveUpdateDict valueForKey:kDropDownID] forKey:kDropDownID];
        
         NSDictionary *infoDict=[NSDictionary dictionaryWithObjectsAndKeys:@"2",@"tabValue",[NSNumber numberWithBool:YES],@"isFromContacts",nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:kTabSelected object:nil userInfo:infoDict];

      
    }else{
        
        [self removeLoadingView];
        [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
    }
    
    
    
}
-(void)failuremethod_eventDetailsRequest:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"Failure");
    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
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

-(void)addLoadViewWithLoadingText:(NSString*)title
{
    [[GISLoadingView sharedDataManager] addLoadingAlertView:title];
    // _loadingView = [LoadingView loadingViewInView:self.navigationController.view andWithText:title];
    
}
-(void)removeLoadingView
{
    [[GISLoadingView sharedDataManager] removeLoadingAlertview];
}

-(void)selectedChooseRequestNumber:(NSNotification*)notification
{
    NSDictionary *dict=[notification userInfo];
    
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
    
    [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
    
    [[GISServerManager sharedManager] getEventDetailsData:self withParams:paramsDict finishAction:@selector(successmethod_getRequestDetails:) failAction:@selector(failuremethod_getRequestDetails:)];

}


-(void)successmethod_getRequestDetails:(GISJsonRequest *)response
{
    NSLog(@"successmethod_getRequestDetails Success---%@",response.responseJson);
    
    NSDictionary *saveUpdateDict;
    NSArray *responseArray= response.responseJson;
    saveUpdateDict = [responseArray lastObject];
    
    if ([[saveUpdateDict objectForKey:kStatusCode] isEqualToString:@"200"]) {
        
        [[GISStoreManager sharedManager] removeChooseRequestDetailsObjects];
        chooseRequest_Detailed_DetailsObj=[[GISChooseRequestDetailsObject alloc]initWithStoreChooseRequestDetailsDictionary:response.responseJson];
        [[GISStoreManager sharedManager]addChooseRequestDetailsObject:chooseRequest_Detailed_DetailsObj];
        
        [self removeLoadingView];
        
        NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
        [userDefaults setValue:chooseRequest_Detailed_DetailsObj.unitID_String_chooseReqParsedDetails forKey:kunitid];
        [self getEventDetailsdata];
    }else{
        [self removeLoadingView];
    }
}

-(void)failuremethod_getRequestDetails:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"Failure");
    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
}


-(void)getEventDetailsdata
{
    
    UIButton *eventTypeBtn=(UIButton *)[self.view viewWithTag:1];
    UIButton *dressCodeBtn=(UIButton *)[self.view viewWithTag:2];
    UIButton *openPublic1=(UIButton *)[self.view viewWithTag:3];
    UIButton *openPublic2=(UIButton *)[self.view viewWithTag:4];
    UIButton *recorded1=(UIButton *)[self.view viewWithTag:5];
    UIButton *recorded2=(UIButton *)[self.view viewWithTag:6];
    UIButton *onGoing1=(UIButton *)[self.view viewWithTag:7];
    UIButton *onGoing2=(UIButton *)[self.view viewWithTag:8];
    UIButton *_outsideagency1=(UIButton *)[self.view viewWithTag:57];
    UIButton *_outsideagency2=(UIButton *)[self.view viewWithTag:58];
    UIButton *fmSystembtn=(UIButton *)[self.view viewWithTag:9];
    UIButton *microphoneBtn=(UIButton *)[self.view viewWithTag:10];
    UIButton *phoneConferencingBtn=(UIButton *)[self.view viewWithTag:11];
    UIButton *webInarBtn=(UIButton *)[self.view viewWithTag:12];
    UIButton *otherServicesBtn=(UIButton *)[self.view viewWithTag:13];
    UIButton *captionBtn=(UIButton *)[self.view viewWithTag:14];
    UIButton *viewTypeBtn=(UIButton *)[self.view viewWithTag:15];
    
    UITextField *eventNameTextField=(UITextField *)[self.view viewWithTag:100];
    UITextField *courseTextField=(UITextField *)[self.view viewWithTag:101];
    UITextView *descriptionTextView=(UITextView *)[self.view viewWithTag:102];
    UITextField *ofUserstextField=(UITextField *)[self.view viewWithTag:666];
    UILabel *recordSelected=(UILabel *)[self.view viewWithTag:555];
    UILabel *documnet_selected_label=(UILabel *)[self.view viewWithTag:888];
    
    UIButton *documentBtn=(UIButton *)[self.view viewWithTag: 44];
    UIButton *blackBoardAccessBtn=(UIButton *)[self.view viewWithTag:111];
    UIButton *websiteBtn=(UIButton *)[self.view viewWithTag:22];
    UIButton *other_MaterialTypeBtn=(UIButton *)[self.view viewWithTag:33];
    
    UITextField *blackBoardTextField=(UITextField *)[self.view viewWithTag:222];
    UITextField *webSiteField=(UITextField *)[self.view viewWithTag:333];
    UITextField *otherMaterilaTypeTextField=(UITextField *)[self.view viewWithTag:444];
    
    appDelegate.createdDateString = chooseRequest_Detailed_DetailsObj.createdDate_String_chooseReqParsedDetails;
    appDelegate.createdByString = [NSString stringWithFormat:@"%@ %@", chooseRequest_Detailed_DetailsObj.reqFirstName_String_chooseReqParsedDetails,chooseRequest_Detailed_DetailsObj.reqLastName_String_chooseReqParsedDetails];
    appDelegate.statusString = chooseRequest_Detailed_DetailsObj.requestStatus_String_chooseReqParsedDetails;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:kRequestInfo object:nil];

    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSMutableArray *chooseReqDetailedArray=[[GISStoreManager sharedManager]getChooseRequestDetailsObjects];
    if (chooseReqDetailedArray.count>0) {
        chooseRequest_Detailed_DetailsObj=[chooseReqDetailedArray lastObject];
        NSLog(@"----now--%@",chooseRequest_Detailed_DetailsObj.inCompleteTab_String_chooseReqParsedDetails);
        
        [eventTypeBtn setTitle:@" " forState:UIControlStateNormal];
        [dressCodeBtn setTitle:@" " forState:UIControlStateNormal];
        
        
        for (GISDropDownsObject *dropDownObj in _eventTypeArray) {
            if ([dropDownObj.id_String isEqualToString:chooseRequest_Detailed_DetailsObj.eventTypeID_String_chooseReqParsedDetails]) {
                [eventTypeBtn setTitle:dropDownObj.value_String forState:UIControlStateNormal];
                eventTypedata = dropDownObj.value_String;
            }
        }
        
        for (GISDropDownsObject *dropDownObj in _dresscodeArray) {
            if ([dropDownObj.id_String isEqualToString:chooseRequest_Detailed_DetailsObj.dressCodeID_String_chooseReqParsedDetails]) {
                [dressCodeBtn setTitle:dropDownObj.value_String forState:UIControlStateNormal];
                dresscodeData = dropDownObj.value_String;
            }
        }
        
        [eventNameTextField setText:[self returningstring:chooseRequest_Detailed_DetailsObj.eventName_String_chooseReqParsedDetails]];
        evevntNamedata = [self returningstring:chooseRequest_Detailed_DetailsObj.eventName_String_chooseReqParsedDetails];
        _eventTypeId_string = [self returningstring:chooseRequest_Detailed_DetailsObj.eventTypeID_String_chooseReqParsedDetails];
        _open_toPublicStr = [self returningstring:chooseRequest_Detailed_DetailsObj.openToPublic_String_chooseReqParsedDetails];
        _dressCode_Id_string = [self returningstring:chooseRequest_Detailed_DetailsObj.dressCodeID_String_chooseReqParsedDetails];
        _re_broadcastStr = [self returningstring:chooseRequest_Detailed_DetailsObj.recBroadcast_String_chooseReqParsedDetails];
        _on_goingStr = [self returningstring:chooseRequest_Detailed_DetailsObj.onGoing_String_chooseReqParsedDetails];
        _outsideAgencyStr = [self returningstring:chooseRequest_Detailed_DetailsObj.outsideAgency_String_chooseReqParsedDetails];
        [_othertechvalueStr setString:[self returningstring:chooseRequest_Detailed_DetailsObj.otherTechnologies_String_chooseReqParsedDetails]];
        
        [courseTextField setText:[self returningstring:chooseRequest_Detailed_DetailsObj.courseID_String_chooseReqParsedDetails]];
        courseIdData = [self returningstring:chooseRequest_Detailed_DetailsObj.courseID_String_chooseReqParsedDetails];
        descriptionData = [self returningstring:chooseRequest_Detailed_DetailsObj.eventDescription_String_chooseReqParsedDetails];
        [descriptionTextView setText:[self returningstring:chooseRequest_Detailed_DetailsObj.eventDescription_String_chooseReqParsedDetails]];
        _otherServices_Str = [self returningstring:chooseRequest_Detailed_DetailsObj.OtherServiceID_String_chooseReqParsedDetails];
        captionData = [self returningstring:chooseRequest_Detailed_DetailsObj.CaptionTypeID_String_chooseReqParsedDetails];
        
        if([captionData length] > 0){
            [captionBtn setTitle:[self returningstring:chooseRequest_Detailed_DetailsObj.CaptionTypeID_String_chooseReqParsedDetails] forState:UIControlStateNormal];
        }else{
            [captionBtn setTitle:NSLocalizedStringFromTable(@"empty_selection", TABLE, nil) forState:UIControlStateNormal];
        }
        _broadcastType_Str = [self returningstring:chooseRequest_Detailed_DetailsObj.recBroadcastYes_String_chooseReqParsedDetails];
        noOfUsersData = [self returningstring:chooseRequest_Detailed_DetailsObj.CapNoOfUsers_String_chooseReqParsedDetails];
        [ofUserstextField setText:[self returningstring:chooseRequest_Detailed_DetailsObj.CapNoOfUsers_String_chooseReqParsedDetails]];
        _eventdetails_viewOptions = [self returningstring:chooseRequest_Detailed_DetailsObj.CapViewOptions_String_chooseReqParsedDetails];
        _eventdetails_unitIdStr = [userDefaults valueForKey:kunitid];
        _eventdetails_statusStr = [self returningstring:chooseRequest_Detailed_DetailsObj.statusID_String_chooseReqParsedDetails];
        
        if([_open_toPublicStr isEqualToString:@"true"])
        {
            [openPublic1  setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
            [openPublic2  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
        }else if([_open_toPublicStr isEqualToString:@"false"])
        {
            [openPublic1  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [openPublic2  setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }else{
            [openPublic1  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [openPublic2  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
        }
        
        if([_on_goingStr isEqualToString:@"true"])
        {
            [onGoing1  setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
            [onGoing2  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
        }else if([_on_goingStr isEqualToString:@"false"])
        {
            [onGoing1  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [onGoing2  setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }else{
            [onGoing2  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [onGoing1  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
        }
        
        
        if([_re_broadcastStr isEqualToString:@"true"])
        {
            [recorded1  setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
            recordSelected.text = _broadcastType_Str;
            
        }else if([_re_broadcastStr isEqualToString:@"false"])
        {
            [recorded2  setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
            recordSelected.text = @"";
        }else{
            [recorded1  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [recorded2  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
        }
        
        if([_outsideAgencyStr isEqualToString:@"true"])
        {
            [_outsideagency1  setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
            [_outsideagency2  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
        }else if([_outsideAgencyStr isEqualToString:@"false"])
        {
            [_outsideagency1  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [_outsideagency2  setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
        }else{
            [_outsideagency1  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [_outsideagency2  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
        }
        
        if([_otherServices_Str isEqualToString:@"1"]){
            [otherServicesBtn setTitle:@"Captioning" forState:UIControlStateNormal];
            captionBtn.enabled = TRUE;
        }else if([_otherServices_Str isEqualToString:@"2"]){
            [otherServicesBtn setTitle:@"VRI" forState:UIControlStateNormal];
            captionBtn.enabled = FALSE;
        }else{
            [otherServicesBtn setTitle:NSLocalizedStringFromTable(@"empty_selection", TABLE, nil) forState:UIControlStateNormal];
            captionBtn.enabled = TRUE;
            
        }
        
        if([_eventdetails_viewOptions length] == 0)
            [viewTypeBtn setTitle:NSLocalizedStringFromTable(@"empty_selection", TABLE, nil) forState:UIControlStateNormal];
        else
            [viewTypeBtn setTitle:_eventdetails_viewOptions forState:UIControlStateNormal];
        
        if([_othertechvalueStr length] >0){
            _otherTechArray = [[NSArray alloc] initWithArray:[_othertechvalueStr componentsSeparatedByString:@","]];
            
            if([otherTechStr count]>0)
                [otherTechStr removeAllObjects];
            
            for(int i=0 ;i<[_otherTechArray count];i++)
            {
                NSString *value = [_otherTechArray objectAtIndex:i];
                switch ([value intValue]) {
                    case 1:
                        [fmSystembtn setBackgroundImage: [UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
                        [otherTechStr addObject:value];
                        break;
                    case 2:
                        [microphoneBtn setBackgroundImage: [UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
                        [otherTechStr addObject:value];
                        break;
                    case 3:
                        [phoneConferencingBtn setBackgroundImage: [UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
                        [otherTechStr addObject:value];
                        break;
                    case 4:
                        [webInarBtn setBackgroundImage: [UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
                        [otherTechStr addObject:value];
                        break;
                    default:
                        break;
                }
            }
        }else{
            
            [fmSystembtn setBackgroundImage: [UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [microphoneBtn setBackgroundImage: [UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [phoneConferencingBtn setBackgroundImage: [UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            [webInarBtn setBackgroundImage: [UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
        }
        
        
        if([chooseRequest_Detailed_DetailsObj.website_String_chooseReqParsedDetails length]>0 && ![chooseRequest_Detailed_DetailsObj.website_String_chooseReqParsedDetails isEqualToString:@" "])
        {
            [websiteBtn  setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
            webSiteField.text = chooseRequest_Detailed_DetailsObj.website_String_chooseReqParsedDetails;
            _websiteStr = chooseRequest_Detailed_DetailsObj.website_String_chooseReqParsedDetails;
            
            [webSiteField setHidden:NO];
        }else{
            [websiteBtn  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            webSiteField.text = chooseRequest_Detailed_DetailsObj.website_String_chooseReqParsedDetails;
            _websiteStr = chooseRequest_Detailed_DetailsObj.website_String_chooseReqParsedDetails;
            
            [webSiteField setHidden:YES];
        }
        
        if([chooseRequest_Detailed_DetailsObj.balckboardAccess_String_chooseReqParsedDetails length]>0 && ![chooseRequest_Detailed_DetailsObj.balckboardAccess_String_chooseReqParsedDetails isEqualToString:@" "])
        {
            [blackBoardAccessBtn  setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
            blackBoardTextField.text = chooseRequest_Detailed_DetailsObj.balckboardAccess_String_chooseReqParsedDetails;
            _blackboard_accessStr = chooseRequest_Detailed_DetailsObj.balckboardAccess_String_chooseReqParsedDetails;
            
            [blackBoardTextField setHidden:NO];
        }else{
            [blackBoardAccessBtn  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            blackBoardTextField.text = chooseRequest_Detailed_DetailsObj.balckboardAccess_String_chooseReqParsedDetails;
            _blackboard_accessStr = chooseRequest_Detailed_DetailsObj.balckboardAccess_String_chooseReqParsedDetails;
            
            [blackBoardTextField setHidden:YES];
        }
        if([chooseRequest_Detailed_DetailsObj.other_materialType_String_chooseReqParsedDetails length]>0 && ![chooseRequest_Detailed_DetailsObj.other_materialType_String_chooseReqParsedDetails isEqualToString:@" "])
        {
            [other_MaterialTypeBtn  setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
            otherMaterilaTypeTextField.text = chooseRequest_Detailed_DetailsObj.other_materialType_String_chooseReqParsedDetails;
            _other_Str = chooseRequest_Detailed_DetailsObj.other_materialType_String_chooseReqParsedDetails;
            
            [otherMaterilaTypeTextField setHidden:NO];
        }else{
            [other_MaterialTypeBtn  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            otherMaterilaTypeTextField.text = chooseRequest_Detailed_DetailsObj.other_materialType_String_chooseReqParsedDetails;
            _other_Str = chooseRequest_Detailed_DetailsObj.other_materialType_String_chooseReqParsedDetails;
            
            [otherMaterilaTypeTextField setHidden:YES];
            
        }
        if([chooseRequest_Detailed_DetailsObj.document_String_chooseReqParsedDetails length]>0 && ![chooseRequest_Detailed_DetailsObj.document_String_chooseReqParsedDetails isEqualToString:@" "])
        {
            [documentBtn  setBackgroundImage:[UIImage imageNamed:@"radio_button_filled.png"] forState:UIControlStateNormal];
            _document_Str = chooseRequest_Detailed_DetailsObj.document_String_chooseReqParsedDetails;
            
            NSRange range = [_document_Str rangeOfString:@"~" options:NSBackwardsSearch];
            if (range.location == NSNotFound) {
                
            } else {
                NSString *filepath = [_document_Str substringFromIndex:[_document_Str rangeOfString:@"~"options:NSBackwardsSearch].location+1];
                _document_Str = filepath;
            }
            
            documnet_selected_label.text = _document_Str;
        }else{
            [documentBtn  setBackgroundImage:[UIImage imageNamed:@"radio_button_empty.png"] forState:UIControlStateNormal];
            documnet_selected_label.text = chooseRequest_Detailed_DetailsObj.document_String_chooseReqParsedDetails;
            _document_Str = chooseRequest_Detailed_DetailsObj.document_String_chooseReqParsedDetails;
        }
    }
    
    [self removeLoadingView];
}

-(void)saveMaterialRequest
{
    if([_document_Str length] == 0){
        _document_Str = @"";
    }
    if([_websiteStr length] == 0){
        _websiteStr = @"";
    }
    if([_other_Str length] == 0){
        _other_Str = @"";
    }
    if([_blackboard_accessStr length] == 0){
        _blackboard_accessStr = @"";
    }
    if([newValueString length] == 0){
        newValueString = @"";
    }
    
    NSMutableDictionary *mainDict=[[NSMutableDictionary alloc]init];
    NSMutableArray *requestor_array=[[NSMutableArray alloc]init];
    NSMutableDictionary *requestor_Dict=[[NSMutableDictionary alloc]init];
    
    NSMutableArray *materialDetails_Array=[[NSMutableArray alloc]init];
    NSMutableDictionary *materialDetails_Listdict;
    for (int i=0;i<[material_types_Array count];i++)
    {
        materialDetails_Listdict=[[NSMutableDictionary alloc]init];
        if([[material_types_Array objectAtIndex:i] isEqualToString:@"1"])
        {
            [materialDetails_Listdict  setObject:[material_types_Array objectAtIndex:i] forKey:kPrepMaterialID];
            
            [materialDetails_Listdict  setObject:_document_Str forKey:kValue];
            
        }else if([[material_types_Array objectAtIndex:i] isEqualToString:@"2"])
        {
            [materialDetails_Listdict  setObject:[material_types_Array objectAtIndex:i] forKey:kPrepMaterialID];
            
            [materialDetails_Listdict  setObject:_blackboard_accessStr forKey:kValue];
        }else if([[material_types_Array objectAtIndex:i] isEqualToString:@"3"])
        {
            [materialDetails_Listdict  setObject:[material_types_Array objectAtIndex:i] forKey:kPrepMaterialID];
            
            [materialDetails_Listdict  setObject:_websiteStr forKey:kValue];
        }else if([[material_types_Array objectAtIndex:i] isEqualToString:@"4"])
        {
            [materialDetails_Listdict  setObject:[material_types_Array objectAtIndex:i] forKey:kPrepMaterialID];
            
            [materialDetails_Listdict  setObject:_other_Str forKey:kValue];
        }
        
        [materialDetails_Array addObject:materialDetails_Listdict];
    }
    
    
    [requestor_Dict setValue:[self returningstring:login_Obj.requestorID_string] forKey:kRequestorId];
    [requestor_Dict setValue:[self returningstring:login_Obj.token_string] forKey:kToken];
    [requestor_Dict setValue:[self returningstring:appDelegate.chooseRequest_ID_String ] forKey:kRequestNo];
    [requestor_Dict setValue:newValueString forKey:kNewValue];
    
    [requestor_array addObject:requestor_Dict];
    [mainDict setObject:requestor_array forKey:kORequest];
    [mainDict setObject:materialDetails_Array forKey:kOMaterialDetails];
    
    [[GISServerManager sharedManager] saveMaterialTypeData:self withParams:mainDict finishAction:@selector(successmethod_materialTypeRequest:) failAction:@selector(failuremethod_materialTypeRequest:)];
}

-(void)successmethod_materialTypeRequest:(GISJsonRequest *)response
{
    NSDictionary *saveUpdateDict;
    NSArray *responseArray= response.responseJson;
    saveUpdateDict = [responseArray lastObject];
    NSLog(@"successmethod_saveMaterialType Success---%@",saveUpdateDict);
    
    if ([[saveUpdateDict objectForKey:kStatusCode] isEqualToString:@"200"]) {
        
        
    }else{
        
        [self removeLoadingView];
        [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
    }
    
}

-(void)failuremethod_materialTypeRequest:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"Failure");
    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UILabel *documnet_selected_label=(UILabel *)[self.view viewWithTag:888];
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
        if(!img) img = [info objectForKey:UIImagePickerControllerOriginalImage];
        imgData= UIImageJPEGRepresentation(img,0.0);
        [self uploadDataToServer:imgData];
        
        NSURL *refURL = [info valueForKey:UIImagePickerControllerReferenceURL];
        
        ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *imageAsset)
        {
            ALAssetRepresentation *imageRep = [imageAsset defaultRepresentation];
            NSLog(@"[imageRep filename] : %@", [imageRep filename]);
            
            imageName = [imageRep filename];
            _document_Str = imageName;
            [documnet_selected_label setHidden:NO];
            documnet_selected_label.text = imageName;
        };
        
        // get the asset library and fetch the asset based on the ref url (pass in block above)
        ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
        [assetslibrary assetForURL:refURL resultBlock:resultblock failureBlock:nil];
        
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
    }
    [self.popover dismissPopoverAnimated:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)uploadDataToServer:(NSData *)data{
    
    NSString *uploadUrl = [NSString stringWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_UPLOAD];
    
    NSMutableURLRequest *request= [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:uploadUrl]];
    [request setHTTPMethod:@"POST"];
    
    NSMutableData *postbody = [NSMutableData data];
    [postbody appendData:[NSData dataWithData:data]];
    
    [request setHTTPBody:postbody];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    [connection start];
}

- (void) connection: (NSURLConnection*) connection didReceiveResponse: (NSURLResponse*) response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    responseCode = httpResponse.statusCode;
    NSLog(@"Response code : %d", responseCode);
    
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [responseData appendData:data];
    NSError* error;
    NSArray* responseArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSDictionary *saveUpdateDict;
    saveUpdateDict = [responseArray lastObject];
    newValueString = [saveUpdateDict objectForKey:kNewValue];
    if (error) NSLog(@"%@",error.localizedDescription);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    [self removeLoadingView];
    NSLog(@"failed with error %@",error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSLog(@"connection loading completed ");
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
