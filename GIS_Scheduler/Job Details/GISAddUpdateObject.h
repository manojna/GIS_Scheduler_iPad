//
//  GISAddUpdateObject.h
//  GIS_Scheduler
//
//  Created by Paradigm on 23/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GISAddUpdateObject : NSObject
@property(nonatomic,strong)NSString *jobDate_string;
@property(nonatomic,strong)NSString *startTime_string;
@property(nonatomic,strong)NSString *endTime_string;
@property(nonatomic,strong)NSString *callInTime_string;
@property(nonatomic,strong)NSString *payLevel_string;
@property(nonatomic,strong)NSString *typeOfServiceProvider_string;
@property(nonatomic,strong)NSString *serviceProvider_string;
@property(nonatomic,strong)NSString *cancelled_string;
@property(nonatomic,strong)NSString *payType_string;
@property(nonatomic,strong)NSString *outOfAgency_string;
@property(nonatomic,strong)NSString *timelyandHalf_string;
@property(nonatomic,strong)NSString *parking_string;
@property(nonatomic,strong)NSString *billAmount_string;
@property(nonatomic,strong)NSString *mileage_string;
@property(nonatomic,strong)NSString *invoice_string;
@property(nonatomic,strong)NSString *amtPaid_string;
@property(nonatomic,strong)NSString *billdate_string;
@property(nonatomic,strong)NSString *agencyFee_string;
@property(nonatomic,strong)NSString *timelyandHalf_BillPayment_string;
@property(nonatomic,strong)NSString *payStatus_string;
@property(nonatomic,strong)NSString *expStatus_string;
@property(nonatomic,strong)NSString *billLevel_string;
@property(nonatomic,strong)NSString *timely_string;

@property(nonatomic,strong)NSString *billLevel_ID_string;
@property(nonatomic,strong)NSString *callInTime_ID_string;
@property(nonatomic,strong)NSString *payLevel_ID_string;
@property(nonatomic,strong)NSString *typeOfServiceProvider_ID_string;
@property(nonatomic,strong)NSString *serviceProvider_ID_string;
@property(nonatomic,strong)NSString *cancelled_ID_string;
@property(nonatomic,strong)NSString *payType_ID_string;
@property(nonatomic,strong)NSString *parking_ID_string;
@property(nonatomic,strong)NSString *billAmount_ID_string;
@property(nonatomic,strong)NSString *mileage_ID_string;
@property(nonatomic,strong)NSString *invoice_ID_string;
@property(nonatomic,strong)NSString *amtPaid_ID_string;
@property(nonatomic,strong)NSString *agencyFee_ID_string;
@property(nonatomic,strong)NSString *payStatus_ID_string;
@property(nonatomic,strong)NSString *expStatus_ID_string;
@property(nonatomic,strong)NSString *timely_ID_string;


@end
