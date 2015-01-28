//
//  GISAddUpdateJobCell.m
//  GIS_Scheduler
//
//  Created by Paradigm on 09/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISAddUpdateJobCell.h"
#import "GISConstants.h"

@implementation GISAddUpdateJobCell

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

    _jobInfo_label.text=NSLocalizedStringFromTable(@"Job_Info", TABLE, nil);
    _jobDate_label.text=NSLocalizedStringFromTable(@"Job_Date", TABLE, nil);
   
    _startTime_label.text=NSLocalizedStringFromTable(@"start_time_", TABLE, nil);
    
    _endTime_label.text=NSLocalizedStringFromTable(@"end_time_", TABLE, nil);

    _callInTime_label.text=NSLocalizedStringFromTable(@"Call_In_Time", TABLE, nil);

    _payLevel_label.text=NSLocalizedStringFromTable(@"Pay_Level", TABLE, nil);

    _typeOfServiceProvider_label.text=NSLocalizedStringFromTable(@"Type_of_Service_Provider", TABLE, nil);

    _serviceProviderId_label.text=NSLocalizedStringFromTable(@"Service_Provider_ID", TABLE, nil);

    _cancelled_label.text=NSLocalizedStringFromTable(@"Canceled", TABLE, nil);

    _payType_label.text=NSLocalizedStringFromTable(@"Pay_Type", TABLE, nil);

    _outAgency_label.text=NSLocalizedStringFromTable(@"Out_Agency", TABLE, nil);
    _yes_outAgency_label.text=NSLocalizedStringFromTable(@"yes", TABLE, nil);
    _no_outAgency_label.text=NSLocalizedStringFromTable(@"no", TABLE, nil);
    _timelyAndHalf_label.text=NSLocalizedStringFromTable(@"Timely_label", TABLE, nil);
    _yes_timelyAndHalf_label.text=NSLocalizedStringFromTable(@"yes", TABLE, nil);
    _no_timelyAndHalf_label.text=NSLocalizedStringFromTable(@"no", TABLE, nil);
    _billingPaymentInfo_label.text=NSLocalizedStringFromTable(@"BillOrPayment_Info", TABLE, nil);
    _notesHistory_label.text=NSLocalizedStringFromTable(@"Notes/History", TABLE, nil);
    _requestsByServiceProviders_label.text=NSLocalizedStringFromTable(@"Requests_by_Service_Providers", TABLE, nil);
    _parking_label.text=NSLocalizedStringFromTable(@"parking", TABLE, nil);
    
    _billAmt_label.text=NSLocalizedStringFromTable(@"Bill_Amt", TABLE, nil);
    
    _mileage_label.text=NSLocalizedStringFromTable(@"Mileage", TABLE, nil);
    
    _invoice_label.text=NSLocalizedStringFromTable(@"Invoice", TABLE, nil);

    _amtPaid_label.text=NSLocalizedStringFromTable(@"Amt_Paid", TABLE, nil);

    _billDate_label.text=NSLocalizedStringFromTable(@"Bill_Date", TABLE, nil);

    _agencyFee_label.text=NSLocalizedStringFromTable(@"Agency_Fee", TABLE, nil);

    _timelyAndHalf_BillingPayment_label.text=NSLocalizedStringFromTable(@"overRideBill", TABLE, nil);
    _yes_timelyAndHalf_BillingPayment_label.text=NSLocalizedStringFromTable(@"yes", TABLE, nil);
    _no_timelyAndHalf_BillingPayment_label.text=NSLocalizedStringFromTable(@"no", TABLE, nil);
    _payStatus_label.text=NSLocalizedStringFromTable(@"Pay_Status", TABLE, nil);
    _expStatus_label.text=NSLocalizedStringFromTable(@"Exp_Status", TABLE, nil);


    _notesOrHistory_label.text=NSLocalizedStringFromTable(@"Notes/History", TABLE, nil);
    _addNotes_label.text=NSLocalizedStringFromTable(@"Add_Notes", TABLE, nil);
    _serviceProviderName_label.text=NSLocalizedStringFromTable(@"Service_Provider_Name", TABLE, nil);
    _requestedDate_label.text=NSLocalizedStringFromTable(@"Requested_Date", TABLE, nil);
    _payType_requestsBySP_label.text=NSLocalizedStringFromTable(@"Pay_Type", TABLE, nil);
    _gisResponse_label.text=NSLocalizedStringFromTable(@"GIS_Response", TABLE, nil);
}

@end
