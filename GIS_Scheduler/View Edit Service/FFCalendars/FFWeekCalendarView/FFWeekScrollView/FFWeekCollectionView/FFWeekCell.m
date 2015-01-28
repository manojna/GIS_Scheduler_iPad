//
//  FFWeekCell.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/22/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFWeekCell.h"

#import "FFHourAndMinLabel.h"
#import "FFBlueButton.h"
#import "FFEventDetailPopoverController.h"
#import "FFEditEventPopoverController.h"
#import "FFImportantFilesForCalendar.h"
#import "GISPopOverController.h"
#import "GISAppDelegate.h"
#import "GISEventLabel.h"
#import "GISFonts.h"
#import "PCLogger.h"

@interface FFWeekCell () <FFEventDetailPopoverControllerProtocol, FFEditEventPopoverControllerProtocol, TestEventDetailPopoverControllerProtocol>
@property (nonatomic, strong) NSMutableArray *arrayLabelsHourAndMin;
@property (nonatomic, strong) NSMutableArray *arrayButtonsEvents;
@property (nonatomic, strong) NSMutableArray *repeatedArray;
@property (nonatomic, strong) NSMutableArray *eventsArray;
@property (nonatomic, strong) FFEventDetailPopoverController *popoverControllerDetails;
@property (nonatomic, strong) GISPopOverController *testPopoverControllerDetails;
@property (nonatomic, strong) FFEditEventPopoverController *popoverControllerEditar;
@property (nonatomic, strong) FFBlueButton *button;
@end

@implementation FFWeekCell

@synthesize protocol;
@synthesize date;
@synthesize arrayLabelsHourAndMin;
@synthesize arrayButtonsEvents;
@synthesize popoverControllerDetails;
@synthesize popoverControllerEditar;
@synthesize button;
@synthesize testPopoverControllerDetails;
@synthesize repeatedArray;
@synthesize eventsArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        arrayLabelsHourAndMin = [NSMutableArray new];
        arrayButtonsEvents = [NSMutableArray new];
        eventsArray = [NSMutableArray new];
        
        [self addLines];
    }
    return self;
}

- (void)showEvents:(NSArray *)array {
    
    [self addButtonsWithArray:array];
}

- (void)addLines {
    
    CGFloat y = 0;
    
    for (int hour=0; hour<=23; hour++) {
        
        for (int min=0; min<=45; min=min+MINUTES_PER_LABEL) {
            
            FFHourAndMinLabel *labelHourMin = [[FFHourAndMinLabel alloc] initWithFrame:CGRectMake(0, y, self.frame.size.width, HEIGHT_CELL_MIN) date:[NSDate dateWithHour:hour min:min]];
            [labelHourMin setTextColor:[UIColor grayColor]];
            if (min == 0) {
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT_CELL_MIN/2., self.frame.size.width, 1.)];
                [view setBackgroundColor:[UIColor lightGrayCustom]];
                [labelHourMin addSubview:view];
                [view setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
                [labelHourMin setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
            }
            [self addSubview:labelHourMin];
            [arrayLabelsHourAndMin addObject:labelHourMin];
            
            y += HEIGHT_CELL_MIN;
        }
    }
}

- (void)clean {
    
     [arrayButtonsEvents removeAllObjects];
    
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[FFBlueButton class]] || [subview isKindOfClass:[UIView class]] ||  [subview isKindOfClass:[UILabel class]]) {
            
            [subview removeFromSuperview];
        }
    }
}

