//
//  GISContactsInfoStore.m
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 16/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISContactsInfoStore.h"
#import "GISStoreManager.h"

@interface GISContactsInfoStore ()
- (void)parseContactsInfoObjectsFromResponse:(NSDictionary *)dictionary;
@end

@implementation GISContactsInfoStore
@synthesize contactsObject;

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
            contactsObject = [[GISContactsInfoObject alloc] initWithStoreDictionary:(NSDictionary *)json];
            if([[GISStoreManager sharedManager] addContactsInfoObject:contactsObject]) NSLog(@"ContactsInfoObject object added successfully");
            else NSLog(@"Failed to add ContactsInfoObject object");
            
        } else if ([json isKindOfClass:[NSArray class]]) {
            for (id jsonObject in (NSArray*)json) {
                contactsObject = [[GISContactsInfoObject alloc] initWithStoreDictionary:(NSDictionary *)jsonObject];
                if([[GISStoreManager sharedManager] addContactsInfoObject:contactsObject]) NSLog(@"ContactsInfoObject object added successfully");
                else NSLog(@"Failed to add ContactsInfoObject object");
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"EXCEPTION raised, reason was: %@", [exception reason]);
    }
    
}

@end
