//
//  GISJobAssignmentCell.h
//  GIS_Scheduler
//
//  Created by Paradigm on 22/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISJobAssignmentCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UILabel *serviceProvider_JobAssignment_label;


@property(nonatomic,strong)IBOutlet UILabel *jobId_label;
@property(nonatomic,strong)IBOutlet UILabel *jobDate_label;
@property(nonatomic,strong)IBOutlet UILabel *startTime_label;
@property(nonatomic,strong)IBOutlet UILabel *endTime_label;
@property(nonatomic,strong)IBOutlet UILabel *serviceProviderType_label;
@property(nonatomic,strong)IBOutlet UILabel *serviceProvider_label;
@property(nonatomic,strong)IBOutlet UILabel *payType_label;
@property(nonatomic,strong)IBOutlet UILabel *location_label;
@property(nonatomic,strong)IBOutlet UILabel *account_label;
@property(nonatomic,strong)IBOutlet UILabel *requestor_label;
@property(nonatomic,strong)IBOutlet UIButton *service_Provider_type_button;
@property(nonatomic,strong)IBOutlet UIButton *service_Provider_button;
@property(nonatomic,strong)IBOutlet UIButton *payType_button;
@property(nonatomic,strong)IBOutlet UIButton *oTA_button;
@property(nonatomic,strong)IBOutlet UIImageView *oTA_imageView;
@property(nonatomic,strong)IBOutlet UIButton *restore_button;

@property(nonatomic,strong)IBOutlet UITextField *service_Provider_type_textfield;
@property(nonatomic,strong)IBOutlet UITextField *service_Provider_textfield;
@property(nonatomic,strong)IBOutlet UITextField *payType_textfield;

@property(nonatomic,strong)IBOutlet UIView *serviceProviderType_UIView;
@property(nonatomic,strong)IBOutlet UIView *serviceProvider_UIView;
@property(nonatomic,strong)IBOutlet UIView *payType_UIView;



@property(nonatomic,strong)IBOutlet UIButton *edit_button;


@end
