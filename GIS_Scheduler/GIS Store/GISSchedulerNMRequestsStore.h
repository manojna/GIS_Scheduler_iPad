//
//  GISSchedulerNMRequestsStore.h
//  GIS_Scheduler
//
//  Created by Anand on 01/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GISSchedulerNMRequestsObject.h"

@interface GISSchedulerNMRequestsStore : NSObject

@property(nonatomic,strong)GISSchedulerNMRequestsObject *NMRequestsObject;
- (id)initWithJsonDictionary:(NSDictionary *)json;

@end
