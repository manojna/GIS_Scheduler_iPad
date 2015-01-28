//
//  EditView.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/19/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFEditEventView.h"

#import "FFButtonWithDatePopover.h"
#import "FFButtonWithHourPopover.h"
#import "FFSearchBarWithAutoComplete.h"
#import "FFGuestsTableView.h"
#import "FFImportantFilesForCalendar.h"
#import "GISEventLabel.h"
#import "GISFonts.h"
#import "GISJSONProperties.h"
#import "GISServerManager.h"
#import "GISJsonRequest.h"
#import "PCLogger.h"
#import "GISLoadingView.h"
#import "GISUtility.h"
#import "GISLoginDetailsObject.h"
#import "GISDatabaseManager.h"
#import "GISUtility.h"
#import "GISConstants.h"
#import "FFDateManager.h"
#import "GISDropDownsObject.h"
#import "GISServiceProviderObject.h"

//#import "SVProgressHUD.h"

@interface FFEditEventView () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) FFEvent *event;
@property (nonatomic, strong) UIButton *buttonCancel;
@property (nonatomic, strong) UIButton *buttonDone;
@property (nonatomic, strong) UIButton *buttonDelete;
@property (nonatomic, strong) GISEventLabel *labelEventName,*paytypeLabel,*serviceProviderTypeLabel;
@property (nonatomic, strong) FFSearchBarWithAutoComplete *searchBarCustom;
@property (nonatomic, strong) FFButtonWithDatePopover *buttonDate;
@property (nonatomic, strong) FFButtonWithHourPopover *buttonTimeBegin;
@property (nonatomic, strong) FFButtonWithHourPopover *buttonTimeEnd;
@property (nonatomic, strong) FFGuestsTableView *tableViewGuests;
@end

@implementation FFEditEventView

#pragma mark - Synthesize

@synthesize protocol;
@synthesize event;
@synthesize buttonDone;
@synthesize buttonCancel;
@synthesize buttonDelete;
@synthesize labelEventName;
@synthesize searchBarCustom;
@synthesize buttonDate;
@synthesize buttonTimeBegin;
@synthesize buttonTimeEnd;
@synthesize tableViewGuests;
@synthesize paytypeLabel;
@synthesize serviceProviderTypeLabel;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame event:(FFEvent *)_event {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        event = _event;
        
        [self setBackgroundColor:[UIColor lightGrayCustom]];
        [self.layer setBorderColor:[UIColor lightGrayCustom].CGColor];
        [self.layer setBorderWidth:2.];
        
        appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication]delegate];
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [gesture setDelegate:self];
        [self addGestureRecognizer:gesture];

        [self addButtonCancel];
        [self addButtonDone];
        [self addSearchBar];
        [self addButtonDate];
        [self addButtonTimeBegin];
        [self addButtonTimeEnd];
        //[self addButtonDelete];
        [self addEventTitle];
        [self addTypeOfService];
        [self addServiceProvider];
        [self addProviderName];
        //[self addtableViewGuests];
    }
    return self;
}

#pragma mark - Button Actions

- (IBAction)buttonCancelAction:(id)sender {
    
    if (protocol != nil && [protocol respondsToSelector:@selector(removeThisView:)]) {
        [protocol removeThisView:self];
    }
}

