//
//  GISViewEditServiceViewController.m
//  GIS_Scheduler
//
//  Created by Anand on 27/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISViewEditServiceViewController.h"
#import "FFCalendar.h"
#import "GISConstants.h"
#import "GISLoginDetailsObject.h"
#import "GISDatabaseManager.h"
#import "GISServerManager.h"
#import "GISJsonRequest.h"
#import "GISDropDownStore.h"
#import "GISStoreManager.h"
#import "GISLoadingView.h"
#import "PCLogger.h"
#import "GISConstants.h"
#import "GISJSONProperties.h"
#import "GISUtility.h"
#import "GISViewEditStore.h"
#import "NSDate+FFDaysCount.h"
#import "FFDateManager.h"
#import "GISFonts.h"
#import "GISUtility.h"

@interface GISViewEditServiceViewController ()<FFMonthCalendarViewProtocol, FFWeekCalendarViewProtocol, FFDayCalendarViewProtocol,FFDatePopoverControllerProtocol>
@property (nonatomic) BOOL boolDidLoad;
@property (nonatomic) BOOL boolYearViewIsShowing;
@property (nonatomic, strong) NSMutableDictionary *dictEvents;
@property (nonatomic, strong) UILabel *labelWithMonthAndYear;
@property (nonatomic, strong) NSArray *arrayButtons;
@property (nonatomic, strong) NSArray *arrayCalendars;
@property (nonatomic, strong) FFEditEventPopoverController *popoverControllerEditar;
@property (nonatomic, strong) FFDatePopoverController *popoverControllerDate;

@property (nonatomic, strong) FFMonthCalendarView *viewCalendarMonth;
@property (nonatomic, strong) FFWeekCalendarView *viewCalendarWeek;
@property (nonatomic, strong) FFDayCalendarView *viewCalendarDay;
@property (nonatomic, strong) IBOutlet UIView *mainView;
@property (nonatomic, strong) IBOutlet UILabel *labelMonthAndYear;
@property (nonatomic, retain) IBOutlet UITabBar *mainTabbar;
@property (nonatomic, retain) IBOutlet UITabBarItem *dayItem;
@property (nonatomic, retain) IBOutlet UITabBarItem *weekItem;
@property (nonatomic, retain) IBOutlet UITabBarItem *monthItem;

@end

@implementation GISViewEditServiceViewController

@synthesize boolDidLoad;
@synthesize boolYearViewIsShowing;
@synthesize protocol;
@synthesize arrayWithEvents;
@synthesize dictEvents;
@synthesize labelWithMonthAndYear;
@synthesize arrayButtons;
@synthesize arrayCalendars;
@synthesize popoverControllerEditar;
@synthesize viewCalendarMonth;
@synthesize viewCalendarWeek;
@synthesize viewCalendarDay;
@synthesize labelMonthAndYear;
@synthesize dayItem;
@synthesize weekItem;
@synthesize monthItem;
@synthesize mainTabbar;
@synthesize popoverControllerDate;

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
    
    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys: UIColorFromRGB(0x666666), NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    
    self.navigationController.navigationBarHidden = YES;
    
    appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    [self customNavigationBarLayout];
    
    [self addCalendars];
    
    [self buttonYearMonthWeekDayAction:[arrayButtons objectAtIndex:0]];
    
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"selected.png"]];
    
    self.dayItem.selectedImage = [[UIImage imageNamed:@"day_clicked.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.weekItem.selectedImage = [[UIImage imageNamed:@"week_clicked.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.monthItem.selectedImage = [[UIImage imageNamed:@"month_clicked.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIColor *titleHighlightedColor = UIColorFromRGB(0xffffff);
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    
    [[UITabBar appearance] setSelectedItem:self.dayItem];
    
    viewEdit_Array = [[NSMutableArray alloc] init];
    
    
    [_staff_freeLancerSegmentControl setHidden:YES];
    [_staff_freeLancerButton setHidden:YES];
        
    CGRect frame = _mainView.frame;
    frame.origin.y= 121.0f;
    _mainView.frame = frame;
    
    [_staff_freeLancerButton setTitle:NSLocalizedStringFromTable(@"empty_selection", TABLE, nil) forState:UIControlStateNormal];
    [_staff_freeLancerButton.titleLabel setFont:[GISFonts normal]];
    
    tabNameString = @"Staff";
    typeString = @"SchedulerServiceProvider";
    
    NSString *spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SCHEDULE_SERVICE_PROVIDER_INFO WHERE SPTYPE = '%@' AND TYPE = '%@'",tabNameString,typeString];
    _ServiceProvider_TypeArray = [[GISDatabaseManager sharedDataManager] getServiceProviderArray:spCode_statement];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateEvent:) name:DATE_CHANGED_UPDATE_EVENT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dateChanged:) name:DATE_MANAGER_DATE_CHANGED object:nil];
    
    viewEdit_ServiceProvider_Array = [[NSMutableArray alloc] init];
    viewEdit_ServiceProvider_unfilledArray = [[NSMutableArray alloc] init];
    
    staff_Array = [[NSMutableArray alloc] init];
    freeLancer_Array = [[NSMutableArray alloc] init];
    serviceAgency_Array = [[NSMutableArray alloc] init];
    students_Array = [[NSMutableArray alloc] init];

    [_fill_UnfillSegmentControl setSelectedSegmentIndex:1];
    
    NSDate *currentDate = [NSDate dateWithYear:[NSDate componentsOfCurrentDate].year
                                         month:[NSDate componentsOfCurrentDate].month
                                           day:[NSDate componentsOfCurrentDate].day];
    
    _dateTextField.text = [GISUtility eventDisplayFormat:currentDate];

}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if (!boolDidLoad) {
        boolDidLoad = YES;
        [self buttonTodayAction:nil];
    }
    
    isDateSelected = YES;
    isServiceSelected = NO;
}