- (void)addButtonsWithArray:(NSArray *)array {
    
    UIView *view;
    
    if (array) {
        
        int i = 0;
        int count=0;
        NSArray *arrayEvents = array;
        repeatedArray = [[NSMutableArray alloc] init];
        NSMutableArray *repeatedCountArray = [[NSMutableArray alloc] init];
        
        for (FFEvent *event in array) {
            
            FFEvent *nextEvent;
            FFEvent *lastEvent;
            
            if([arrayEvents count]>i+1)
                nextEvent= [arrayEvents objectAtIndex:i+1];
            
            if([arrayEvents count]>i+1 && i>1)
                lastEvent= [arrayEvents objectAtIndex:i-1];
            
            CGFloat yTimeBegin;
            CGFloat yTimeEnd;
            FFBlueButton *_labelbutton;
            
//            NSPredicate *filePredicate=[NSPredicate predicateWithFormat:@"dateDay==%@ ",event.dateDay];
//            NSArray *dateArray=[arrayEvents filteredArrayUsingPredicate:filePredicate];
//            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dateTimeBegin > %@ AND dateTimeEnd < %@", event.dateTimeBegin, event.dateTimeEnd];
//            NSArray *fileArray=[dateArray filteredArrayUsingPredicate:predicate];
//            
//            
//            if([fileArray count]>0)
//            {
//                
//            }
            
            for (FFHourAndMinLabel *label in arrayLabelsHourAndMin) {
                NSDateComponents *compLabel = [NSDate componentsOfDate:label.dateHourAndMin];
                NSDateComponents *compEventBegin = [NSDate componentsOfDate:event.dateTimeBegin];
                NSDateComponents *compEventEnd = [NSDate componentsOfDate:event.dateTimeEnd];
                
                if (compLabel.hour == compEventBegin.hour && compLabel.minute <= compEventBegin.minute && compEventBegin.minute < compLabel.minute+MINUTES_PER_LABEL) {
                    yTimeBegin = label.frame.origin.y+label.frame.size.height/2.;
                }
                if (compLabel.hour == compEventEnd.hour && compLabel.minute <= compEventEnd.minute && compEventEnd.minute < compLabel.minute+MINUTES_PER_LABEL) {
                    yTimeEnd = label.frame.origin.y+label.frame.size.height;
                }
            }
            
            if(nextEvent != nil){
                
                FFBlueButton *_button = [[FFBlueButton alloc] initWithFrame:CGRectMake(0+i*12, yTimeBegin, self.frame.size.width, yTimeEnd-yTimeBegin)];
                [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                [_button setBackgroundColor:[UIColor colorWithRed:179./255. green:255./255. blue:255./255. alpha:0.5]];
                [_button setTitle:[NSString stringWithFormat:@"%@ %@",@"JobID", event.stringCustomerName] forState:UIControlStateNormal];
                [_button setEvent:event];
                
                [arrayButtonsEvents addObject:_button];
                [eventsArray addObject:_button.event];
                [self addSubview:_button];
                
                view = [[UIView alloc] initWithFrame:CGRectMake(_button.frame.origin.x-2, _button.frame.origin.y, 2.0f, _button.frame.size.height)];
                [view setBackgroundColor:[UIColor colorWithRed:28./255. green:195./255. blue:255./255. alpha:5.0]];
                
                [self addSubview:view];
                
                _labelbutton = [[FFBlueButton alloc] initWithFrame:CGRectMake(40, yTimeEnd-25, self.frame.size.width-88, 15)];
                [_labelbutton setBackgroundColor:[UIColor  clearColor]];
                [_labelbutton.titleLabel setFont:[GISFonts smallBold]];
                [_labelbutton.titleLabel setTextColor:[UIColor blackColor]];
                [_labelbutton setEvent:event];
                [self addSubview:_labelbutton];
                
                if(([[self getCorrectTimeformdate:event.dateTimeBegin] isEqualToString:[self getCorrectTimeformdate:nextEvent.dateTimeBegin]]) || ([[self getCorrectTimeformdate:event.dateTimeEnd] isEqualToString:[self getCorrectTimeformdate:nextEvent.dateTimeEnd]])){
                    
                    count ++;
                    
                    if(count >1){
                        
                        [_labelbutton setHidden:FALSE];

                    }else{
                        
                        [_labelbutton setHidden:TRUE];
                    }
                    
                    [repeatedCountArray addObject:_labelbutton];
                    
                    if([repeatedCountArray count])
                       [_labelbutton setTitle:@"" forState:UIControlStateNormal];
                    
                    [_labelbutton setTitle:[NSString stringWithFormat:@"%d more",[repeatedCountArray count]-1] forState:UIControlStateNormal];

                    
                }else if([[self eventDisplayFormat:event.dateDay] isEqualToString:[self eventDisplayFormat:nextEvent.dateDay]]){
                    
                    
                    NSString *btnStartTime = [self getCorrectTimeformdate:event.dateTimeBegin];
                    NSString *btnEndTime = [self getCorrectTimeformdate:event.dateTimeEnd];
                    NSString *buttonStartTime = [self getCorrectTimeformdate:nextEvent.dateTimeBegin];
                    NSString *buttonEndTime = [self getCorrectTimeformdate:nextEvent.dateTimeEnd];
                    
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"hh:mm a"];
                    
                    NSDate *date1= [formatter dateFromString:btnStartTime];
                    NSDate *date2 = [formatter dateFromString:buttonStartTime];
                    
                    NSDate *endTime1= [formatter dateFromString:btnEndTime];
                    NSDate *endTime2 = [formatter dateFromString:buttonEndTime];

                    
                    NSComparisonResult result = [date1 compare:date2];
                    NSComparisonResult endTimeresult = [endTime1 compare:endTime2];
                    if(result == NSOrderedDescending || endTimeresult == NSOrderedDescending)
                    {
                        CGRect frame  = _button.frame;
                        frame.origin.x = _button.frame.origin.x+12;
                        _button.frame = frame;
                        
                        CGRect viewFrame  = view.frame;
                        viewFrame.origin.x = _button.frame.origin.x-2;
                        view.frame = viewFrame;
                        
                        [self bringSubviewToFront:_button];

                    }
                    else if(result == NSOrderedAscending || endTimeresult == NSOrderedAscending)
                    {
                        CGRect frame  = _button.frame;
                        frame.origin.x = _button.frame.origin.x+12;
                        _button.frame = frame;
                        
                        CGRect viewFrame  = view.frame;
                        viewFrame.origin.x = _button.frame.origin.x-2;
                        view.frame = viewFrame;
                        
                        [self bringSubviewToFront:_button];
                    }
                    else
                    {
                        
                    }

                }else{
                   
                    count = 0;
                }
            }else{
                
                count = 0;
                [_labelbutton setHidden:TRUE];
                if(repeatedArray)
                   [repeatedArray removeAllObjects];
                
                FFBlueButton *_button = [[FFBlueButton alloc] initWithFrame:CGRectMake(0+i*12, yTimeBegin, self.frame.size.width, yTimeEnd-yTimeBegin)];
                [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                [_button setBackgroundColor:[UIColor colorWithRed:179./255. green:255./255. blue:255./255. alpha:0.5]];
                [_button setTitle:[NSString stringWithFormat:@"%@ %@",@"JobID", event.stringCustomerName] forState:UIControlStateNormal];
                [_button setEvent:event];
                
                [arrayButtonsEvents addObject:_button];
                [eventsArray addObject:_button.event];
                [self addSubview:_button];
                
                view = [[UIView alloc] initWithFrame:CGRectMake(_button.frame.origin.x-2, _button.frame.origin.y, 2.0f, _button.frame.size.height)];
                [view setBackgroundColor:[UIColor colorWithRed:28./255. green:195./255. blue:255./255. alpha:5.0]];
                
                [self addSubview:view];
                
                [self bringSubviewToFront:_button];
            }
            
        }
        count = 0;
        i++;
    }
    
}

#pragma mark - Button Action

- (IBAction)buttonAction:(id)sender {
    
    button = (FFBlueButton *)sender;
    [button setBackgroundColor:[UIColor colorWithRed:28./255. green:195./255. blue:255./255. alpha:5.0]]; //forState:UIControlStateHighlighted];
    
    GISAppDelegate *appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication]delegate];
    appDelegate.isWeekView = YES;
    
    NSMutableArray *btnArray = [[NSMutableArray alloc] init];
    
    NSPredicate *filePredicate=[NSPredicate predicateWithFormat:@"dateDay==%@ ",button.event.dateDay];
    NSArray *dateArray=[eventsArray filteredArrayUsingPredicate:filePredicate];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dateTimeBegin >= %@ AND dateTimeEnd <= %@", button.event.dateTimeBegin, button.event.dateTimeEnd];
    NSArray *fileArray=[dateArray filteredArrayUsingPredicate:predicate];
    
    
    if([fileArray count]>0)
    {
        [btnArray addObjectsFromArray:(NSArray *)fileArray];
    }
   
