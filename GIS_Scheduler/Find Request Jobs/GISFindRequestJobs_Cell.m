
//
//  GISFindRequestJobs_Cell.m
//  GIS_Scheduler
//
//  Created by Paradigm on 29/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISFindRequestJobs_Cell.h"
#import "GISConstants.h"
#import "GISFonts.h"

@implementation GISFindRequestJobs_Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    _startDate_label_.text=NSLocalizedStringFromTable(@"Start_Date", TABLE, nil);
    _endDate_label_.text=NSLocalizedStringFromTable(@"End_Date", TABLE, nil);
    _startTime_label_.text=NSLocalizedStringFromTable(@"Start_Time", TABLE, nil);
    _endTime_label_.text=NSLocalizedStringFromTable(@"End_Time", TABLE, nil);
    _requestor_label_.text=NSLocalizedStringFromTable(@"Requestor", TABLE, nil);
    _registeredConsumer_label_.text=NSLocalizedStringFromTable(@"Registered_Consumer", TABLE, nil);
    _generalLocation_label_.text=NSLocalizedStringFromTable(@"General_Location", TABLE, nil);
    _payLevel_label_.text=NSLocalizedStringFromTable(@"Pay_Level", TABLE, nil);
    _primaryAudience_label_.text=NSLocalizedStringFromTable(@"Primary_Audience", TABLE, nil);
    _model_label_.text=NSLocalizedStringFromTable(@"Model", TABLE, nil);
    _openToPublic_label_.text=NSLocalizedStringFromTable(@"Open_to_Public", TABLE, nil);
    _reqDataToSearch_label_.text=NSLocalizedStringFromTable(@"Request_Data_to_Search", TABLE, nil);
    _jobDataToSearch_label_.text=NSLocalizedStringFromTable(@"Job_Data_to_Search", TABLE, nil);
    _weekDays_Label_.text=NSLocalizedStringFromTable(@"Choose_Weekdays", TABLE, nil);
    _monday_Label_.text=NSLocalizedStringFromTable(@"monday", TABLE, nil);
    _tuesday_Label_.text=NSLocalizedStringFromTable(@"tuesday", TABLE, nil);
    _wednesday_Label_.text=NSLocalizedStringFromTable(@"wednesday", TABLE, nil);
    _thursday_Label_.text=NSLocalizedStringFromTable(@"thursday", TABLE, nil);
    _friday_Label_.text=NSLocalizedStringFromTable(@"friday", TABLE, nil);
    _saturday_Label_.text=NSLocalizedStringFromTable(@"saturday", TABLE, nil);
    _sunday_Label_.text=NSLocalizedStringFromTable(@"sunday", TABLE, nil);
    _serviceProviderType_label_.text=NSLocalizedStringFromTable(@"Service_Provider_Type", TABLE, nil);
    _serviceProvider_label_.text=NSLocalizedStringFromTable(@"Service_Provider", TABLE, nil);
    _filled_label_.text=NSLocalizedStringFromTable(@"Filled", TABLE, nil);
    _payType_label_.text=NSLocalizedStringFromTable(@"Pay_Type", TABLE, nil);
    _outOrAgency_label_.text=NSLocalizedStringFromTable(@"OutORAgency", TABLE, nil);
    _createdBy_label_.text=NSLocalizedStringFromTable(@"Created_By", TABLE, nil);
    _timely_label_.text=NSLocalizedStringFromTable(@"Timely", TABLE, nil);
    _cancelled_label_.text=NSLocalizedStringFromTable(@"Canceled", TABLE, nil);
    _timely_timely_label_.text=NSLocalizedStringFromTable(@"Timely", TABLE, nil);
    _cancelDate_label_.text=NSLocalizedStringFromTable(@"Cancel_Date", TABLE, nil);
    _billLevel_label_.text=NSLocalizedStringFromTable(@"Bill_Level", TABLE, nil);
    _unTimely_Cancelled_label_.text=NSLocalizedStringFromTable(@"untimely", TABLE, nil);
    _unTimely_timely_label_.text=NSLocalizedStringFromTable(@"untimely", TABLE, nil);
    _timely_Cancelled_label_.text=NSLocalizedStringFromTable(@"Timely", TABLE, nil);
    
    _payLevel_JobDate_label_.text=NSLocalizedStringFromTable(@"Pay_Level", TABLE, nil);
    
    [_clear_button_.layer setCornerRadius:3.0f];
    [[_clear_button_ layer] setMasksToBounds:YES];
    _clear_button_.titleLabel.font=[GISFonts larger];
    
    [_search_button_.layer setCornerRadius:3.0f];
    [[_search_button_ layer] setMasksToBounds:YES];
    _search_button_.titleLabel.font=[GISFonts larger];
}

@end
