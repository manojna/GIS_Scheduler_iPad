//
//  GISAddUpdateJobCell.h
//  GIS_Scheduler
//
//  Created by Paradigm on 09/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISAddUpdateJobCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UILabel *jobInfo_label;

@property(nonatomic,strong)IBOutlet UILabel *jobDate_label;
@property(nonatomic,strong)IBOutlet UILabel *jobDate_answer_label;

@property(nonatomic,strong)IBOutlet UILabel *startTime_label;
@property(nonatomic,strong)IBOutlet UILabel *startTime_answer_label;

@property(nonatomic,strong)IBOutlet UILabel *endTime_label;
@property(nonatomic,strong)IBOutlet UILabel *endTime_answer_label;

@property(nonatomic,strong)IBOutlet UILabel *callInTime_label;
@property(nonatomic,strong)IBOutlet UILabel *callInTime_answer_label;

@property(nonatomic,strong)IBOutlet UILabel *payLevel_label;
@property(nonatomic,strong)IBOutlet UILabel *payLevel_answer_label;

@property(nonatomic,strong)IBOutlet UILabel *typeOfServiceProvider_label;
@property(nonatomic,strong)IBOutlet UILabel *typeOfServiceProvider_answer_label;

@property(nonatomic,strong)IBOutlet UILabel *serviceProviderId_label;
@property(nonatomic,strong)IBOutlet UILabel *serviceProviderId_answer_label;

@property(nonatomic,strong)IBOutlet UILabel *cancelled_label;
@property(nonatomic,strong)IBOutlet UILabel *cancelled_answer_label;

@property(nonatomic,strong)IBOutlet UILabel *payType_label;
@property(nonatomic,strong)IBOutlet UILabel *payType_answer_label;

@property(nonatomic,strong)IBOutlet UILabel *billLevel_label;
@property(nonatomic,strong)IBOutlet UILabel *billLevel_answer_label;

@property(nonatomic,strong)IBOutlet UILabel *outAgency_label;
@property(nonatomic,strong)IBOutlet UILabel *yes_outAgency_label;
@property(nonatomic,strong)IBOutlet UILabel *no_outAgency_label;

@property(nonatomic,strong)IBOutlet UILabel *timelyAndHalf_label;
@property(nonatomic,strong)IBOutlet UILabel *yes_timelyAndHalf_label;
@property(nonatomic,strong)IBOutlet UILabel *no_timelyAndHalf_label;
@property(nonatomic,strong)IBOutlet UILabel *timely_answer_label;


@property(nonatomic,strong)IBOutlet UILabel *billingPaymentInfo_label;
@property(nonatomic,strong)IBOutlet UILabel *notesHistory_label;
@property(nonatomic,strong)IBOutlet UILabel *requestsByServiceProviders_label;

@property(nonatomic,strong)IBOutlet UITextField *parking_textField;
@property(nonatomic,strong)IBOutlet UILabel *parking_label;
//@property(nonatomic,strong)IBOutlet UILabel *parking_answer_label;

@property(nonatomic,strong)IBOutlet UITextField *billAmt_textField;
@property(nonatomic,strong)IBOutlet UILabel *billAmt_label;
@property(nonatomic,strong)IBOutlet UILabel *billAmt_answer_label;

@property(nonatomic,strong)IBOutlet UITextField *mileage_textField;
@property(nonatomic,strong)IBOutlet UILabel *mileage_label;
//@property(nonatomic,strong)IBOutlet UILabel *mileage_answer_label;

@property(nonatomic,strong)IBOutlet UITextField *invoice_textField;
@property(nonatomic,strong)IBOutlet UILabel *invoice_label;
//@property(nonatomic,strong)IBOutlet UILabel *invoice_answer_label;

@property(nonatomic,strong)IBOutlet UITextField *amtPaid_textField;
@property(nonatomic,strong)IBOutlet UILabel *amtPaid_label;
//@property(nonatomic,strong)IBOutlet UILabel *amtPaid_answer_label;

@property(nonatomic,strong)IBOutlet UILabel *billDate_label;
@property(nonatomic,strong)IBOutlet UILabel *billDate_answer_label;

@property(nonatomic,strong)IBOutlet UITextField *agencyFee_textField;
@property(nonatomic,strong)IBOutlet UILabel *agencyFee_label;
//@property(nonatomic,strong)IBOutlet UILabel *agencyFee_answer_label;

@property(nonatomic,strong)IBOutlet UILabel *timelyAndHalf_BillingPayment_label;
@property(nonatomic,strong)IBOutlet UILabel *yes_timelyAndHalf_BillingPayment_label;
@property(nonatomic,strong)IBOutlet UILabel *no_timelyAndHalf_BillingPayment_label;

@property(nonatomic,strong)IBOutlet UILabel *payStatus_label;
@property(nonatomic,strong)IBOutlet UILabel *expStatus_label;
@property(nonatomic,strong)IBOutlet UILabel *payStatus_answer_label;
@property(nonatomic,strong)IBOutlet UILabel *expStatus_answer_label;

@property(nonatomic,strong)IBOutlet UILabel *notesOrHistory_label;
@property(nonatomic,strong)IBOutlet UILabel *addNotes_label;

@property(nonatomic,strong)IBOutlet UILabel *serviceProviderName_label;
@property(nonatomic,strong)IBOutlet UILabel *requestedDate_label;

@property(nonatomic,strong)IBOutlet UILabel *payType_requestsBySP_label;
@property(nonatomic,strong)IBOutlet UILabel *gisResponse_label;


@property(nonatomic,strong)IBOutlet UIImageView *yes_outAgency_ImageView;
@property(nonatomic,strong)IBOutlet UIImageView *no_outAgency_ImageView;
@property(nonatomic,strong)IBOutlet UIImageView *yes_timelyAndHalf_ImageView;
@property(nonatomic,strong)IBOutlet UIImageView *no_timelyAndHalf_ImageView;
@property(nonatomic,strong)IBOutlet UIImageView *yes_timelyAndHalf_BillingPayment_ImageView;
@property(nonatomic,strong)IBOutlet UIImageView *no_timelyAndHalf_BillingPayment_ImageView;
@property(nonatomic,strong)IBOutlet UITextView *history_textView;
@property(nonatomic,strong)IBOutlet UIButton *addHistoryButton;
@property(nonatomic,strong)IBOutlet UIButton *serviceProviderIdButton;
@property(nonatomic,strong)IBOutlet UITextField *serviceProviderIdtextField;


































































;
@end
