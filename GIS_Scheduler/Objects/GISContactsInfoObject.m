//
//  GISContactsInfoObject.m
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 16/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISContactsInfoObject.h"
#import "GISJSONProperties.h"
@implementation GISContactsInfoObject

@synthesize contactInfoId_String;
@synthesize contactNo_String;
@synthesize contactType_String;
@synthesize contactTypeId_String;
@synthesize contactTypeNo_String;

- (id)initWithStoreDictionary:(NSDictionary *)json
{
    if (self = [super init]) {
        
        @try {
            contactInfoId_String =[json objectForKey:kGetContactInfoId];// [[json objectForKey:kGetContactInfoId] stringValue];
            if(contactInfoId_String == NULL)
            {
                contactInfoId_String = @" ";
            }else{
                contactInfoId_String =[json objectForKey:kGetContactInfoId];// [[json objectForKey:kGetContactInfoId] stringValue];
            }
            
           // contactInfoId_String = [json objectForKey:kGetContactInfoId] == NULL?@" ":[NSString stringWithString:[json objectForKey:kGetContactInfoId]];
            contactNo_String = [self returningstring:[json objectForKey:kGetContactNo]];// == NULL?@" ":[NSString stringWithString:[json objectForKey:kGetContactNo]];
            contactType_String = [self returningstring:[json objectForKey:kGetContactType]];// == [NSNull null]?@" ":[NSString stringWithString:[json objectForKey:kGetContactType]];
            contactTypeId_String = [self returningstring:[json objectForKey:kGetContactTypeId]];// == [NSNull null]?@" ":[NSString stringWithString:[json objectForKey:kGetContactTypeId]];
            contactTypeNo_String = [self returningstring:[json objectForKey:kGetContactTypeNo]];// == [NSNull null]?@" ":[NSString stringWithString:[json objectForKey:kGetContactTypeNo]];
        }
        @catch (NSException *exception) {
            NSLog(@"EXCEPTION raised, reason was: %@", [exception reason]);
        }
    }
    return self;
}


-(NSString *)returningstring:(id)string
{
    if ([string isKindOfClass:[NSNull class]])
    {
        return @" ";
    }
    else
    {
        if (![string isKindOfClass:[NSString class]])
        {
            NSString *str= [string stringValue];
            return str;
        }
        else
        {
            return string;
        }
    }
    
}
@end
