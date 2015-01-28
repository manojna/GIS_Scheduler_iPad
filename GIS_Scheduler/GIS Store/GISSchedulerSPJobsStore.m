//
//  GISSchedulerSPJobsStore.m
//  GIS_Scheduler
//
//  Created by Anand on 01/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISSchedulerSPJobsStore.h"
#import "GISStoreManager.h"

@interface GISSchedulerSPJobsStore ()
- (void)parseContactsInfoObjectsFromResponse:(NSDictionary *)dictionary;
@end

@implementation GISSchedulerSPJobsStore

@synthesize spJobsObject;

- (id)initWithJsonDictionary:(NSDictionary *)json
{
    if (self = [super init]) {
        NSLog(@"%s: %@",__FUNCTION__, json);
        [self parseContactsInfoObjectsFromResponse:json];
    }
    return self;
}


- (void)parseContactsInfoObjectsFromResponse:(NSDictionary *)dictionary
{
    @try {
        [[GISStoreManager sharedManager] removeContactsInfoObjects];
        
        id json =dictionary;
        
        if ([json isKindOfClass:[NSDictionary class]]) {
            spJobsObject = [[GISSchedulerSPJobsObject alloc] initWithStoreDictionary:(NSDictionary *)json];
            [[GISStoreManager sharedManager] addRequestJobs_SPJobsObject:spJobsObject];
        } else if ([json isKindOfClass:[NSArray class]]) {
            for (id jsonObject in (NSArray*)json) {
                spJobsObject = [[GISSchedulerSPJobsObject alloc] initWithStoreDictionary:(NSDictionary *)jsonObject];
                [[GISStoreManager sharedManager] addRequestJobs_SPJobsObject:spJobsObject];
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"EXCEPTION raised, reason was: %@", [exception reason]);
    }
    
}


@end