- (IBAction)buttonDoneAction:(id)sender {
    
    if([sender tag] == 111){
        
        NSMutableArray *typeOfService_array=[[NSMutableArray alloc]init];
        NSString *typeOfService_statement = [[NSString alloc]initWithFormat:@"select * from TBL_TYPE_OF_SERVICE  ORDER BY ID DESC;"];
        typeOfService_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:typeOfService_statement] mutableCopy];
        
        NSMutableArray *serviceProvider_Array=[[NSMutableArray alloc]init];
        NSString *spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO"];
        serviceProvider_Array = [[[GISDatabaseManager sharedDataManager] getServiceProviderArray:spCode_statement] mutableCopy];
        
        NSMutableArray *payType_array=  [[NSMutableArray alloc]init];
        NSString *payType_statement  =  [[NSString alloc]initWithFormat:@"select * from TBL_PAY_TYPE"];
        payType_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:payType_statement] mutableCopy];
        NSPredicate *filePredicate;
        NSArray *fileArray;
        filePredicate=[NSPredicate predicateWithFormat:@"value_String==%@",event.payType];
        fileArray=[payType_array filteredArrayUsingPredicate:filePredicate];
        
        if([fileArray count]>0)
        {
            GISDropDownsObject *obj=[fileArray lastObject];
            payType_string=obj.id_String;
        }
        
        
        filePredicate=[NSPredicate predicateWithFormat:@"service_Provider_String==%@",event.serviceProvider];
        fileArray=[serviceProvider_Array filteredArrayUsingPredicate:filePredicate];
        
        if([fileArray count]>0)
        {
            GISServiceProviderObject *obj=[fileArray lastObject];
            serviceType_string = obj.id_String;
        }
        
        
        filePredicate=[NSPredicate predicateWithFormat:@"value_String==%@",event.serviceProviderType];
        fileArray=[typeOfService_array filteredArrayUsingPredicate:filePredicate];
        
        if([fileArray count]>0)
        {
            GISDropDownsObject *obj=[fileArray lastObject];
            subRole_string=obj.id_String;
        }
    }

    if([payType_string length] == 0)
        payType_string = @"";
    
    if([serviceType_string length] == 0)
        serviceType_string = @"";
    
    if([subRole_string length] == 0)
        subRole_string = @"";
    
    
    NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
    NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
    GISLoginDetailsObject *login_Obj=[requetId_array lastObject];
    
    NSMutableDictionary *update_eventdict;
    update_eventdict=[[NSMutableDictionary alloc]init];
    
    [update_eventdict setObject:event.numCustomerID forKey:kJobDetais_JobID];
    [update_eventdict setObject:[GISUtility getEventTime:buttonTimeBegin.dateOfButton] forKey:kJobDetais_StartTime];
    [update_eventdict setObject:[GISUtility getEventTime:buttonTimeEnd.dateOfButton] forKey:kJobDetais_EndTime];
    [update_eventdict setObject:[GISUtility eventDisplayFormat:buttonDate.dateOfButton] forKey:kJobDetais_JobDate];
    [update_eventdict setObject:payType_string forKey:kViewSchedule_PayTypeID];
    [update_eventdict setObject:serviceType_string forKey:kViewSchedule_ServiceProviderID];
    [update_eventdict setObject:subRole_string forKey:kViewSchedule_SubroleID];
    [update_eventdict setObject:login_Obj.requestorID_string forKey:kLoginRequestorID];
    [update_eventdict setObject:@"" forKey:kViewSchedule_JobNotes];
    if([sender tag] == 111){
        [update_eventdict setObject:@"" forKey:kSPRequestJobs_GisResponse];
    }
    
    [[GISServerManager sharedManager] updateJobDetails:self withParams:update_eventdict finishAction:@selector(successmethod_updateScheduledata:) failAction:@selector(failuremethod_updateScheduledata:)];
    
    
    
//    NSString *stringError;
//    
//    if (!eventNew.numCustomerID) {
//        stringError = @"Please select a customer.";
//    } else if (![self isTimeBeginEarlier:eventNew.dateTimeBegin timeEnd:eventNew.dateTimeEnd]) {
//        stringError = @"Start time must occur earlier than end time.";
//    } else if (eventNew.arrayWithGuests.count == 0) {
//        stringError = @"Please select a guest.";
//    }
    
//    if (stringError) {
//        [[[UIAlertView alloc] initWithTitle:nil message:stringError delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
//        //        [SVProgressHUD showErrorWithStatus:stringError];
//    } else
//    if (protocol != nil && [protocol respondsToSelector:@selector(saveEvent:)]) {
//        [protocol saveEvent:eventNew];
//        [self buttonDeleteAction:nil];
//    }
}

