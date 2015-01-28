//
//  GISDropDownsObject.m
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 14/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISDropDownsObject.h"
#import "GISJSONProperties.h"
//#import "GISStoreManager.h"
@interface GISDropDownsObject ()
//- (void)parseDropDownsDetailsWithDict:(NSDictionary *)dictionary;
@end

@implementation GISDropDownsObject
//@synthesize buildingNamesObject,dressCodeObject,locationCodeObject,eventTypeObject,unitOrDepartmentObject;

@synthesize id_String;
@synthesize type_String;
@synthesize value_String;


//@synthesize dropDownStore;


- (id)initWithStoreDictionary:(NSDictionary *)json
{
    if (self = [super init]) {
        
        @try {
            
            id_String = [json objectForKey:kDropDownID] ;
            if(id_String == NULL)
            {
                id_String = @" ";
            }else{
                 id_String = [json objectForKey:kDropDownID] ;
                id_String = [json objectForKey:kDropDownID];//[[json objectForKey:kDropDownID] stringValue];
            }
                
            type_String = [json objectForKey:kDropDownType] == [NSNull null]?@" ":[NSString stringWithString:[json objectForKey:kDropDownType]];
            value_String = [json objectForKey:kDropDownValue] == [NSNull null]?@" ":[NSString stringWithString:[json objectForKey:kDropDownValue]];
        }
        @catch (NSException *exception) {
            NSLog(@"EXCEPTION raised, reason was: %@", [exception reason]);
        }
    }
    return self;
}


@end
