//
//  GISUtility.m
//  Gallaudet-Interpreting-Service
//
//  Created by Anand on 21/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISUtility.h"
#import "GISFonts.h"
#import "GISPopOverTableViewController.h"

@implementation GISUtility


+ (UIPickerView *)showDropdownPickerview:(UIActionSheet *)actionSheet sender:(id)sender viewController:(UIViewController *)controller{
    
    //Done Button
    UISegmentedControl *doneButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Done"]];
    doneButton.momentary = YES;
    NSInteger deviceVersion = [[UIDevice currentDevice] systemVersion].integerValue;
    if(deviceVersion >7){
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [GISFonts normal], NSFontAttributeName,
                                    [UIColor whiteColor], NSForegroundColorAttributeName,
                                    nil];
        [doneButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
        NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        [doneButton setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
        
        //doneButton.segmentedControlStyle = UISegmentedControlStyleBar;
        doneButton.tintColor = [UIColor colorWithRed:49.0 / 256.0 green:148.0 / 256.0 blue:208.0 / 256.0 alpha:1];
    }
    else{
        
        //doneButton.segmentedControlStyle = UISegmentedControlStyleBar;
        doneButton.tintColor = [UIColor blackColor];
    }
    doneButton.tag=[sender tag];
    doneButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    [doneButton addTarget:controller action:@selector(doneButnPressed:) forControlEvents:UIControlEventValueChanged];
    //Done Button
    
    //Cancel Button
    UISegmentedControl *cancelButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Cancel"]];
    cancelButton.momentary = YES;
    if(deviceVersion >7){
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [GISFonts normal], NSFontAttributeName,
                                    [UIColor whiteColor], NSForegroundColorAttributeName,
                                    nil];
        [doneButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
        NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        [doneButton setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
        
        //doneButton.segmentedControlStyle = UISegmentedControlStyleBar;
        doneButton.tintColor = [UIColor colorWithRed:49.0 / 256.0 green:148.0 / 256.0 blue:208.0 / 256.0 alpha:1];
    }
    else{
        //cancelButton.segmentedControlStyle = UISegmentedControlStyleBar;
        cancelButton.tintColor = [UIColor blackColor];
    }
    cancelButton.tag=[sender tag];
    [cancelButton addTarget:controller action:@selector(cancelButnPressed:) forControlEvents:UIControlEventValueChanged];
    cancelButton.frame = CGRectMake(195, 7.0f, 50.0f, 30.0f);
    //Cancel Button
    
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.showsSelectionIndicator = YES;
    actionSheet.tag=[sender tag];
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    [actionSheet addSubview:pickerView];
    [actionSheet addSubview:doneButton];
    [actionSheet addSubview:cancelButton];
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    [actionSheet setBounds:CGRectMake(0, 0, 320, 490)];
    
    return pickerView;
    
}


+(void)showAlertWithTitle:(NSString*)title andMessage:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

-(void)doneButnPressed:(id)sender{
    
}

-(void)cancelButnPressed:(id)sender{
    
}


+(void)moveemailView:(BOOL)ismove viewHeight:(int)viewUpHeight view:(UIView *)currentView
{
    
    if(ismove)
    {
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration:1.0];
        
        CGRect frame=currentView.frame;
        frame.origin.y=viewUpHeight;
        currentView.frame=frame;
        [UIView commitAnimations];
    }
    else
    {
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration:0.2];
        CGRect frame=currentView.frame;
        frame.origin.y=0;
        currentView.frame=frame;
        
        [UIView commitAnimations];
    }
}

+(NSString *)returningstring:(id)string
{
    if ([string isKindOfClass:[NSNull class]] || string==nil)
    {
        return @" ";
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

+(UIPopoverController *)showPopOver:(NSMutableArray *)localArray viewController:(GISPopOverTableViewController*)tableViewController{

    UIPopoverController *popover =[[UIPopoverController alloc] initWithContentViewController:tableViewController];
    popover.popoverContentSize = CGSizeMake(300, 210);
    tableViewController.popOverArray=localArray;
   
    return popover;
}



+(BOOL)dateComparision:(NSString *)startTime :(NSString *)endTime :(BOOL)isStartTimeComaprsion
{
    if (isStartTimeComaprsion) {
        if ([endTime compare:startTime] == NSOrderedDescending || [endTime compare:startTime]==NSOrderedSame)
        {
            NSLog(@" Good");
            return YES;
        }
        return NO;
    }
    
    if ([startTime compare:endTime] == NSOrderedAscending || [startTime compare:endTime]==NSOrderedSame)
    {
        NSLog(@" Good");
        return YES;
    }
    return NO;
}

+(BOOL)timeComparision:(NSString *)startTime :(NSString *)endTime
{
    NSDateFormatter *timeformatter=[[NSDateFormatter alloc]init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [timeformatter setLocale:locale];
    [timeformatter setDateFormat:@"hh:mm a"];
    
    NSDate *date1=[timeformatter dateFromString:startTime];
    NSDate *date2=[timeformatter dateFromString:endTime];
    NSLog(@"%ff is the time difference",[date2 timeIntervalSinceDate:date1]);
    if([date2 timeIntervalSinceDate:date1]>0)
    {
        return YES;
        NSLog(@" Good");
    }
    
    NSLog(@" BAD");
    return NO;
    
}

+(NSString *)eventDisplayFormat:(NSDate *)fromdate
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

+(NSString *) getTimeData:(NSString *) timeString{
    
    NSDateFormatter *dtf = [[NSDateFormatter alloc] init];
    [dtf setDateFormat:@"hh:mm a"];
    [dtf setFormatterBehavior:NSDateFormatterBehaviorDefault];
    NSLocale *curentLocale = [NSLocale currentLocale];
    [dtf setLocale:[[NSLocale alloc] initWithLocaleIdentifier:[curentLocale localeIdentifier]]];
    NSDate *date = [dtf dateFromString:timeString];
    
    dtf.dateFormat = @"HH:mm";
    NSString *pmamDateString = [dtf stringFromDate:date];
    
    return pmamDateString;
}

+(NSString *)getEventTime:(NSDate *)fromdate
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *dateStr = [dateFormat stringFromDate:fromdate];
    NSDate *myDate = [dateFormat dateFromString:dateStr];
    
    NSDateFormatter *dtf = [[NSDateFormatter alloc] init];
    [dtf setDateFormat:@"hh:mm a"];
    [dtf setFormatterBehavior:NSDateFormatterBehaviorDefault];
    NSLocale *curentLocale = [NSLocale currentLocale];
    [dtf setLocale:[[NSLocale alloc] initWithLocaleIdentifier:[curentLocale localeIdentifier]]];
    NSString *stringFromDate = [dtf stringFromDate:myDate];
    
    return stringFromDate;
}

+(UITableViewCell *)findParentTableViewCell:(UIButton *)button
{
    UIView *view = button.superview;
    while (view.superview != nil)
    {
        if ([view isKindOfClass:[UITableViewCell class]])
        {
            return (UITableViewCell *)view;
        }
        else
        {
            view = view.superview;
        }
    }
    return nil;
}
@end
