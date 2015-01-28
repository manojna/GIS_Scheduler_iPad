//
//  GISLoginViewController.h
//  GIS_Scheduler
//
//  Created by Anand on 14/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISAppDelegate.h"
#import "GISStore.h"
#import "GISDropDownStore.h"
#import "GISSchedulerSPJobsStore.h"
#import "GISBaseViewController.h"
#import "GISServiceProviderStore.h"



@interface GISLoginViewController : GISBaseViewController<UITextFieldDelegate>
{
    GISAppDelegate *appDelegate;
    
    NSString *userName_String;
    NSString *password_String;
    int viewUpHeight;
    
    GISStore *gisStore;
    GISDropDownStore *dropDownStore;
    GISSchedulerSPJobsStore *spJobsStore;
    GISServiceProviderStore *serviceProviderStore;
    GISLoginDetailsObject *login_Obj;
}

@property (nonatomic,strong) IBOutlet UITextField *userName_textfield;
@property (nonatomic,strong) IBOutlet UITextField *password_textfield;
@property (nonatomic,strong) IBOutlet UIButton *signINButton;

@property (nonatomic,strong) IBOutlet UIView *userNameView;
@property (nonatomic,strong) IBOutlet UIView *passwordView;


-(IBAction)signInClicked:(id)sender;


@end
