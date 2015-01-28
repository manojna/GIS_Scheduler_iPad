//
//  GISFindRequestJobs_Cell.h
//  GIS_Scheduler
//
//  Created by Paradigm on 29/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISFindRequestJobs_Cell : UITableViewCell

@property(nonatomic,strong) IBOutlet UILabel *reqDataToSearch_label_;
@property(nonatomic,strong) IBOutlet UILabel *startDate_label_;
@property(nonatomic,strong) IBOutlet UILabel *endDate_label_;
@property(nonatomic,strong) IBOutlet UILabel *startTime_label_;
@property(nonatomic,strong) IBOutlet UILabel *endTime_label_;
@property(nonatomic,strong) IBOutlet UILabel *requestorType_label_;
@property(nonatomic,strong) IBOutlet UILabel *requestor_label_;
@property(nonatomic,strong) IBOutlet UILabel *registeredConsumer_label_;
@property(nonatomic,strong) IBOutlet UILabel *generalLocation_label_;
@property(nonatomic,strong) IBOutlet UILabel *eventType_label_;
@property(nonatomic,strong) IBOutlet UILabel *payLevel_label_;
@property(nonatomic,strong) IBOutlet UILabel *primaryAudience_label_;
@property(nonatomic,strong) IBOutlet UILabel *model_label_;
@property(nonatomic,strong) IBOutlet UILabel *openToPublic_label_;
@property(nonatomic,strong) IBOutlet UILabel *yes_openTo_label_;
@property(nonatomic,strong) IBOutlet UILabel *no_openTo_label_;

@property(nonatomic,strong) IBOutlet UILabel *jobDataToSearch_label_;
@property(nonatomic,strong) IBOutlet UILabel *startDate_JobData_label_;
@property(nonatomic,strong) IBOutlet UILabel *endDate_JobData_label_;
@property(nonatomic,strong) IBOutlet UILabel *startTime_JobData_label_;
@property(nonatomic,strong) IBOutlet UILabel *endTime_JobData_label_;


@property(nonatomic,strong) IBOutlet UILabel *weekDays_Label_;
@property(nonatomic,strong) IBOutlet UILabel *monday_Label_;
@property(nonatomic,strong) IBOutlet UILabel *tuesday_Label_;
@property(nonatomic,strong) IBOutlet UILabel *wednesday_Label_;
@property(nonatomic,strong) IBOutlet UILabel *thursday_Label_;
@property(nonatomic,strong) IBOutlet UILabel *friday_Label_;
@property(nonatomic,strong) IBOutlet UILabel *saturday_Label_;
@property(nonatomic,strong) IBOutlet UILabel *sunday_Label_;

@property(nonatomic,strong) IBOutlet UIButton *monday_Button_;
@property(nonatomic,strong) IBOutlet UIButton *tuesday_Button_;
@property(nonatomic,strong) IBOutlet UIButton *wednesday_Button_;
@property(nonatomic,strong) IBOutlet UIButton *thursday_Button_;
@property(nonatomic,strong) IBOutlet UIButton *friday_Button_;
@property(nonatomic,strong) IBOutlet UIButton *saturday_Button_;
@property(nonatomic,strong) IBOutlet UIButton *sunday_Button_;

@property(nonatomic,strong) IBOutlet UIImageView *monday_ImageView_;
@property(nonatomic,strong) IBOutlet UIImageView *tuesday_ImageView_;
@property(nonatomic,strong) IBOutlet UIImageView *wednesday_ImageView_;
@property(nonatomic,strong) IBOutlet UIImageView *thursday_ImageView_;
@property(nonatomic,strong) IBOutlet UIImageView *friday_ImageView_;
@property(nonatomic,strong) IBOutlet UIImageView *saturday_ImageView_;
@property(nonatomic,strong) IBOutlet UIImageView *sunday_ImageView_;

@property(nonatomic,strong) IBOutlet UILabel *serviceProviderType_label_;
@property(nonatomic,strong) IBOutlet UILabel *serviceProvider_label_;
@property(nonatomic,strong) IBOutlet UILabel *filled_label_;
@property(nonatomic,strong) IBOutlet UILabel *payType_label_;
@property(nonatomic,strong) IBOutlet UILabel *outOrAgency_label_;
@property(nonatomic,strong) IBOutlet UILabel *createdBy_label_;
@property(nonatomic,strong) IBOutlet UILabel *timely_label_;
@property(nonatomic,strong) IBOutlet UILabel *payLevel_JobDate_label_;
@property(nonatomic,strong) IBOutlet UILabel *cancelled_label_;
@property(nonatomic,strong) IBOutlet UILabel *billLevel_label_;
@property(nonatomic,strong) IBOutlet UILabel *cancelDate_label_;

@property(nonatomic,strong) IBOutlet UILabel *yes_filled_label_;
@property(nonatomic,strong) IBOutlet UILabel *no_filled_label_;