- (BOOL)isTimeBeginEarlier:(NSDate *)dateBegin timeEnd:(NSDate *)dateEnd {
    
    BOOL boolIsRight = YES;
    
    NSDateComponents *compDateBegin = [NSDate componentsOfDate:dateBegin];
    NSDateComponents *compDateEnd = [NSDate componentsOfDate:dateEnd];
    
    if ((compDateBegin.hour > compDateEnd.hour) || (compDateBegin.hour == compDateEnd.hour && compDateBegin.minute >= compDateEnd.minute)) {
        boolIsRight = NO;
    }
    
    return boolIsRight;
}

- (IBAction)buttonDeleteAction:(id)sender {
    
    if (protocol != nil && [protocol respondsToSelector:@selector(deleteEvent:)]) {
        [protocol deleteEvent:event];
    }
    
   [self buttonCancelAction:nil];
}

#pragma mark - Tap Gesture

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    
    [searchBarCustom closeKeyboardAndTableView];
}

#pragma mark - Add Subviews

- (void)addButtonCancel {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, BUTTON_HEIGHT+30)];
    [view setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [view setBackgroundColor:[UIColor lighterGrayCustom]];
    [self addSubview:view];
    
    buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonCancel setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin];
    [buttonCancel.titleLabel setFont:[GISFonts large]];
    [self customLayoutOfButton:buttonCancel withTitle:@"Cancel" action:@selector(buttonCancelAction:) frame:CGRectMake(20, 0, 80, BUTTON_HEIGHT+30)];
    [view addSubview:buttonCancel];
}

- (void)addButtonDone {
    NSString *btnString;
    
    buttonDone = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonDone setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
    [buttonDone.titleLabel setFont:[GISFonts large]];
    
    if(appDelegate.isfilled){
        btnString = @"UnAssign";
        [buttonDone setTag:111];
    }
    else{
        btnString = @"Done";
        [buttonDone setTag:222];
    }
    
        
    [self customLayoutOfButton:buttonDone withTitle:btnString action:@selector(buttonDoneAction:) frame:CGRectMake(buttonCancel.superview.frame.size.width-80-10, buttonCancel.frame.origin.y, 80, buttonCancel.frame.size.height)];
    [buttonCancel.superview addSubview:buttonDone];
}