#pragma mark - FFDateManager Notification

- (void)dateChanged:(NSNotification *)notification {
    
    
    [self updateLabelWithMonthAndYear];
}

- (void)updateLabelWithMonthAndYear {
    
    NSDateComponents *comp = [NSDate componentsOfDate:[[FFDateManager sharedManager] currentDate]];
    NSString *string = [NSString stringWithFormat:@"%@ %i", [arrayMonthName objectAtIndex:comp.month-1], comp.year];
    [labelWithMonthAndYear setText:string];
    [labelMonthAndYear setText:string];
}

- (void)updateEvent:(NSNotification *)notification {

    [self updateNewEvents];
}

- (void) updateNewEvents {
    
    [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
    
    NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
    NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
    GISLoginDetailsObject *login_Obj=[requetId_array lastObject];
    
    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
    if(appDelegate.isDateView){
        [paramsDict setObject:[GISUtility eventDisplayFormat:[[FFDateManager sharedManager] currentDate]] forKey:@"StartDate"];
        [paramsDict setObject:[GISUtility eventDisplayFormat:[[FFDateManager sharedManager] currentDate]] forKey:@"EndDate"];
    }else if(appDelegate.isWeekView){
        [paramsDict setObject:[GISUtility eventDisplayFormat:[NSDate getWeekFirstDate:[[FFDateManager sharedManager] currentDate]]] forKey:@"StartDate"];
        [paramsDict setObject:[GISUtility eventDisplayFormat:[NSDate getWeeklastDate:[[FFDateManager sharedManager] currentDate]]] forKey:@"EndDate"];
    }else if(appDelegate.isMonthView){
        
        [paramsDict setObject:[GISUtility eventDisplayFormat:[NSDate getMonthFirstDate:[[FFDateManager sharedManager] currentDate]]] forKey:@"StartDate"];
        [paramsDict setObject:[GISUtility eventDisplayFormat:[NSDate getMonthlastDate:[[FFDateManager sharedManager] currentDate]]] forKey:@"EndDate"];
    }
    if(isServiceSelected && _fill_UnfillSegmentControl.selectedSegmentIndex == 0){
        
        if([serviceProvider_IDString length] == 0){
            serviceProvider_IDString = @"";
            [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"select_service_provider",TABLE, nil)];
            [self removeLoadingView];
            return;
        }
        [paramsDict setObject:serviceProvider_IDString forKey:@"ServiceProvider"];
    }else{
        [paramsDict setObject:@"" forKey:@"ServiceProvider"];
    }
    
    [paramsDict setObject:login_Obj.token_string forKey:@"token"];
    [[GISServerManager sharedManager] getViewEditScheduledata:self withParams:paramsDict finishAction:@selector(successmethod_viewEditScheduledata:) failAction:@selector(failuremethod_viewEditScheduledata:)];
}

