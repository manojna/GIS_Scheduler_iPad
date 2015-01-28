//
//  GISSchedulerSPJobsStore.h
//  GIS_Scheduler
//
//  Created by Anand on 01/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GISSchedulerSPJobsObject.h"

@interface GISSchedulerSPJobsStore : NSObject

@property(nonatomic,strong)GISSchedulerSPJobsObject *spJobsObject;
- (id)initWithJsonDictionary:(NSDictionary *)json;

@end
