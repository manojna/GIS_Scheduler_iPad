//
//  GISRequestError.h
//  Gallaudet-Interpreting-Service
//
//Created by Paradigm on 02/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    GISRequestErrorCodeUnexpectedHttpCode = -1000,
    GISRequestErrorCodeJSonParserFailed = -2000,
    GISRequestErrorCodeConnectionError = -3000,
} GISRequestErrorCode;

@class GISRequest;

@interface GISRequestError : NSError
{
    GISRequest *request;
}

@property (nonatomic, readonly) NSInteger responseCode;
@property (nonatomic, readonly) GISRequest *request;

- (id)initWithRequest:(GISRequest *)request errorCode:(NSInteger)code andMessage:(NSString *)message;

@end
