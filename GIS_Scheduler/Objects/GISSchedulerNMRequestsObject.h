//
//  GISSchedulerNMRequestsObject.h
//  GIS_Scheduler
//
//  Created by Anand on 01/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GISSchedulerNMRequestsObject : NSObject

@property(nonatomic,strong)NSString *AccountName_String;
@property(nonatomic,strong)NSString *ApprovalDate_String;
@property(nonatomic,strong)NSString *ApproveddBy_String;
@property(nonatomic,strong)NSString *DateofEarlierAssigment_String;
@property(nonatomic,strong)NSString *EarliestDate_String;
@property(nonatomic,strong)NSString *EventType_String;
@property(nonatomic,strong)NSString *OtherServices_String;
@property(nonatomic,strong)NSString *RequestID_String;
@property(nonatomic,strong)NSString *RequestStatus_String;
@property(nonatomic,strong)NSString *RequestSubmissionDate_String;
@property(nonatomic,strong)NSString *Shceduler_String;
@property(nonatomic,strong)NSString *Tab_String;

- (id)initWithStoreDictionary:(NSDictionary *)json;

@end