#pragma mark - Init dictEvents

- (void)setArrayWithEvents:(NSMutableArray *)_arrayWithEvents {
    
    arrayWithEvents = _arrayWithEvents;
    
    dictEvents = [NSMutableDictionary new];
    
    for (FFEvent *event in _arrayWithEvents) {
        NSDateComponents *comp = [NSDate componentsOfDate:event.dateDay];
        NSDate *newDate = [NSDate dateWithYear:comp.year month:comp.month day:comp.day];
        NSMutableArray *array = [dictEvents objectForKey:newDate];
        if (!array) {
            array = [NSMutableArray new];
            [dictEvents setObject:array forKey:newDate];
        }
        [array addObject:event];
    }
}

#pragma mark - Custom NavigationBar

- (void)customNavigationBarLayout {
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor lighterGrayCustom]];
    
    [self addRightBarButtonItems];
    [self addLeftBarButtonItems];
}

- (void)addRightBarButtonItems {
    
    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedItem.width = 30.;
    
    FFRedAndWhiteButton *buttonYear = [self calendarButtonWithTitle:@"year"];
    FFRedAndWhiteButton *buttonMonth = [self calendarButtonWithTitle:@"month"];
    FFRedAndWhiteButton *buttonWeek = [self calendarButtonWithTitle:@"week"];
    FFRedAndWhiteButton *buttonDay = [self calendarButtonWithTitle:@"day"];
    
    UIBarButtonItem *barButtonMonth = [[UIBarButtonItem alloc] initWithCustomView:buttonMonth];
    UIBarButtonItem *barButtonWeek = [[UIBarButtonItem alloc] initWithCustomView:buttonWeek];
    UIBarButtonItem *barButtonDay = [[UIBarButtonItem alloc] initWithCustomView:buttonDay];
    
    arrayButtons = @[buttonYear, buttonMonth, buttonWeek, buttonDay];
    [self.navigationItem setRightBarButtonItems:@[barButtonMonth, barButtonWeek, barButtonDay]];
}

