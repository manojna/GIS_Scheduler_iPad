//
//  GISContactsAndBillingViewController.h
//  GIS_Scheduler
//
//  Created by Paradigm on 15/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISLoginDetailsObject.h"
#import "GISPopOverTableViewController.h"
#import "GISAppDelegate.h"
#import "GISContactAndBillingObject.h"
#import "GISChooseRequestDetailsObject.h"

@interface GISContactsAndBillingViewController : UIViewController<UIPopoverControllerDelegate,PopOverSelected_Protocol>
{
    GISAppDelegate *appDelegate;
    UITextField *currentTextField;
    GISContactAndBillingObject *contactBilling_Object;
    GISChooseRequestDetailsObject *chooseRequestDetailsObj;
    
    IBOutlet UILabel *requestorDetails_Label;
    
    IBOutlet UILabel *unitOrDep_Label;
    IBOutlet UILabel *unitOrDep_Answer_Label;
    
    IBOutlet UILabel *firstName_Label;
    IBOutlet UILabel *firstName_Answer_Label;
    
    IBOutlet UILabel *lastName_Label;
    IBOutlet UILabel *lastName_Answer_Label;
    
    IBOutlet UILabel *email_Label;
    IBOutlet UILabel *email_Answer_Label;
    
    IBOutlet UILabel *contacts_Label;
    IBOutlet UILabel *contacts_Answer_Label;
    
    IBOutlet UILabel *billingDetails_Label;

    IBOutlet UILabel *accountName_Label;
    IBOutlet UILabel *accountName_Answer_Label;
    
    IBOutlet UILabel *department_Label;
    IBOutlet UILabel *department_Answer_Label;
    
    IBOutlet UILabel *buhFirstName_Label;
    IBOutlet UILabel *buhFirstName_Answer_Label;
    
    IBOutlet UILabel *buhLastName_Label;
    IBOutlet UILabel *buhLastName_Answer_Label;
    
    IBOutlet UILabel *buhEmail_Label;
    IBOutlet UILabel *buhEmail_Answer_Label;
    
    IBOutlet UILabel *buhAddress1_Label;
    IBOutlet UILabel *buhAddress2_Label;

    IBOutlet UITextView *buhAddress1_TextView;
    IBOutlet UITextView *buhAddress2_textView;
    
    IBOutlet UILabel *buhCity_Label;
    IBOutlet UILabel *buhCity_Answer_Label;
    
    IBOutlet UILabel *buhState_Label;
    IBOutlet UILabel *buhState_Answer_Label;
    
    IBOutlet UILabel *buhZip_Label;
    IBOutlet UILabel *buhZip_Answer_Label;
    
    IBOutlet UIButton *nextButton;
    UIPopoverController *popover;
    
    NSMutableArray *unitOrDepartment_mutArray;
    NSMutableArray *contacts_Info_mutArray;
    GISLoginDetailsObject *login_Obj;
    
    IBOutlet UIButton *contacts_button;
    IBOutlet UIButton *unitDep_Button;
    
    GISPopOverTableViewController *tableViewController;
    
    int btnTag;
    
    NSString *unit_departmentID_String;   
}
- (IBAction)chooseRequestDropDown:(id)sender;
- (IBAction)nextButtonPressed:(id)sender;
@end