- (void)addSearchBar {
    
    searchBarCustom = [[FFSearchBarWithAutoComplete alloc] initWithFrame:CGRectMake(0,buttonCancel.superview.frame.origin.y+buttonCancel.superview.frame.size.height+ BUTTON_HEIGHT, self.frame.size.width, BUTTON_HEIGHT)];
    [searchBarCustom setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [searchBarCustom setStringClientName:event.stringCustomerName];
    [searchBarCustom setNumCustomerID:event.numCustomerID];
    [searchBarCustom setHidden:TRUE];
    [self addSubview:searchBarCustom];
    
    labelEventName = [[GISEventLabel alloc] initWithFrame:CGRectMake(0,buttonCancel.superview.frame.origin.y+buttonCancel.superview.frame.size.height-20+ BUTTON_HEIGHT, self.frame.size.width, BUTTON_HEIGHT)];
    [labelEventName setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [labelEventName setTextAlignment:NSTextAlignmentCenter];
    [labelEventName setFont:[GISFonts large]];
    labelEventName.text = [NSString stringWithFormat:@"Job ID %@", event.stringCustomerName];
    [self addSubview:labelEventName];
}

- (void)addButtonDate {
    
    buttonDate = [[FFButtonWithDatePopover alloc] initWithFrame:CGRectMake(0, searchBarCustom.frame.origin.y+searchBarCustom.frame.size.height-20, self.frame.size.width, BUTTON_HEIGHT) date:event.dateDay];
    [buttonDate setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [buttonDate.titleLabel setFont:[GISFonts large]];
    [self addSubview:buttonDate];
}

- (void)addEventTitle{
    
    labelEventName = [[GISEventLabel alloc] initWithFrame:CGRectMake(0, buttonDate.frame.origin.y+buttonDate.frame.size.height, self.frame.size.width, BUTTON_HEIGHT)];
    [labelEventName setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [labelEventName setTextAlignment:NSTextAlignmentCenter];
    labelEventName.text = [NSString stringWithFormat:@"%@", event.eventName];
    [self addSubview:labelEventName];
}

- (void)addButtonTimeBegin {
    
    buttonTimeBegin = [[FFButtonWithHourPopover alloc] initWithFrame:CGRectMake(0, buttonDate.frame.origin.y+buttonDate.frame.size.height+BUTTON_HEIGHT, self.frame.size.width, BUTTON_HEIGHT) date:event.dateTimeBegin];
    [buttonTimeBegin setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [buttonTimeBegin.titleLabel setFont:[GISFonts large]];
    [self addSubview:buttonTimeBegin];
}

- (void)addButtonTimeEnd {
    
    buttonTimeEnd = [[FFButtonWithHourPopover alloc] initWithFrame:CGRectMake(0, buttonTimeBegin.frame.origin.y+buttonTimeBegin.frame.size.height+2, self.frame.size.width, BUTTON_HEIGHT) date:event.dateTimeEnd];
    [buttonTimeEnd setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [buttonTimeEnd.titleLabel setFont:[GISFonts large]];
    [self addSubview:buttonTimeEnd];
}

- (void)addTypeOfService{
    
    _payTypeBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0,  buttonTimeEnd.frame.origin.y+buttonTimeEnd.frame.size.height+45, self.frame.size.width, BUTTON_HEIGHT)];
    [_payTypeBackgroundView setBackgroundColor:[UIColor whiteColor]];
    [_payTypeBackgroundView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self addSubview:_payTypeBackgroundView];
    
    UIButton *addButton1 = [[UIButton alloc] init];
    addButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if(!appDelegate.isfilled){
        [addButton1 setBackgroundImage:[UIImage imageNamed:@"choose_request_bg.png"] forState:UIControlStateNormal];
        [addButton1 setTitle:NSLocalizedStringFromTable(@"empty_selection", TABLE, nil) forState:UIControlStateNormal];
        [addButton1 addTarget:self
                       action:@selector(showPopoverDetails:)
             forControlEvents:UIControlEventTouchUpInside];

    }
    else{
        [addButton1 setBackgroundImage:nil forState:UIControlStateNormal];
        [addButton1 setTitle:event.payType forState:UIControlStateNormal];
        [addButton1 addTarget:self
                       action:nil
             forControlEvents:UIControlEventTouchUpInside];

    }
    
    addButton1.frame = CGRectMake(_payTypeBackgroundView.frame.size.width/2-addButton1.frame.size.width+20, 10.0, 130.0, 27.0);
    addButton1 .contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    [addButton1.titleLabel setFont:[GISFonts small]];
    [addButton1 setTitleColor:UIColorFromRGB(0x616161) forState:UIControlStateNormal];
    [addButton1 setTag:1235];
    if ([event.requestApproved isEqualToString:@"0"]) {
        
        addButton1.userInteractionEnabled = NO;
        [addButton1 setBackgroundColor:[UIColor lightGrayColor]];
    }else{
        addButton1.userInteractionEnabled = YES;
        [addButton1 setBackgroundColor:[UIColor clearColor]];
    }
    [_payTypeBackgroundView addSubview:addButton1];
    
    labelEventName = [[GISEventLabel alloc] initWithFrame:CGRectMake(_payTypeBackgroundView.frame.size.width/2-addButton1.frame.size.width, 10.0, 160.0, 27.0)];
    [labelEventName setTextAlignment:NSTextAlignmentLeft];
    [labelEventName setFont:[GISFonts normal]];
    labelEventName.text = [NSString stringWithFormat:@"Paytype  "];

    [_payTypeBackgroundView addSubview:labelEventName];
//    paytypeLabel = [[GISEventLabel alloc] initWithFrame:CGRectMake(0, buttonTimeEnd.frame.origin.y+buttonTimeEnd.frame.size.height+2, self.frame.size.width, BUTTON_HEIGHT)];
//    [paytypeLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
//    [paytypeLabel setTextAlignment:NSTextAlignmentCenter];
//    paytypeLabel.text = [NSString stringWithFormat:@" %@", event.payType];
//    [self addSubview:paytypeLabel];
}

- (void)addServiceProvider{
    
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0,  buttonTimeEnd.frame.origin.y+buttonTimeEnd.frame.size.height+85, self.frame.size.width, BUTTON_HEIGHT)];
    [_backgroundView setBackgroundColor:[UIColor whiteColor]];
    [_backgroundView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self addSubview:_backgroundView];
    
    UIButton *addButton1 = [[UIButton alloc] init];
    addButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if(!appDelegate.isfilled){
        [addButton1 setBackgroundImage:[UIImage imageNamed:@"choose_request_bg.png"] forState:UIControlStateNormal];
        [addButton1 setTitle:NSLocalizedStringFromTable(@"empty_selection", TABLE, nil) forState:UIControlStateNormal];
        [addButton1 addTarget:self
                       action:@selector(showPopoverDetails:)
             forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        [addButton1 setBackgroundImage:nil forState:UIControlStateNormal];
        [addButton1 setTitle:event.serviceProviderType forState:UIControlStateNormal];
        [addButton1 addTarget:self
                       action:nil
             forControlEvents:UIControlEventTouchUpInside];
    }
    
    addButton1.frame = CGRectMake(_backgroundView.frame.size.width/2-addButton1.frame.size.width+20, 10.0, 130.0, 27.0);
    addButton1 .contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    [addButton1.titleLabel setFont:[GISFonts small]];
    [addButton1 setTitleColor:UIColorFromRGB(0x616161) forState:UIControlStateNormal];
    
    [addButton1 setTag:1234];
    [_backgroundView addSubview:addButton1];
    
    labelEventName = [[GISEventLabel alloc] initWithFrame:CGRectMake(_backgroundView.frame.size.width/2-addButton1.frame.size.width, 10.0, 160.0, 27.0)];
    [labelEventName setTextAlignment:NSTextAlignmentLeft];
    [labelEventName setFont:[GISFonts normal]];
    labelEventName.text = [NSString stringWithFormat:@"ServiceProvider Type  "];
    
    [_backgroundView addSubview:labelEventName];
    
//    serviceProviderTypeLabel = [[GISEventLabel alloc] initWithFrame:CGRectMake(0, labelEventName.frame.origin.y+labelEventName.frame.size.height+2, self.frame.size.width, BUTTON_HEIGHT)];
//    [serviceProviderTypeLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
//    [serviceProviderTypeLabel setTextAlignment:NSTextAlignmentCenter];
//    serviceProviderTypeLabel.text = [NSString stringWithFormat:@"%@", event.serviceProvider];
//    [self addSubview:serviceProviderTypeLabel];
}

- (void)addProviderName{
    
    _ServicebackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, buttonTimeEnd.frame.origin.y+buttonTimeEnd.frame.size.height+2, self.frame.size.width, BUTTON_HEIGHT)];
    [_ServicebackgroundView setBackgroundColor:[UIColor whiteColor]];
    [_ServicebackgroundView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self addSubview:_ServicebackgroundView];
    
    UIButton *addButton1 = [[UIButton alloc] init];
    addButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if(!appDelegate.isfilled){
        [addButton1 setBackgroundImage:[UIImage imageNamed:@"choose_request_bg.png"] forState:UIControlStateNormal];
        [addButton1 setTitle:NSLocalizedStringFromTable(@"empty_selection", TABLE, nil) forState:UIControlStateNormal];
        [addButton1 addTarget:self
                       action:@selector(showPopoverDetails:)
             forControlEvents:UIControlEventTouchUpInside];

    }
    else{
        [addButton1 setBackgroundImage:nil forState:UIControlStateNormal];
        [addButton1 setTitle:event.serviceProvider forState:UIControlStateNormal];
        [addButton1 addTarget:self
                       action:nil
             forControlEvents:UIControlEventTouchUpInside];

    }
    
    if ([event.requestApproved isEqualToString:@"0"]) {
        
        addButton1.userInteractionEnabled = NO;
        [addButton1 setBackgroundColor:[UIColor lightGrayColor]];
    }else{
        addButton1.userInteractionEnabled = YES;
        [addButton1 setBackgroundColor:[UIColor clearColor]];
    }
    
    addButton1.frame = CGRectMake(_ServicebackgroundView.frame.size.width/2-addButton1.frame.size.width+20, 10.0, 130.0, 27.0);
    addButton1 .contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    [addButton1.titleLabel setFont:[GISFonts small]];
    [addButton1 setTitleColor:UIColorFromRGB(0x616161) forState:UIControlStateNormal];
    [addButton1 setTag:1236];
    [_ServicebackgroundView addSubview:addButton1];
    
    labelEventName = [[GISEventLabel alloc] initWithFrame:CGRectMake(_ServicebackgroundView.frame.size.width/2-addButton1.frame.size.width, 10.0, 160.0, 27.0)];
    [labelEventName setTextAlignment:NSTextAlignmentLeft];
    [labelEventName setFont:[GISFonts normal]];
    labelEventName.text = [NSString stringWithFormat:@"ServiceProvider Name  "];
    
    [_ServicebackgroundView addSubview:labelEventName];
    
}

- (void)addButtonDelete {
    
    buttonDelete = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonDelete setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    [self customLayoutOfButton:buttonDelete withTitle:@"Assign" action:@selector(buttonDeleteAction:) frame:CGRectMake(0, self.frame.size.height-2*BUTTON_HEIGHT, self.frame.size.width, 2*BUTTON_HEIGHT)];
    [buttonDelete setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:buttonDelete];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, buttonDelete.frame.origin.y-BUTTON_HEIGHT, self.frame.size.width, BUTTON_HEIGHT)];
    [view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    [self addSubview:view];
}

