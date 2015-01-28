//
//  GISFindRequestJobsObject.h
//  GIS_Scheduler
//
//  Created by Paradigm on 29/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GISFindRequestJobsObject : NSObject
@property(nonatomic,strong)NSString *startDate_string;
@property(nonatomic,strong)NSString *endDate_string;
@property(nonatomic,strong)NSString *startTime_string;
@property(nonatomic,strong)NSString *endTime_string;
@property(nonatomic,strong)NSString *requestorType_string;
@property(nonatomic,strong)NSString *requestorType_ID_string;
@property(nonatomic,strong)NSString *requestor_string;
@property(nonatomic,strong)NSString *requestor_ID_string;
@property(nonatomic,strong)NSString *registeredConsumers_string;
@property(nonatomic,strong)NSString *registeredConsumers_ID_string;
@property(nonatomic,strong)NSString *generalLocation_string;
@property(nonatomic,strong)NSString *generalLocation_ID_string;
@property(nonatomic,strong)NSString *evenyType_string;
@property(nonatomic,strong)NSString *evenyType_ID_string;
@property(nonatomic,strong)NSString *payLevel_string;
@property(nonatomic,strong)NSString *payLevel_ID_string;
@property(nonatomic,strong)NSString *primaryAudience_string;
@property(nonatomic,strong)NSString *primaryAudience_ID_string;
@property(nonatomic,strong)NSString *model_string;
@property(nonatomic,strong)NSString *model_ID_string;
@property(nonatomic,strong)NSString *openToPublic_string;
@property(nonatomic,strong)NSString *startDate_JobData_string;
@property(nonatomic,strong)NSString *endDate_JobData_string;
@property(nonatomic,strong)NSString *startTime_JobData_string;
@property(nonatomic,strong)NSString *endTime_JobData_string;
@property(nonatomic,strong)NSString *serviceProviderType_string;
@property(nonatomic,strong)NSString *serviceProviderType_ID_string;
@property(nonatomic,strong)NSString *serviceProvider_string;
@property(nonatomic,strong)NSString *serviceProvider_ID_string;
@property(nonatomic,strong)NSString *filled_string;
@property(nonatomic,strong)NSString *payType_string;
@property(nonatomic,strong)NSString *payType_ID_string;
@property(nonatomic,strong)NSString *outAgency_string;
@property(nonatomic,strong)NSString *createdBy_string;
@property(nonatomic,strong)NSString *createdBy_ID_string;
@property(nonatomic,strong)NSString *timely_string;
@property(nonatomic,strong)NSString *cancelled_string;
@property(nonatomic,strong)NSString *payLevel_JobData_string;
@property(nonatomic,strong)NSString *payLevel_JobData_ID_string;
@property(nonatomic,strong)NSString *billLevel_string;
@property(nonatomic,strong)NSString *billLevel_ID_string;
@property(nonatomic,strong)NSString *billinglevel_ID_string;
@property(nonatomic,strong)NSString *cancelDate_string;
@property(nonatomic,strong)NSString *_string;

@property(nonatomic,strong) NSMutableDictionary *weekDays_dictionary;
@end
