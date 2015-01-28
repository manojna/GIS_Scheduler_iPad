//
//  GISAttendeesDetailsStore.m
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 23/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISAttendeesDetailsStore.h"
#import "GISStoreManager.h"
@implementation GISAttendeesDetailsStore
@synthesize attendeesListObj_here;

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
                attendeesListObj_here = [[GISAttendees_ListObject alloc] initWithStoreDictionary:(NSDictionary *)jsonObject];
                [[GISStoreManager sharedManager] addAttendees_Details_Object:attendeesListObj_here];
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"EXCEPTION raised, reason was: %@", [exception reason]);
    }
    
}



@end