- (void)addtableViewGuests {
    
    CGFloat y = buttonTimeEnd.frame.origin.y+buttonTimeEnd.frame.size.height+BUTTON_HEIGHT;
    
    tableViewGuests = [[FFGuestsTableView alloc] initWithFrame:CGRectMake(0, y, self.frame.size.width,buttonDelete.frame.origin.y-y-BUTTON_HEIGHT)];
    [tableViewGuests setAutoresizingMask:AR_WIDTH_HEIGHT];
    [self addSubview:tableViewGuests];
}

#pragma mark - Button Layout

- (void)customLayoutOfButton:(UIButton *)button withTitle:(NSString *)title action:(SEL)action frame:(CGRect)frame {
    
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:button.titleLabel.font.pointSize]];
    [button setFrame:frame];
    [button setContentMode:UIViewContentModeScaleAspectFit];
}

#pragma mark - UIGestureRecognizer Delegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    CGPoint point = [gestureRecognizer locationInView:self];
    
    return !(searchBarCustom.arrayOfTableView.count != 0 && CGRectContainsPoint(searchBarCustom.tableViewCustom.frame, point)) &&
    CGRectContainsPoint(tableViewGuests.frame, point) && searchBarCustom.tableViewCustom.superview;
}

-(void)successmethod_updateScheduledata:(GISJsonRequest *)response
{
    
    NSLog(@"successmethod_updateScheduledata Success---%@",response.responseJson);
    @try {
        if ([response.responseJson isKindOfClass:[NSArray class]])
        {
            
            id array=response.responseJson;
            NSDictionary *dictHere=[array lastObject];
            
            if ([[dictHere objectForKey:kStatus] isEqualToString:@"Success"]) {
                
                [self removeLoadingView];
                [[NSNotificationCenter defaultCenter] postNotificationName:DATE_CHANGED_UPDATE_EVENT object:nil];
            }
            else
            {
                [self removeLoadingView];
            }
        }
        else
        {
            [self removeLoadingView];
        }
        
        if (protocol != nil && [protocol respondsToSelector:@selector(removeThisView:)]) {
            [protocol removeThisView:self];
        }
        
    }
    @catch (NSException *exception)
    {
        [self removeLoadingView];
        [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in get PatTypedata action %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
    }
}
-(void)failuremethod_updateScheduledata:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"Failure");
    [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
}

