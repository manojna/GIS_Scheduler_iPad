//
//  GISUtility.h
//  Gallaudet-Interpreting-Service
//
//  Created by Anand on 21/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GISPopOverTableViewController.h"

//@protocol pickerDelegate <NSObject>
//@optional
//-(void)doneButnPressed:(id)sender;
//-(void)cancelButnPressed:(id)sender;
//
//@end

@interface GISUtility : NSObject
{
    
}

//@property (nonatomic,strong) id<pickerDelegate> delegate;

+ (UIPickerView *)showDropdownPickerview:(UIActionSheet *)actionSheet sender:(id)sender viewController:(UIViewController *)controller;
+(void)showAlertWithTitle:(NSString*)title andMessage:(NSString*)message;
+(void)moveemailView:(BOOL)ismove viewHeight:(int)viewUpHeight view:(UIView *)currentView;
+(NSString *)returningstring:(id)string;
+(UIPopoverController *)showPopOver:(NSMutableArray *)localArray viewController:(GISPopOverTableViewController*)tableViewController;
+(BOOL)dateComparision:(NSString *)startTime :(NSString *)endTime :(BOOL)isStartTimeComaprsion;
+(BOOL)timeComparision:(NSString *)startTime :(NSString *)endTime;
+ (NSString *)eventDisplayFormat:(NSDate *)fromdate;
+(NSString *) getTimeData:(NSString *) timeString;
+(NSString *)getEventTime:(NSDate *)fromdate;

+(UITableViewCell *)findParentTableViewCell:(UIButton *)button;
@end
