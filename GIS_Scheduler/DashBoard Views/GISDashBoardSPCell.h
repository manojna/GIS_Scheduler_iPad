//
//  GISDashBoardSPCell.h
//  GIS_Scheduler
//
//  Created by Anand on 01/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISDashBoardSPCell : UITableViewCell

@property(nonatomic,strong) IBOutlet UILabel *endTime_Label;
@property(nonatomic,strong) IBOutlet UILabel *eventType_Label;
@property(nonatomic,strong) IBOutlet UILabel *jobdate_Label;
@property(nonatomic,strong) IBOutlet UILabel *jobId_Label;
@property(nonatomic,strong) IBOutlet UILabel *requestedDate_Label;
@property(nonatomic,strong) IBOutlet UILabel *serviceProviderName_Label;
@property(nonatomic,strong) IBOutlet UILabel *startTime_Label;
@property(nonatomic,strong) IBOutlet UILabel *totalHours_Label;

@property(nonatomic,strong) IBOutlet UIButton *payType_btn;
@property(nonatomic,strong) IBOutlet UIButton *response_status_btn;
@property(nonatomic,strong) IBOutlet UIButton *done_btn;
@property(nonatomic,strong) IBOutlet UIButton *info_btn;

@property(nonatomic,strong) IBOutlet UIView *gisResponse_UIView;
@property(nonatomic,strong) IBOutlet UIView *payType_UIView;

@property(nonatomic,strong) IBOutlet UILabel *gisResponse_EDIT_Label;
@property(nonatomic,strong) IBOutlet UILabel *payType_EDIT_Label;


@property(nonatomic,strong) IBOutlet UIButton *payType_Button;
@property(nonatomic,strong) IBOutlet UIButton *gisReponse_Button;
@property(nonatomic,strong) IBOutlet UIButton *serviceProvider_Button;

@property(nonatomic,strong) IBOutlet UIButton *editButton;
@property(nonatomic,strong) IBOutlet UIButton *deleteButton;
@property(nonatomic,strong) IBOutlet UIImageView *edit_imageView;
@property(nonatomic,strong) IBOutlet UIImageView *delete_imageview;

@end
