//
//  GISSchedulerSPJobsObject.h
//  GIS_Scheduler
//
//  Created by Anand on 01/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GISSchedulerSPJobsObject : NSObject
@property(nonatomic,strong) NSString *accountName_string;
@property(nonatomic,strong) NSString *billAmount_string;
@property(nonatomic,strong) NSString *outToAgency_string;
@property(nonatomic,strong) NSString *location_string;
@property(nonatomic,strong) NSString *requestorName_string;
@property(nonatomic,strong) NSString *subRoll_string;
@property(nonatomic,strong) NSString *timely_string;
@property(nonatomic,strong) NSString *typeOfService_string;
@property(nonatomic,strong) NSString *requestApproved_string;


@property(nonatomic,strong)NSString *EventType_String;
@property(nonatomic,strong)NSString *endTime_String;
@property(nonatomic,strong)NSString *ServiceProviderName_String;
@property(nonatomic,strong)NSString *RequestedDate_String;
@property(nonatomic,strong)NSString *JobID_String;
@property(nonatomic,strong)NSString *JobNumber_String;
@property(nonatomic,strong)NSString *JobDate_String;
@property(nonatomic,strong)NSString *PayType_String;
@property(nonatomic,strong)NSString *PayType_id_String;
@property(nonatomic,strong)NSString *startTime_String;
@property(nonatomic,strong)NSString *TotalHours_String;
@property(nonatomic,strong)NSString *GisResponse_String;
@property(nonatomic,strong)NSString *GisResponse_id_String;
@property(nonatomic,strong)NSString *SPRequestJobID_String;

@property(nonatomic,strong)NSString *filledOrUnfilled_string;


- (id)initWithStoreDictionary:(NSDictionary *)json;

@end
