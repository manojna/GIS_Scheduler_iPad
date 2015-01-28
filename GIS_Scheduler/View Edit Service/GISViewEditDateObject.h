//
//  GISViewEditDateObject.h
//  GIS_Scheduler
//
//  Created by Anand on 16/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GISViewEditDateObject : NSObject

@property(nonatomic,strong)NSString *billAmount_String;
@property(nonatomic,strong)NSString *endTime_String;
@property(nonatomic,strong)NSString *jobDate_String;
@property(nonatomic,strong)NSString *jobId_String;
@property(nonatomic,strong)NSString *jobNumber_String;
@property(nonatomic,strong)NSString *patType_String;
@property(nonatomic,strong)NSString *serViceProvider_String;
@property(nonatomic,strong)NSString *startTime_String;
@property(nonatomic,strong)NSString *timely_String;
@property(nonatomic,strong)NSString *typeOfService_String;
@property(nonatomic,strong)NSString *subRole_String;
@property(nonatomic,strong)NSString *eventName_String;
@property(nonatomic,strong)NSString *requestApproved_String;

- (id)initWithStoreDictionary:(NSDictionary *)json;

@end
