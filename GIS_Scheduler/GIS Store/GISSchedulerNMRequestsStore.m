//
//  GISSchedulerNMRequestsStore.m
//  GIS_Scheduler
//
//  Created by Anand on 01/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISSchedulerNMRequestsStore.h"
#import "GISStoreManager.h"

@implementation GISSchedulerNMRequestsStore

@synthesize NMRequestsObject;

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
            NMRequestsObject = [[GISSchedulerNMRequestsObject alloc] initWithStoreDictionary:(NSDictionary *)json];
            [[GISStoreManager sharedManager] addRequests_NMRequestObject:NMRequestsObject];
        } else if ([json isKindOfClass:[NSArray class]]) {
            for (id jsonObject in (NSArray*)json) {
                NMRequestsObject = [[GISSchedulerNMRequestsObject alloc] initWithStoreDictionary:(NSDictionary *)jsonObject];
                [[GISStoreManager sharedManager] addRequests_NMRequestObject:NMRequestsObject];
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"EXCEPTION raised, reason was: %@", [exception reason]);
    }
    
}


@end
