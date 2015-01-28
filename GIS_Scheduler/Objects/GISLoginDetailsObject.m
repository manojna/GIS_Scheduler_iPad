//
//  GISLoginDetails.m
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 05/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISLoginDetailsObject.h"
#import "GISJSONProperties.h"

@implementation GISLoginDetailsObject

@synthesize email_string;
@synthesize firstName_string;
@synthesize lastName_string;
@synthesize requestorID_string;
@synthesize token_string;
@synthesize userStatus_string;
@synthesize role_ID_string;
@synthesize roles_string;

- (id)initWithStoreDictionary:(NSDictionary *)dictionary
{
    if ([super init]) {
        @try {
            email_string=[dictionary objectForKey:kLoginEmail];
            firstName_string=[dictionary objectForKey:kLoginFirstName];
            lastName_string=[dictionary objectForKey:kLoginLastName];
            requestorID_string=[dictionary objectForKey:kLoginRequestorID];
            token_string=[dictionary objectForKey:kLoginToken];
            userStatus_string=[dictionary objectForKey:kLoginUserStatus];
            role_ID_string=[dictionary objectForKey:kLoginRoleId];
            roles_string=[dictionary objectForKey:kLoginRoles];
        }
        @catch (NSException *exception) {
        }
        return self;
    }
}
@end
