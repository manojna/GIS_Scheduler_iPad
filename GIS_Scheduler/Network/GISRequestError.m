//
//  GISRequestError.m
//  Gallaudet-Interpreting-Service
//
//Created by Paradigm on 02/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISRequestError.h"
#import "GISRequest.h"

#define kGISRequestErrorDomain @"GISRequestErrorDomain"

@implementation GISRequestError

@synthesize request;

- (id)initWithRequest:(GISRequest *)aRequest errorCode:(NSInteger)code andMessage:(NSString *)message
{
    NSDictionary *info = [[NSDictionary alloc] initWithObjectsAndKeys:message, @"NSLocalizedDescriptionKey", nil];
    self = [super initWithDomain:kGISRequestErrorDomain code:code userInfo:info];
    //[info release];
    if (self)
    {
        request = aRequest;//[aRequest retain];
    }
    
    return self;
}

- (void)dealloc
{
    //[request release];
    [super dealloc];
}

- (NSInteger)responseCode
{
    return request.responseCode;
}

@end