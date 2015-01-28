//
//  GISViewEditStore.m
//  GIS_Scheduler
//
//  Created by Anand on 16/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISViewEditStore.h"
#import "GISStoreManager.h"

@implementation GISViewEditStore

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
               
                viewEditObj=[[GISViewEditDateObject alloc] init];
                viewEditObj=[viewEditObj initWithStoreDictionary :jsonObj];
                
                [[GISStoreManager sharedManager]addViewEditObject:viewEditObj];
                
            }
        }
    }
    @catch (NSException *exception) {
        
    }
    
}

@end
