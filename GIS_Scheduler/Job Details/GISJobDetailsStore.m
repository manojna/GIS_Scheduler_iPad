//
//  GISJobDetailsStore.m
//  GIS_Scheduler
//
//  Created by Paradigm on 19/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISJobDetailsStore.h"
#import "GISStoreManager.h"

@implementation GISJobDetailsStore

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
            
        }
        else if([json isKindOfClass:[NSArray class]])
        {
            for (id jsonObj in (NSArray *)json) {
                GISJobDetailsObject *jobDetailsObjs=[[GISJobDetailsObject alloc] init];
                jobDetailsObj=[jobDetailsObjs initializeJObDetailsValues:jsonObj];
                [[GISStoreManager sharedManager]addJobDetailsObject:jobDetailsObj];
                
            }
        }
    }
    @catch (NSException *exception) {
        
    }
    
}





@end