-(void)addLoadViewWithLoadingText:(NSString*)title
{
    [[GISLoadingView sharedDataManager] addLoadingAlertView:title];
    // _loadingView = [LoadingView loadingViewInView:self.navigationController.view andWithText:title];
}

- (IBAction)showPopoverDetails:(id)sender {
    
    UIButton *btn=(UIButton*)sender;
    NSString *typeString = @"SchedulerServiceProvider";
    
    NSString *typeOfService_statement = [[NSString alloc]initWithFormat:@"select * from TBL_TYPE_OF_SERVICE  ORDER BY ID DESC;"];
    _serviceTypeArray = [[[GISDatabaseManager sharedDataManager] getDropDownArray:typeOfService_statement] mutableCopy];
    
    NSString *spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO WHERE TYPE != '%@'",typeString];
    NSArray *serviceProviderName_Array = [[GISDatabaseManager sharedDataManager] getServiceProviderArray:spCode_statement];
    
    GISPopOverTableViewController *tableViewController = [[GISPopOverTableViewController alloc] initWithNibName:@"GISPopOverTableViewController" bundle:nil];
    
    _popover.delegate = self;
    
    _popover.popoverContentSize = CGSizeMake(180, 210);
    
    
    if (_popover) {
        [_popover dismissPopoverAnimated:YES];
    }

    
    tableViewController.popOverDelegate = self;
    if([sender tag] == 1235){
        _popover =   [GISUtility showPopOver:appDelegate.payTypeArray viewController:tableViewController];
        isPaytype = YES;
        isServiceprovider = NO;
        [_popover presentPopoverFromRect:CGRectMake(btn.frame.origin.x+66, btn.frame.origin.y+360, 1, 1) inView:self permittedArrowDirections:UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown  animated:YES];
    }else if([sender tag] == 1236){
        _popover =   [GISUtility showPopOver:(NSMutableArray *)serviceProviderName_Array viewController:tableViewController];
        isPaytype = NO;
        isServiceprovider = YES;
        [_popover presentPopoverFromRect:CGRectMake(btn.frame.origin.x+66, btn.frame.origin.y+330, 1, 1) inView:self permittedArrowDirections:UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown  animated:YES];
    }
    else{
        _popover =   [GISUtility showPopOver:(NSMutableArray*) _serviceTypeArray viewController:tableViewController];
        isPaytype = NO;
        isServiceprovider = NO;
        [_popover presentPopoverFromRect:CGRectMake(btn.frame.origin.x+66, btn.frame.origin.y+400, 1, 1) inView:self permittedArrowDirections:UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown  animated:YES];
    }

}

-(void)sendTheSelectedPopOverData:(NSString *)id_str value:(NSString *)value_str
{
    UIButton *btn;
    if(isPaytype){
       btn=(UIButton *)[_payTypeBackgroundView viewWithTag:1235];
        payType_string = id_str;
    }else if(isServiceprovider){
        btn=(UIButton *)[_ServicebackgroundView viewWithTag:1236];
        serviceType_string = id_str;
    }else{
       btn=(UIButton *)[_backgroundView viewWithTag:1234];
        subRole_string = id_str;
    }
    [btn setTitle:value_str forState:UIControlStateNormal];
    
    if (_popover) {
        [_popover dismissPopoverAnimated:YES];
    }
}


-(void)removeLoadingView
{
    [[GISLoadingView sharedDataManager] removeLoadingAlertview];
}


@end
