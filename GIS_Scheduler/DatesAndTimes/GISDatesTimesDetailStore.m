//
//  GISDatesTimesDetailStore.m
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 30/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//


#import "GISDatesTimesDetailStore.h"
#import "GISStoreManager.h"
@implementation GISDatesTimesDetailStore
@synthesize dateTime_obj_here;

- (id)initWithStoreDictionary:(NSDictionary *)json
{
    if (self == [super init]) {
        NSLog(@"%s: %@",__FUNCTION__, json);
        [self parseContactsInfoObjectsFromResponse:json];
    }
    return self;
}

- (void)parseContactsInfoObjectsFromResponse:(NSDictionary *)dictionary
{
    @try {
        
        id json =dictionary;
        
        if ([json isKindOfClass:[NSDictionary class]]) {
            
            
        } else if ([json isKindOfClass:[NSArray class]]) {
            for (id jsonObject in (NSArray*)json) {
                dateTime_obj_here = [[GISDatesAndTimesObject alloc] initWithStoreDictionary:(NSDictionary *)jsonObject];
                [[GISStoreManager sharedManager] addDateTimes_detail_Object:dateTime_obj_here];
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"EXCEPTION raised, reason was: %@", [exception reason]);
    }
    
}

@end
