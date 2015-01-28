//
//  GISViewEditServiceViewController.h
//  GIS_Scheduler
//
//  Created by Anand on 27/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISBaseViewController.h"
#import "GISAppDelegate.h"
#import "GISPopOverTableViewController.h"
#import "FFDatePopoverController.h"

@protocol FFCalendarViewControllerProtocol <NSObject>
@required
- (void)arrayUpdatedWithAllEvents:(NSMutableArray *)arrayUpdated;
@end

@interface GISViewEditServiceViewController : GISBaseViewController<PopOverSelected_Protocol,UIPopoverControllerDelegate>
{
    NSMutableArray *viewEdit_Array;
    NSMutableArray *viewEdit_ServiceProvider_Array;
    NSMutableArray *viewEdit_ServiceProvider_unfilledArray;
    NSMutableArray *staff_Array;
    NSMutableArray *freeLancer_Array;
    NSMutableArray *serviceAgency_Array;
    NSMutableArray *students_Array;
    GISAppDelegate *appDelegate;
    BOOL isDateSelected;
    BOOL isServiceSelected;
    NSString *serviceProvider_String;
    NSString *serviceProvider_IDString;
    NSString *tabNameString;
    NSString *typeString;
}

@property (nonatomic, strong) id <FFCalendarViewControllerProtocol> protocol;
@property (nonatomic, strong) NSMutableArray *arrayWithEvents;
@property (nonatomic, strong) IBOutlet UISegmentedControl *fill_UnfillSegmentControl;
@property (nonatomic, strong) IBOutlet UISegmentedControl *staff_freeLancerSegmentControl;
@property (nonatomic, strong) IBOutlet UIButton *staff_freeLancerButton;
@property (nonatomic, strong) IBOutlet UIButton *dateButton;
@property (nonatomic, strong) IBOutlet UIButton *serviceProviderButton;
@property (strong, nonatomic) NSArray *ServiceProvider_TypeArray;
@property (nonatomic,strong) UIPopoverController *popover;
@property (nonatomic, strong) IBOutlet UITextField *dateTextField;
@property (nonatomic, strong) IBOutlet UIImageView *dateImageView;

- (void)setArrayWithEvents:(NSMutableArray *)_arrayWithEvents;
- (IBAction) dateSelected:(id)sender;
- (IBAction) serviceProviderSelected:(id)sender;
- (IBAction)showServicePopoverDetails:(id)sender;
- (IBAction) showDatePicker:(id)sender;

@end
