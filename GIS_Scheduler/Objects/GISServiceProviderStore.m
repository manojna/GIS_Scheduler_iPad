//
//  GISServiceProviderStore.m
//  GIS_Scheduler
//
//  Created by Anand on 19/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISServiceProviderStore.h"
#import "GISStoreManager.h"
#import "GISJSONProperties.h"

@implementation GISServiceProviderStore

-(id)initWithJsonDictionary:(NSDictionary *)response
{
    if (self==[super init]) {
        NSLog(@"----JobDetails json-->%@",response);
        [self parseJoDetails:response];
    }
    return self;
}

-(void)parseJoDetails:(NSDictionary *)json_here
{
    @try {
        id json=json_here;
        if ([json isKindOfClass:[NSDictionary class]]) {
            
            NSArray *jsonArray =    [json objectForKey:kServiceProviderResult];
            if([jsonArray count] == 0)
                jsonArray =    [json objectForKey:kViewScheduleServiceProviderResult];
            
            for (id jsonObj in jsonArray) {
                
                serviceProviderObj=[[GISServiceProviderObject alloc] init];
                serviceProviderObj=[serviceProviderObj initWithStoreDictionary :jsonObj];
                
                [[GISStoreManager sharedManager] addServiceProviderObject:serviceProviderObj];
                
            }
            
        }
        else if([json isKindOfClass:[NSArray class]])
        {
            for (id jsonObj in (NSArray *)json) {
                
                serviceProviderObj=[[GISServiceProviderObject alloc] init];
                serviceProviderObj=[serviceProviderObj initWithStoreDictionary :jsonObj];
                
                [[GISStoreManager sharedManager] addServiceProviderObject:serviceProviderObj];
                
            }
        }
    }
    @catch (NSException *exception) {
        
    }
    
}

@end