- (void)addLeftBarButtonItems {
    
    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedItem.width = 30.;
    
    FFRedAndWhiteButton *buttonToday = [[FFRedAndWhiteButton alloc] initWithFrame:CGRectMake(0., 0., 80., 30)];
    [buttonToday addTarget:self action:@selector(buttonTodayAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonToday setTitle:@"today" forState:UIControlStateNormal];
    UIBarButtonItem *barButtonToday = [[UIBarButtonItem alloc] initWithCustomView:buttonToday];
    
    labelWithMonthAndYear = [[UILabel alloc] initWithFrame:CGRectMake(0., 0., 170., 30)];
    [labelWithMonthAndYear setTextColor:[UIColor redColor]];
    [labelWithMonthAndYear setFont:buttonToday.titleLabel.font];
    UIBarButtonItem *barButtonLabel = [[UIBarButtonItem alloc] initWithCustomView:labelWithMonthAndYear];
    
    [self.navigationItem setLeftBarButtonItems:@[barButtonLabel, fixedItem, barButtonToday]];
}

- (FFRedAndWhiteButton *)calendarButtonWithTitle:(NSString *)title {
    
    FFRedAndWhiteButton *button = [[FFRedAndWhiteButton alloc] initWithFrame:CGRectMake(0., 0., 80., 30.)];
    [button addTarget:self action:@selector(buttonYearMonthWeekDayAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

#pragma mark - Add Calendars

- (void)addCalendars {
    
    CGRect frame = CGRectMake(0., 0., self.mainView.frame.size.width, self.mainView.frame.size.height);

    viewCalendarMonth = [[FFMonthCalendarView alloc] initWithFrame:frame];
    [viewCalendarMonth setProtocol:self];
    [viewCalendarMonth setDictEvents:dictEvents];
    [self.mainView addSubview:viewCalendarMonth];
    
    viewCalendarWeek = [[FFWeekCalendarView alloc] initWithFrame:frame];
    [viewCalendarWeek setProtocol:self];
    [viewCalendarWeek setDictEvents:dictEvents];
    [self.mainView addSubview:viewCalendarWeek];
    
    viewCalendarDay = [[FFDayCalendarView alloc] initWithFrame:frame];
    [viewCalendarDay setProtocol:self];
    [viewCalendarDay setDictEvents:dictEvents];
    [self.mainView addSubview:viewCalendarDay];
    
    arrayCalendars = @[viewCalendarDay,  viewCalendarWeek, viewCalendarMonth];
}

#pragma mark - Button Action

- (IBAction)buttonYearMonthWeekDayAction:(id)sender {
    
    int index = [sender tag];//[arrayButtons indexOfObject:sender];
    
    [self.mainView bringSubviewToFront:[arrayCalendars objectAtIndex:index]];
    
    for (UIButton *button in arrayButtons) {
        button.selected = (button == sender);
    }
    
    boolYearViewIsShowing = (index == 0);
    [self updateLabelWithMonthAndYear];
}

- (IBAction)buttonTodayAction:(id)sender {
    
    [[FFDateManager sharedManager] setCurrentDate:[NSDate dateWithYear:[NSDate componentsOfCurrentDate].year
                                                                 month:[NSDate componentsOfCurrentDate].month
                                                                   day:[NSDate componentsOfCurrentDate].day]];
}

#pragma mark - Interface Rotation

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    //[viewCalendarYear invalidateLayout];
    [viewCalendarMonth invalidateLayout];
    [viewCalendarWeek invalidateLayout];
    [viewCalendarDay invalidateLayout];
}

#pragma mark - FFButtonAddEventWithPopover Protocol

- (void)addNewEvent:(FFEvent *)eventNew {
    
    NSMutableArray *arrayNew = [dictEvents objectForKey:eventNew.dateDay];
    if (!arrayNew) {
        arrayNew = [NSMutableArray new];
        [dictEvents setObject:arrayNew forKey:eventNew.dateDay];
    }
    [arrayNew addObject:eventNew];
    
    [self setNewDictionary:dictEvents];
}

#pragma mark - FFMonthCalendarView, FFWeekCalendarView and FFDayCalendarView Protocols

- (void)setNewDictionary:(NSDictionary *)dict {
    
    dictEvents = (NSMutableDictionary *)dict;
    
    [viewCalendarMonth setDictEvents:dictEvents];
    [viewCalendarWeek setDictEvents:dictEvents];
    [viewCalendarDay setDictEvents:dictEvents];
    
    [self arrayUpdatedWithAllEvents];
}

#pragma mark - FFYearCalendarView Protocol

- (void)showMonthCalendar {
    
    [self buttonYearMonthWeekDayAction:[arrayButtons objectAtIndex:1]];
}

#pragma mark - Sending Updated Array to FFCalendarViewController Protocol

- (void)arrayUpdatedWithAllEvents {
    
    NSMutableArray *arrayNew = [NSMutableArray new];
    
    NSArray *arrayKeys = dictEvents.allKeys;
    for (NSDate *date in arrayKeys) {
        NSArray *arrayOfDate = [dictEvents objectForKey:date];
        for (FFEvent *event in arrayOfDate) {
            [arrayNew addObject:event];
        }
    }
    
    if (protocol != nil && [protocol respondsToSelector:@selector(arrayUpdatedWithAllEvents:)]) {
        [protocol arrayUpdatedWithAllEvents:arrayNew];
    }
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor yellowColor]];
    
    int index = item.tag;//[arrayButtons indexOfObject:sender];
    
    if(item.tag == 0){
        appDelegate.isDateView = YES;
        appDelegate.isWeekView = NO;
        appDelegate.isMonthView = NO;
        
    }else if(item.tag == 1){
        appDelegate.isWeekView = YES;
        appDelegate.isDateView = NO;
        appDelegate.isMonthView = NO;
        
    }else if(item.tag == 2){
        appDelegate.isMonthView = YES;
        appDelegate.isWeekView = NO;
        appDelegate.isDateView = NO;
    }
    
    [self.mainView bringSubviewToFront:[arrayCalendars objectAtIndex:index]];
    
    boolYearViewIsShowing = (index == 0);
    
    [self updateNewEvents];
    [self updateLabelWithMonthAndYear];

}

-(IBAction)SegmentToggle:(UISegmentedControl*)sender {
    
    if(sender.tag == 22){
        if (sender.selectedSegmentIndex == 0) {
            
            tabNameString = @"Staff";
            
            [self addEventCalander:staff_Array];
            [appDelegate.showEventsArray addObjectsFromArray:staff_Array];
            
        }else if (sender.selectedSegmentIndex == 1) {
            
            tabNameString = @"Freelance";
            
            [self addEventCalander:freeLancer_Array];
            [appDelegate.showEventsArray addObjectsFromArray:freeLancer_Array];
            
        }else if (sender.selectedSegmentIndex == 2) {
            
            tabNameString = @"Agency";
            
            [self addEventCalander:serviceAgency_Array];
            [appDelegate.showEventsArray addObjectsFromArray:serviceAgency_Array];
            
        }else if (sender.selectedSegmentIndex == 3) {
            
            tabNameString = @"Student";
            
            [self addEventCalander:students_Array];
            [appDelegate.showEventsArray addObjectsFromArray:students_Array];
            
        }
        
        //NSString *spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO WHERE SPTYPE = '%@'",tabNameString];
        NSString *spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO WHERE SPTYPE = '%@' AND TYPE = '%@'",tabNameString,typeString];
        _ServiceProvider_TypeArray = [[GISDatabaseManager sharedDataManager] getServiceProviderArray:spCode_statement];
        
        [_staff_freeLancerButton setTitle:NSLocalizedStringFromTable(@"empty_selection", TABLE, nil) forState:UIControlStateNormal];

//        NSString *sp_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO WHERE SPTYPE = '%@' AND SERVICE_PROVIDER = '%@'",tabNameString,_staff_freeLancerButton.titleLabel.text];
//       NSArray * spTypeArray = [[GISDatabaseManager sharedDataManager] getServiceProviderArray:sp_statement];
//        
//        if([spTypeArray count]>0){
//            
//            [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
//            
//            NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
//            NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
//            GISLoginDetailsObject *login_Obj=[requetId_array lastObject];
//            
//            NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
//            if(appDelegate.isDateView){
//                [paramsDict setObject:[GISUtility eventDisplayFormat:[[FFDateManager sharedManager] currentDate]] forKey:@"StartDate"];
//                [paramsDict setObject:[GISUtility eventDisplayFormat:[[FFDateManager sharedManager] currentDate]] forKey:@"EndDate"];
//            }else if(appDelegate.isWeekView){
//                [paramsDict setObject:[GISUtility eventDisplayFormat:[NSDate getWeekFirstDate:[[FFDateManager sharedManager] currentDate]]] forKey:@"StartDate"];
//                [paramsDict setObject:[GISUtility eventDisplayFormat:[NSDate getWeeklastDate:[[FFDateManager sharedManager] currentDate]]] forKey:@"EndDate"];
//            }else if(appDelegate.isMonthView){
//                
//                [paramsDict setObject:[GISUtility eventDisplayFormat:[NSDate getMonthFirstDate:[[FFDateManager sharedManager] currentDate]]] forKey:@"StartDate"];
//                [paramsDict setObject:[GISUtility eventDisplayFormat:[NSDate getMonthlastDate:[[FFDateManager sharedManager] currentDate]]] forKey:@"EndDate"];
//            }
//            [paramsDict setObject:serviceProvider_IDString forKey:@"ServiceProvider"];
//            [paramsDict setObject:login_Obj.token_string forKey:@"token"];
//            [[GISServerManager sharedManager] getViewEditScheduledata:self withParams:paramsDict finishAction:@selector(successmethod_viewEditScheduledata:) failAction:@selector(failuremethod_viewEditScheduledata:)];
//            
//        }else{
//            
//            [_staff_freeLancerButton setTitle:NSLocalizedStringFromTable(@"empty_selection", TABLE, nil) forState:UIControlStateNormal];
//        }
        
    }else{
        
        if (sender.selectedSegmentIndex==0) {
            
            [GISUtility showAlertWithTitle:@"" andMessage:NSLocalizedStringFromTable(@"select_service_provider",TABLE, nil)];
            
            appDelegate.isfilled = YES;
            
            [self addEventCalander:viewEdit_ServiceProvider_Array];
            
                [_staff_freeLancerSegmentControl setHidden:NO];
                [_staff_freeLancerButton setHidden:NO];
            
                CGRect frame = _mainView.frame;
                frame.origin.y= 154.0f;
                _mainView.frame = frame;
            
        }else if(sender.selectedSegmentIndex==1)
        {
            appDelegate.isfilled = NO;
            
            [self addEventCalander:viewEdit_ServiceProvider_unfilledArray];
            
            //if(isServiceSelected){
                
                [_staff_freeLancerSegmentControl setHidden:YES];
                [_staff_freeLancerButton setHidden:YES];
                
                CGRect frame = _mainView.frame;
                frame.origin.y= 121.0f;
                _mainView.frame = frame;
            //}
        }
    }
}
-(void)successmethod_viewEditScheduledata:(GISJsonRequest *)response
{
    
    NSLog(@"successmethod_viewEditSchedule Success---%@",response.responseJson);
    @try {
        if ([response.responseJson isKindOfClass:[NSArray class]])
        {
            
            id array=response.responseJson;
            NSDictionary *dictHere=[array lastObject];
            
            if ([[dictHere objectForKey:kStatusCode] isEqualToString:@"200"]) {
                
                GISViewEditStore *viewEditStore;
                
                if([viewEdit_Array count]>0)
                   [viewEdit_Array removeAllObjects];
                
                if([viewEdit_ServiceProvider_Array count]>0)
                    [viewEdit_ServiceProvider_Array removeAllObjects];
                
                if([viewEdit_ServiceProvider_unfilledArray count]>0)
                    [viewEdit_ServiceProvider_unfilledArray removeAllObjects];
                
                if([staff_Array count]>0)
                    [staff_Array removeAllObjects];
                
                if([freeLancer_Array count]>0)
                    [freeLancer_Array removeAllObjects];
                
                if([serviceAgency_Array count]>0)
                    [serviceAgency_Array removeAllObjects];
                
                if([students_Array count]>0)
                    [students_Array removeAllObjects];
                
                [[GISStoreManager sharedManager] removeViewEditObjects];
               viewEditStore=[[GISViewEditStore alloc]initWithJsonDictionary:response.responseJson];
               viewEdit_Array = [[GISStoreManager sharedManager] getViewEditObjects];
                
                for(GISViewEditDateObject *viewEditObj in viewEdit_Array){
                    
                    if([viewEditObj.subRole_String isEqualToString:@"Staff"]){
                        
                        [staff_Array addObject:viewEditObj];
                    }
                    if([viewEditObj.subRole_String isEqualToString:@"Freelance"]){
                        
                        [freeLancer_Array addObject:viewEditObj];
                    }
                    if([viewEditObj.subRole_String isEqualToString:@"Agency"]){
                        
                        [serviceAgency_Array addObject:viewEditObj];
                    }
                    if([viewEditObj.subRole_String isEqualToString:@"Student"]){
                        
                        [students_Array addObject:viewEditObj];
                    }
                    
                    if([viewEditObj.serViceProvider_String length]>0){
                        
                        [viewEdit_ServiceProvider_Array addObject:viewEditObj];
                    }else{
                        [viewEdit_ServiceProvider_unfilledArray addObject:viewEditObj];
                    }
                }
                
                if(_fill_UnfillSegmentControl.selectedSegmentIndex == 0){
                    
                    [self addEventCalander:viewEdit_ServiceProvider_Array];
                    [appDelegate.showEventsArray addObjectsFromArray:viewEdit_ServiceProvider_Array];
                }else{
                    [self addEventCalander:viewEdit_ServiceProvider_unfilledArray];
                    [appDelegate.showEventsArray addObjectsFromArray:viewEdit_ServiceProvider_unfilledArray];
                }
                
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
    }
    @catch (NSException *exception)
    {
        [self removeLoadingView];
        [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in get PatTypedata action %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
    }
}

-(void)failuremethod_viewEditScheduledata:(GISJsonRequest *)response
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
-(void)removeLoadingView
{
    [[GISLoadingView sharedDataManager] removeLoadingAlertview];
}


- (IBAction) dateSelected:(id)sender{
    
    isDateSelected = YES;
    isServiceSelected = NO;
    
//    [_staff_freeLancerSegmentControl setHidden:YES];
//    [_staff_freeLancerButton setHidden:YES];
//    
//    CGRect frame = _mainView.frame;
//    frame.origin.y= 121.0f;
//    _mainView.frame = frame;
    
    [_dateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_serviceProviderButton setBackgroundImage:nil  forState:UIControlStateNormal];
    [_serviceProviderButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_dateButton setBackgroundImage:[UIImage imageNamed:@"selected.png"]  forState:UIControlStateNormal];

}

-(void)addEventCalander:(NSMutableArray *)eventArray{
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    if([eventArray count] == 0){
        [dictEvents removeAllObjects];
         [self setNewDictionary:dictEvents];
    }else{
    
        [dictEvents removeAllObjects];
    }
    
    for(GISViewEditDateObject *viewEditObject in eventArray){
        
        FFEvent *event = [FFEvent new];
        [event setStringCustomerName: viewEditObject.jobNumber_String];
        [event setNumCustomerID:[f numberFromString:viewEditObject.jobId_String]];
        [event setDateDay:[NSDate dateWithString:viewEditObject.jobDate_String]];
        NSString *str = [GISUtility getTimeData:viewEditObject.startTime_String];
        NSArray *strArray = [str componentsSeparatedByString:@":"];
        [event setDateTimeBegin:[NSDate dateWithHour:[[strArray objectAtIndex:0] intValue] min:[[strArray objectAtIndex:1] intValue]]];
        NSString *endTimestr = [GISUtility getTimeData:viewEditObject.endTime_String];
        NSArray *endTImestrArray = [endTimestr componentsSeparatedByString:@":"];
        [event setDateTimeEnd:[NSDate dateWithHour:[[endTImestrArray objectAtIndex:0] intValue] min:[[endTImestrArray objectAtIndex:1] intValue]]];
        [event setPayType:viewEditObject.patType_String];
        [event setServiceProvider:viewEditObject.serViceProvider_String];
        [event setServiceProviderType:viewEditObject.typeOfService_String];
        [event setEventName:viewEditObject.eventName_String];
        [event setRequestApproved:viewEditObject.requestApproved_String];
        [self addNewEvent:event];
    }
    [self removeLoadingView];
    
}

- (IBAction) serviceProviderSelected:(id)sender{
    
    
    isDateSelected = NO;
    isServiceSelected = YES;
    
    [_serviceProviderButton setBackgroundImage:[UIImage imageNamed:@"selected.png"]  forState:UIControlStateNormal];
    [_dateButton setBackgroundImage:nil  forState:UIControlStateNormal];
    [_dateButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_serviceProviderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    if(_fill_UnfillSegmentControl.selectedSegmentIndex == 0){
        
        [_staff_freeLancerSegmentControl setHidden:NO];
        [_staff_freeLancerButton setHidden:NO];
        
        CGRect frame = _mainView.frame;
        frame.origin.y= 154.0f;
        _mainView.frame = frame;
    }
}

- (IBAction)showServicePopoverDetails:(id)sender{
    
     UIButton *btn=(UIButton*)sender;
    
    GISPopOverTableViewController *tableViewController = [[GISPopOverTableViewController alloc] initWithNibName:@"GISPopOverTableViewController" bundle:nil];
    
    tableViewController.popOverDelegate = self;
    _popover =   [GISUtility showPopOver:(NSMutableArray *)_ServiceProvider_TypeArray viewController:tableViewController];
    _popover.delegate = self;
    
    
    if (_popover) {
        [_popover dismissPopoverAnimated:YES];
    }
    
    [_popover presentPopoverFromRect:CGRectMake(btn.frame.origin.x+btn.frame.size.width-15, btn.frame.origin.y+15, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown animated:YES];
    
}

-(void)sendTheSelectedPopOverData:(NSString *)id_str value:(NSString *)value_str
{
    serviceProvider_String= value_str;
    [_staff_freeLancerButton setTitle:serviceProvider_String forState:UIControlStateNormal];
    serviceProvider_IDString=id_str;
    if(_popover)
        [_popover dismissPopoverAnimated:YES];
    
    [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
    
    NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
    NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
    GISLoginDetailsObject *login_Obj=[requetId_array lastObject];
    
    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
    if(appDelegate.isDateView){
        [paramsDict setObject:[GISUtility eventDisplayFormat:[[FFDateManager sharedManager] currentDate]] forKey:@"StartDate"];
        [paramsDict setObject:[GISUtility eventDisplayFormat:[[FFDateManager sharedManager] currentDate]] forKey:@"EndDate"];
    }else if(appDelegate.isWeekView){
        [paramsDict setObject:[GISUtility eventDisplayFormat:[NSDate getWeekFirstDate:[[FFDateManager sharedManager] currentDate]]] forKey:@"StartDate"];
        [paramsDict setObject:[GISUtility eventDisplayFormat:[NSDate getWeeklastDate:[[FFDateManager sharedManager] currentDate]]] forKey:@"EndDate"];
    }else if(appDelegate.isMonthView){
        
        [paramsDict setObject:[GISUtility eventDisplayFormat:[NSDate getMonthFirstDate:[[FFDateManager sharedManager] currentDate]]] forKey:@"StartDate"];
        [paramsDict setObject:[GISUtility eventDisplayFormat:[NSDate getMonthlastDate:[[FFDateManager sharedManager] currentDate]]] forKey:@"EndDate"];
    }
    [paramsDict setObject:serviceProvider_IDString forKey:@"ServiceProvider"];
    [paramsDict setObject:login_Obj.token_string forKey:@"token"];
    [[GISServerManager sharedManager] getViewEditScheduledata:self withParams:paramsDict finishAction:@selector(successmethod_viewEditScheduledata:) failAction:@selector(failuremethod_viewEditScheduledata:)];

}

- (void)valueChanged:(NSDate *)newDate {
    
    NSLog(@"date changed %@",newDate);
    
    _dateTextField.text = [GISUtility eventDisplayFormat:newDate];
    
    //[popoverControllerDate dismissPopoverAnimated:YES];
    
    [mainTabbar setSelectedItem:self.dayItem];
    
    [[FFDateManager sharedManager] setCurrentDate:[NSDate dateWithYear:[NSDate componentsOfDate:newDate].year
                                                                 month:[NSDate componentsOfDate:newDate].month
                                                                   day:[NSDate componentsOfDate:newDate].day]];
    
    [self showMonthCalendar];
   
}

- (IBAction) showDatePicker:(id)sender{
    
    UIButton *btn=(UIButton*)sender;
    
    
    if ([ _dateTextField.text length]) {
        NSDate *date = [NSDate dateWithString:_dateTextField.text];
        popoverControllerDate = [[FFDatePopoverController alloc] initWithDate:date];
    }
    else
    {
        NSDate *currentDate = [NSDate dateWithYear:[NSDate componentsOfCurrentDate].year
                                             month:[NSDate componentsOfCurrentDate].month
                                               day:[NSDate componentsOfCurrentDate].day];
        popoverControllerDate = [[FFDatePopoverController alloc] initWithDate:currentDate];
    }
    
    
    [popoverControllerDate setProtocol:self];
    
    [popoverControllerDate presentPopoverFromRect:CGRectMake(btn.frame.origin.x+35, btn.frame.origin.y, btn.frame.size.width, btn.frame.size.height)
                                           inView:self.view
                         permittedArrowDirections:UIPopoverArrowDirectionUp
                                         animated:YES];
    
}

- (void)handlePinch:(UIPinchGestureRecognizer *)gestureRecognizer
{

    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    //[[NSNotificationCenter defaultCenter] removeObserver:DATE_CHANGED_UPDATE_EVENT];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