@property(nonatomic,strong) IBOutlet UILabel *yes_out_label_;
@property(nonatomic,strong) IBOutlet UILabel *no_out_label_;


@property(nonatomic,strong) IBOutlet UILabel *timely_timely_label_;
@property(nonatomic,strong) IBOutlet UILabel *unTimely_timely_label_;

@property(nonatomic,strong) IBOutlet UILabel *timely_Cancelled_label_;
@property(nonatomic,strong) IBOutlet UILabel *unTimely_Cancelled_label_;

@property(nonatomic,strong) IBOutlet UIButton *openToPublic_yes_button_;
@property(nonatomic,strong) IBOutlet UIButton *openToPublic_no_button_;

@property(nonatomic,strong) IBOutlet UIButton *filled_yes_button_;
@property(nonatomic,strong) IBOutlet UIButton *filled_no_button_;

@property(nonatomic,strong) IBOutlet UIButton *outAgency_yes_button_;
@property(nonatomic,strong) IBOutlet UIButton *outAgency_no_button_;

@property(nonatomic,strong) IBOutlet UIButton *timely_yes_button_;
@property(nonatomic,strong) IBOutlet UIButton *timely_no_button_;

@property(nonatomic,strong) IBOutlet UIButton *canceled_yes_button_;
@property(nonatomic,strong) IBOutlet UIButton *canceled_no_button_;

@property(nonatomic,strong) IBOutlet UIImageView *openToPublic_Yes_ImageView;
@property(nonatomic,strong) IBOutlet UIImageView *openToPublic_no_ImageView;

@property(nonatomic,strong) IBOutlet UIImageView *filled_yes_ImageView;
@property(nonatomic,strong) IBOutlet UIImageView *filled_no_ImageView;

@property(nonatomic,strong) IBOutlet UIImageView *outAgency_yes_ImageView;
@property(nonatomic,strong) IBOutlet UIImageView *outAgency_no_ImageView;

@property(nonatomic,strong) IBOutlet UIImageView *timely_yes_ImageView;
@property(nonatomic,strong) IBOutlet UIImageView *timely_no_ImageView;

@property(nonatomic,strong) IBOutlet UIImageView *canceled_yes_ImageView;
@property(nonatomic,strong) IBOutlet UIImageView *canceled_no_ImageView;

@property(nonatomic,strong) IBOutlet UIButton *search_button_;
@property(nonatomic,strong) IBOutlet UIButton *clear_button_;


@property(nonatomic,strong) IBOutlet UILabel *startDate_Answer_label_;
@property(nonatomic,strong) IBOutlet UILabel *endDate_Answer_label_;
@property(nonatomic,strong) IBOutlet UILabel *startTime_Answer_label_;
@property(nonatomic,strong) IBOutlet UILabel *endTime_Answer_label_;
@property(nonatomic,strong) IBOutlet UILabel *requestorType_Answer_label_;
@property(nonatomic,strong) IBOutlet UILabel *requestor_Answer_label_;
@property(nonatomic,strong) IBOutlet UILabel *registeredConsumer_Answer_label_;
@property(nonatomic,strong) IBOutlet UILabel *generalLocation_Answer_label_;
@property(nonatomic,strong) IBOutlet UILabel *eventType_Answer_label_;
@property(nonatomic,strong) IBOutlet UILabel *payLevel_Answer_label_;
@property(nonatomic,strong) IBOutlet UILabel *primaryAudience_Answer_label_;
@property(nonatomic,strong) IBOutlet UILabel *model_Answer_label_;

@property(nonatomic,strong) IBOutlet UILabel *startDate_JobData_Answer_label_;
@property(nonatomic,strong) IBOutlet UILabel *endDate_JobData_Answer_label_;
@property(nonatomic,strong) IBOutlet UILabel *startTime_JobData_Answer_label_;
@property(nonatomic,strong) IBOutlet UILabel *endTime_JobData_Answer_label_;
@property(nonatomic,strong) IBOutlet UILabel *serviceProviderType_Answer_label_;
@property(nonatomic,strong) IBOutlet UILabel *serviceProvider_Answer_label_;
@property(nonatomic,strong) IBOutlet UILabel *filled_Answer_label_;
@property(nonatomic,strong) IBOutlet UILabel *payType_Answer_label_;
@property(nonatomic,strong) IBOutlet UILabel *outOrAgency_Answer_label_;
@property(nonatomic,strong) IBOutlet UILabel *createdBy_Answer_label_;
@property(nonatomic,strong) IBOutlet UILabel *payLevel_JobDate_Answer_label_;
@property(nonatomic,strong) IBOutlet UILabel *billLevel_Answer_label_;
@property(nonatomic,strong) IBOutlet UILabel *cancelDate_Answer_label_;

@end
