//
//  GISJobDetailsCell.h
//  GIS_Scheduler
//
//  Created by Paradigm on 12/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISJobDetailsCell : UITableViewCell
@property(nonatomic,strong) IBOutlet UILabel *job_ID_Label;
@property(nonatomic,strong) IBOutlet UILabel *job_date_Label;
@property(nonatomic,strong) IBOutlet UILabel *start_time_Label;
@property(nonatomic,strong) IBOutlet UILabel *end_time_Label;
@property(nonatomic,strong) IBOutlet UILabel *typeOf_service_Label;
@property(nonatomic,strong) IBOutlet UILabel *service_provider_Label;
@property(nonatomic,strong) IBOutlet UILabel *payType_Label;
@property(nonatomic,strong) IBOutlet UILabel *timely_Label;
@property(nonatomic,strong) IBOutlet UILabel *billAmt_Label;
@property(nonatomic,strong) IBOutlet UIView *jobDate_UIView;
@property(nonatomic,strong) IBOutlet UIView *startTime_UIView;
@property(nonatomic,strong) IBOutlet UIView *endTime_UIView;
@property(nonatomic,strong) IBOutlet UIView *typeOf_service_UIView;
@property(nonatomic,strong) IBOutlet UIView *serviceProvider_UIView;
@property(nonatomic,strong) IBOutlet UIView *payType_UIView;

@property(nonatomic,strong) IBOutlet UILabel *jobDate_EDIT_Label;
@property(nonatomic,strong) IBOutlet UILabel *startTime_EDIT_Label;
@property(nonatomic,strong) IBOutlet UILabel *endTime_EDIT_Label;
@property(nonatomic,strong) IBOutlet UILabel *typeOf_service_EDIT_Label;
@property(nonatomic,strong) IBOutlet UILabel *service_provider_EDIT_Label;
@property(nonatomic,strong) IBOutlet UILabel *payType_EDIT_Label;
@property(nonatomic,strong) IBOutlet UILabel *slots_Label;

@property(nonatomic,strong) IBOutlet UIButton *serviceProvider_Button;
@property(nonatomic,strong) IBOutlet UIButton *payType_Button;

@property(nonatomic,strong) IBOutlet UIButton *editButton;
@property(nonatomic,strong) IBOutlet UIButton *deleteButton;
@property(nonatomic,strong) IBOutlet UIImageView *edit_imageView;
@property(nonatomic,strong) IBOutlet UIImageView *delete_imageview;
@property(nonatomic,strong) IBOutlet UITextField *payTypeTextField;
@property(nonatomic,strong) IBOutlet UITextField *serviceProviderTextField;
@end
