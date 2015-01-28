//
//  GISJobDetailsObject.h
//  GIS_Scheduler
//
//  Created by Paradigm on 19/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GISJobDetailsObject : NSObject

@property(nonatomic,strong)NSString *billAmount_string;
@property(nonatomic,strong)NSString *endTime_string;
@property(nonatomic,strong)NSString *jobDate_string;
@property(nonatomic,strong)NSString *jobID_string;
@property(nonatomic,strong)NSString *jobNumber_string;
@property(nonatomic,strong)NSString *payType_string;
@property(nonatomic,strong)NSString *serviceProvider_string;
@property(nonatomic,strong)NSString *startTime_string;
@property(nonatomic,strong)NSString *status_string;
@property(nonatomic,strong)NSString *statusCode_string;
@property(nonatomic,strong)NSString *timely_string;
@property(nonatomic,strong)NSString *typeOfService_string;
@property(nonatomic,strong)NSString *slots_string;
@property(nonatomic,readwrite)BOOL isEdit_Bool;

-(GISJobDetailsObject *)initializeJObDetailsValues:(NSDictionary *)dict;
@end