//    for(FFBlueButton *btn in arrayButtonsEvents)
//    {
//        if([[self eventDisplayFormat:btn.event.dateDay] isEqualToString:[self eventDisplayFormat:button.event.dateDay]]){
//            
//            int btnStartTime = [self getTimeformdate:btn.event.dateTimeBegin].intValue;
//            int btnEndTime = [self getTimeformdate:btn.event.dateTimeEnd].intValue;
//            int buttonStartTime = [self getTimeformdate:button.event.dateTimeBegin].intValue;
//            int buttonEndTime = [self getTimeformdate:button.event.dateTimeEnd].intValue;
//            
//            if(([[self getTimeformdate:btn.event.dateTimeBegin] isEqualToString:[self getTimeformdate:button.event.dateTimeBegin]]) || ([[self getTimeformdate:btn.event.dateTimeEnd] isEqualToString:[self getTimeformdate:button.event.dateTimeEnd]]) || (btnStartTime > buttonStartTime && btnEndTime < buttonEndTime)){
//
//                [btnArray addObject:btn];
//                
//            }
//        }
//    }
    
    if([appDelegate.jobEventsArray count] >0)
        [appDelegate.jobEventsArray removeAllObjects];
    
    if(testPopoverControllerDetails.isPopoverVisible || testPopoverControllerDetails != nil){
        [testPopoverControllerDetails dismissPopoverAnimated:YES];
        testPopoverControllerDetails = nil;
        
    }
    
    @try {
        
        testPopoverControllerDetails = [[GISPopOverController alloc] initWithEvent:button.event];
        [appDelegate.jobEventsArray addObjectsFromArray:(NSArray *)btnArray];
        
        [testPopoverControllerDetails setTestProtocol:self];
        [testPopoverControllerDetails setDelegate:self];
        
        [testPopoverControllerDetails presentPopoverFromRect:button.frame
                                                      inView:self
                                    permittedArrowDirections:UIPopoverArrowDirectionAny
                                                    animated:YES];

    }
    @catch (NSException *exception)
    {
        [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in get Select Event in WeekCell action %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
    }
   }

