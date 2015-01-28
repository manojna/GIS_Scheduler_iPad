//
//  GISBuildingObject.m
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 15/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISBilingDataObject.h"
#import "GISJSONProperties.h"
#import "GISStoreManager.h"

@implementation GISBilingDataObject

@synthesize department_String;
@synthesize buh_firstName_String;
@synthesize buh_lastName_String;
@synthesize buh_email_String;
@synthesize buh_address1_String;
@synthesize buh_address2_String;
@synthesize buh_city_String;
@synthesize buh_state_String;
@synthesize buh_zip_String;

- (id)initWithStoreBillingDataDictionary:(NSDictionary *)json
{
    if (self = [super init]) {
        
        @try {
            
            
            if ([json isKindOfClass:[NSDictionary class]]) {
            }
            else if ([json isKindOfClass:[NSArray class]]) {
                NSArray *array=(NSArray *)json;
                NSDictionary *dict=[array lastObject];
                buh_address1_String = [dict objectForKey:kBillingData_BUHAddress1];
                buh_address2_String = [dict objectForKey:kBillingData_BUHAddress2];
                buh_city_String = [dict objectForKey:kBillingData_BUHCity];
                buh_email_String = [dict objectForKey:kBillingData_BUHEmail];
                buh_firstName_String = [dict objectForKey:kBillingData_BUHFirstName];
                buh_lastName_String = [dict objectForKey:kBillingData_BUHLastName];
                buh_state_String = [dict objectForKey:kBillingData_BUHState];
                buh_zip_String = [dict objectForKey:kBillingData_BUHZip];
                department_String = [dict objectForKey:kBillingData_Department];
                }
            
            
            
        }
        @catch (NSException *exception) {
            NSLog(@"EXCEPTION raised, reason was: %@", [exception reason]);
        }
    }
    return self;
}

@end
