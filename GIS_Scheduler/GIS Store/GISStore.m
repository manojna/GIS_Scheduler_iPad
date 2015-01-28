//
//  GISStore.m
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 05/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISStore.h"
#import "GISStoreManager.h"
@interface GISStore ()
- (void)parseStoreObjectsFromResponse:(NSDictionary *)dictionary;

@end


@implementation GISStore
@synthesize loginObject;

- (id)initWithJsonDictionary:(NSDictionary *)json
{
    if (self = [super init]) {
        NSLog(@"%s: %@",__FUNCTION__, json);
        [self parseStoreObjectsFromResponse:json];
    }
    return self;
}


- (void)parseStoreObjectsFromResponse:(NSDictionary *)dictionary
{
    @try {
        [[GISStoreManager sharedManager] removeLoginObjects];
        
        id json =dictionary;
        
        if ([json isKindOfClass:[NSDictionary class]]) {
            loginObject = [[GISLoginDetailsObject alloc] initWithStoreDictionary:(NSDictionary *)json];
            if([[GISStoreManager sharedManager] addLoginObject:loginObject]) NSLog(@"Login object added successfully");
            else NSLog(@"Failed to add login object");
            
        } else if ([json isKindOfClass:[NSArray class]]) {
            for (id jsonObject in (NSArray*)json) {
                loginObject = [[GISLoginDetailsObject alloc]initWithStoreDictionary:(NSDictionary *)jsonObject];
                if([[GISStoreManager sharedManager] addLoginObject:loginObject]) NSLog(@"Login object added successfully");
                else NSLog(@"Failed to add login object");
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"EXCEPTION raised, reason was: %@", [exception reason]);
    }
    
}
@end
