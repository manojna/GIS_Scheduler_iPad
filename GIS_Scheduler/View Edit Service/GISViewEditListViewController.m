//
//  GISViewEditListViewController.m
//  GIS_Scheduler
//
//  Created by Anand on 16/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISViewEditListViewController.h"
#import "GISViewEditListVIewCell.h"
#import "NSDate+FFDaysCount.h"
#import "FFDayCalendarView.h"
#import "FFDateManager.h"
#import "GISUtility.h"

@interface GISViewEditListViewController ()

@end

@implementation GISViewEditListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication]delegate];
    _eventArray = [[NSMutableArray alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(appDelegate.isMonthView){
        if(appDelegate.isoneEvent)
            return 1;
        else
            return [appDelegate.monthEventsArray count];
    }
    
    return  [appDelegate.jobEventsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    GISViewEditListVIewCell *cell=(GISViewEditListVIewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"GISViewEditListVIewCell" owner:self options:nil]objectAtIndex:0];
    }
    
    if(appDelegate.isMonthView){
        
        if(!appDelegate.isoneEvent){
            _testEvent = [appDelegate.monthEventsArray objectAtIndex:indexPath.row];
        }
        cell.jobName.text = [NSString stringWithFormat:@"JobID %@",_testEvent.stringCustomerName];
        cell.eventTime.text =[NSString stringWithFormat:@"JobTime %@ to %@ ", [NSDate stringTimeOfDate:_testEvent.dateTimeBegin] ,[NSDate stringTimeOfDate:_testEvent.dateTimeEnd]];
        cell.eventTitle.text = [NSString stringWithFormat:@"Requested On %@", [NSDate stringDayOfDate:_testEvent.dateDay]];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }else if(appDelegate.isWeekView){
        
        _testEvent = [appDelegate.jobEventsArray objectAtIndex:indexPath.row];
        [_eventArray addObject:_testEvent];
        
        cell.jobName.text = _testEvent.stringCustomerName;
        cell.eventTime.text =[NSString stringWithFormat:@"JobTime %@ to %@ ", [NSDate stringTimeOfDate:_testEvent.dateTimeBegin] ,[NSDate stringTimeOfDate:_testEvent.dateTimeEnd]];
        cell.eventTitle.text = [NSString stringWithFormat:@"Requested On %@", [NSDate stringDayOfDate:_testEvent.dateDay]];
        
        cell.selectionStyle=UITableViewCellSelectionStyleDefault;
        
    }else{
        _eventButton = [appDelegate.jobEventsArray objectAtIndex:indexPath.row];
        [_eventArray addObject:_eventButton.event];
        
        cell.jobName.text = _eventButton.event.stringCustomerName;
        cell.eventTime.text =[NSString stringWithFormat:@"JobTime %@ to %@ ", [NSDate stringTimeOfDate:_eventButton.event.dateTimeBegin] ,[NSDate stringTimeOfDate:_eventButton.event.dateTimeEnd]];
        cell.eventTitle.text = [NSString stringWithFormat:@"Requested On %@", [NSDate stringDayOfDate:_eventButton.event.dateDay]];
        
        cell.selectionStyle=UITableViewCellSelectionStyleDefault;
    }
    
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //    if (cell == nil) {
    //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    //    }
    
    
    //cell.textLabel.text = [_testArray objectAtIndex:indexPath.row];
    // Configure the cell...
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISViewEditListVIewCell *cell;
    
    cell=(GISViewEditListVIewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    
    return cell.frame.size.height;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    
    
    //    NSDictionary *infoDict=[NSDictionary dictionaryWithObjectsAndKeys:_testEvent,@"event",nil];
    //
    //    [[NSNotificationCenter defaultCenter]postNotificationName:SHOW_EVENT object:nil userInfo:infoDict];
    
    if(appDelegate.isDateView){
        
         _testEvent = [_eventArray objectAtIndex:indexPath.row];
        NSDictionary *infoDict=[NSDictionary dictionaryWithObjectsAndKeys:_testEvent,@"event",nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:SHOW_EVENT object:nil userInfo:infoDict];
        
    }else if(appDelegate.isWeekView){
        
         _testEvent = [_eventArray objectAtIndex:indexPath.row];
        NSDictionary *infoDict=[NSDictionary dictionaryWithObjectsAndKeys:_testEvent,@"event",nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:SHOW_WEEK_EVENT object:nil userInfo:infoDict];
        
    }
}

@end
