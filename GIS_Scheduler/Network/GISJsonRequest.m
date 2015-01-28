//
//  GISJsonRequest.m
//  Gallaudet-Interpreting-Service
//
//Created by Paradigm on 02/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISJsonRequest.h"
#import "JSON.h"

@implementation GISJsonRequest
@synthesize responseJson;


- (void)dealloc
{
    self.responseJson = nil;
    [super dealloc];
}

- (void)finish
{
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding: NSUTF8StringEncoding];
    if (responseString == nil || [responseString isKindOfClass:[NSNull class]])
    {
        NSString *message = [[NSString alloc] initWithFormat:@"Unable to parse json"];
        [self finishWithErrorMessage:message andErrorCode:GISRequestErrorCodeJSonParserFailed];
        //[message release];
    }
    else
    {
        self.responseJson = [responseString JSONValue];
        [super finish];
    }
    //[responseString release];
}

- (void)releaseConnection
{
    [super releaseConnection];
    self.responseJson = nil;
}

@end
