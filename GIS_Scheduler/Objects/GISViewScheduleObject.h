//
//  GISViewScheduleObject.h
//  Gallaudet-Interpreting-Service
//
//  Created by Anand on 10/06/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GISViewScheduleObject : NSObject

@property(nonatomic,strong)NSString *createdDate_String;
@property(nonatomic,strong)NSString *eventTitle_String;
@property(nonatomic,strong)NSString *requestId_String;
@property(nonatomic,strong)NSString *requestNumber_String;
@property(nonatomic,strong)NSString *requestStatus_String;
@property(nonatomic,strong)NSString *scheduler_String;
@property(nonatomic,strong)NSString *unitNoStatus_String;
@property(nonatomic,strong)NSString *requestColorName_String;
@property(nonatomic,strong)NSString *startTime_String;
@property(nonatomic,strong)NSString *endTime_String;


@property(nonatomic,strong)NSString *eventType_String;
@property(nonatomic,strong)NSString *jobdate_String;
@property(nonatomic,strong)NSString *jobID_String;
@property(nonatomic,strong)NSString *jobNumber_String;
@property(nonatomic,strong)NSString *state_String;
@property(nonatomic,strong)NSString *status_String;
@property(nonatomic,strong)NSString *statusCode_String;
@property(nonatomic,strong)NSString *generalLocation_String;
@property(nonatomic,strong)NSString *unAvailableID_String;

- (id)initWithStoreDictionary:(NSDictionary *)json;

@end
