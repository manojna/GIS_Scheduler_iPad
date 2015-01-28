//
//  GISFilterMoreViewController.h
//  GIS_Scheduler
//
//  Created by Paradigm on 11/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISPopOverTableViewController.h"

@protocol FilterMore_Protocol <NSObject>

-(void)sendFilterMoreValues:(NSMutableDictionary *)dict;

@end

@interface GISFilterMoreViewController : UIViewController<UIPopoverControllerDelegate,PopOverSelected_Protocol>
{
    IBOutlet UILabel *eventType_AnswerLabel;
    IBOutlet UILabel *serviceProvider_AnswerLabel;
    IBOutlet UILabel *registeredConsumers_AnswerLabel;
    IBOutlet UILabel *unitAccount_AnswerLabel;
    NSMutableArray *unitAccount_array;
    NSMutableArray *registeredConsumers_array;
    NSMutableArray *eventType_array;
    NSMutableArray *serviceProviderType_array;
    NSMutableArray *serviceProvider_array;
    
    IBOutlet UIButton *external_btn;
    IBOutlet UIButton *internal_btn;
    IBOutlet UIButton *yes_btn_OnGoing;
    IBOutlet UIButton *no_btn_OnGoing;
    
    UIPopoverController *popover;
    int btnTag;
    
    NSString *typeOfAct_string;
    NSString *onGoing_string;
    NSString *eventType_ID_string;
    NSString *serviceProvider_ID_string;
    NSString *registeredCOnsumers_ID_string;
    NSString *unitAccount_ID_string;
}
@property(nonatomic,strong)id<FilterMore_Protocol> delegate_filter;
-(IBAction)pickerButtonPressed:(id)sender;
-(IBAction)apply_Cancel_ButtonPressed:(id)sender;
-(IBAction)radioButton_Pressed:(id)sender;
@end