#pragma mark - FFEventDetailPopoverController Protocol

- (void)showPopoverEditWithEvent:(FFEvent *)_event {
    
    if(popoverControllerEditar.isPopoverVisible || popoverControllerEditar != nil){
        [popoverControllerEditar dismissPopoverAnimated:YES];
        popoverControllerEditar = nil;
        
    }
    
    @try {
        popoverControllerEditar = [[FFEditEventPopoverController alloc] initWithEvent:_event];
        [popoverControllerEditar setProtocol:self];
        [popoverControllerEditar setDelegate:self];
        
        
        [popoverControllerEditar presentPopoverFromRect:button.frame
                                                 inView:self
                               permittedArrowDirections:UIPopoverArrowDirectionAny
                                               animated:YES];
    }
    @catch (NSException *exception)
    {
        [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in get Select EditEvent in WeekCell action %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
    }
    
    
}


#pragma mark - FFEditEventPopoverController Protocol

- (void)saveEditedEvent:(FFEvent *)eventNew {
    
    if (protocol != nil && [protocol respondsToSelector:@selector(saveEditedEvent:ofCell:atIndex:)]) {
        [protocol saveEditedEvent:eventNew ofCell:self atIndex:[arrayButtonsEvents indexOfObject:button]];
    }
}

- (void)deleteEvent {
    
    if (protocol != nil && [protocol respondsToSelector:@selector(deleteEventOfCell:atIndex:)]) {
        [protocol deleteEventOfCell:self atIndex:[arrayButtonsEvents indexOfObject:button]];
    }
}

#pragma mark - TestEventDetailPopoverController Protocol

- (void)showPopoverEventDetailWithEvent:(FFEvent *)_event{
    
    if(popoverControllerDetails.isPopoverVisible || popoverControllerDetails != nil){
        [popoverControllerDetails dismissPopoverAnimated:YES];
        popoverControllerDetails = nil;
        
    }
    
    @try {
        popoverControllerDetails = [[FFEventDetailPopoverController alloc] initWithEvent:_event];
        [popoverControllerDetails setProtocol:self];
        [popoverControllerDetails setDelegate:self];
        
        if(button){
            [popoverControllerDetails presentPopoverFromRect:button.frame
                                                      inView:self
                                    permittedArrowDirections:UIPopoverArrowDirectionAny
                                                    animated:YES];
        }
    }
    @catch (NSException *exception)
    {
        [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in get Select FFEventDetailPopoverController in WeekCell action %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
    }

}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (NSString *)eventDisplayFormat:(NSDate *)fromdate
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *dateStr = [dateFormat stringFromDate:fromdate];
    NSDate *myDate = [dateFormat dateFromString:dateStr];
    
    NSDateComponents *components= [[NSDateComponents alloc] init];
    [components setDay:0];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *dateIncremented= [calendar dateByAddingComponents:components toDate:myDate options:0];
    
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSString *stringFromDate = [myDateFormatter stringFromDate:dateIncremented];
    
    return stringFromDate;
}

-(NSString *)getTimeformdate:(NSDate *)localdate{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *dateStr = [dateFormat stringFromDate:localdate];
    NSDate *myDate = [dateFormat dateFromString:dateStr];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"hh:mm a"];
    [dateFormatter setFormatterBehavior:NSDateFormatterBehaviorDefault];
    NSLocale *curentLocale = [NSLocale currentLocale];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:[curentLocale localeIdentifier]]];
    
    //NSString *timeString = [dateFormatter stringFromDate:myDate];
    
    dateFormatter.dateFormat = @"HH:mm";
    NSString *pmamDateString = [dateFormatter stringFromDate:myDate];
    
    NSString *hourString;
    
    NSRange newRange = [pmamDateString rangeOfString:@":"];
    if(newRange.location != NSNotFound) {
        hourString = [pmamDateString substringToIndex:newRange.location];
    }

    
    return hourString;
}

-(NSString *)getCorrectTimeformdate:(NSDate *)localdate{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *dateStr = [dateFormat stringFromDate:localdate];
    NSDate *myDate = [dateFormat dateFromString:dateStr];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"hh:mm a"];
    [dateFormatter setFormatterBehavior:NSDateFormatterBehaviorDefault];
    NSLocale *curentLocale = [NSLocale currentLocale];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:[curentLocale localeIdentifier]]];
    
    //NSString *timeString = [dateFormatter stringFromDate:myDate];
    
    dateFormatter.dateFormat = @"hh:mm a";
    NSString *timeString = [dateFormatter stringFromDate:myDate];
    
    return timeString;
}


- (IBAction)showDetails:(id)sender {
    
    button = (FFBlueButton *)sender;
    
    GISAppDelegate *appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication]delegate];
    appDelegate.isWeekView = YES;
    
    if([appDelegate.jobEventsArray count] >0)
        [appDelegate.jobEventsArray removeAllObjects];
    
    if([repeatedArray count] >0)
        [repeatedArray removeAllObjects];
    
    NSPredicate *filePredicate=[NSPredicate predicateWithFormat:@"dateDay==%@ ",button.event.dateDay];
    NSArray *dateArray=[eventsArray filteredArrayUsingPredicate:filePredicate];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dateTimeBegin = %@ AND dateTimeEnd <= %@", button.event.dateTimeBegin, button.event.dateTimeEnd];
    NSArray *fileArray=[dateArray filteredArrayUsingPredicate:predicate];
    
    
    if([fileArray count]>0)
    {
        [repeatedArray addObjectsFromArray:(NSArray *)fileArray];
    }
    
//    for(FFBlueButton *btn in arrayButtonsEvents)
//    {
//        if([[self eventDisplayFormat:btn.event.dateDay] isEqualToString:[self eventDisplayFormat:button.event.dateDay]]){
//            
//            if(([[self getTimeformdate:btn.event.dateTimeBegin] isEqualToString:[self getTimeformdate:button.event.dateTimeBegin]]) || ([[self getTimeformdate:btn.event.dateTimeEnd] isEqualToString:[self getTimeformdate:button.event.dateTimeEnd]])){
//                
//                [repeatedArray addObject:btn];
//                
//            }
//        }
//    }

    
    testPopoverControllerDetails = [[GISPopOverController alloc] initWithEvent:button.event];
    [appDelegate.jobEventsArray addObjectsFromArray:(NSArray *)repeatedArray];
    
    [testPopoverControllerDetails setTestProtocol:self];
    
    [testPopoverControllerDetails presentPopoverFromRect:button.frame
                                                  inView:self
                                permittedArrowDirections:UIPopoverArrowDirectionAny
                                                animated:YES];
    [testPopoverControllerDetails setDelegate:self];

}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController{
    
    if(button){
        [button setBackgroundColor:[UIColor colorWithRed:179./255. green:255./255. blue:255./255. alpha:0.5]];
    }
    if(popoverController)
        popoverController = nil;
    
    return YES;
}

@end
