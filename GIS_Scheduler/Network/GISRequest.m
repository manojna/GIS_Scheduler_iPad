//
//  GISRequest.m
//  Gallaudet-Interpreting-Service
//
//Created by Paradigm on 02/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISRequest.h"
#import "GISServerManager.h"
#import "JSON.h"
#import <unistd.h>
#import <objc/message.h>

#define kGISRequestDefaultTimeout 80.0
#define kGISPostRequest @"POST"
#define kGISGetRequest @"GET"

#define kSuccessCodeMin 200
#define kSuccessCodeMax 226
#define kFailureCodeMin 400
#define kFailureCodeMax 404
#define kBusyCodeMin 500
#define kBusyCodeMax 504

#define kErrorMessageKey @"error"
#define kErrorCodeKey @"type"

@interface GISRequest (Private)

- (void)startDelayed;
- (NSMutableURLRequest *)createPostRequest;
- (NSMutableURLRequest *)createGetRequest;
- (void)generateErrorFromResponse;

@end

@implementation GISRequest

@synthesize urlString;
@synthesize params;
@synthesize timeout;
@synthesize connection;
@synthesize responseCode;
@synthesize responseData;

static NSString * URLEncodedStringFromString(NSString *string);

- (id)initWithURL:(NSString *)aUrlString
{
    return [self initWithURL:aUrlString andTimeout:kGISRequestDefaultTimeout];
}

- (id)initWithURL:(NSString *)aUrlString andTimeout:(NSTimeInterval)aTimeout
{
    return [self initWithURL:aUrlString andTimeout:aTimeout andParams:nil];
}

- (id)initWithURL:(NSString *)aUrlString andParams:(NSDictionary *)aParams
{
    return [self initWithURL:aUrlString andTimeout:kGISRequestDefaultTimeout andParams:aParams];
}

- (id)initWithURL:(NSString *)aUrlString andTimeout:(NSTimeInterval)aTimeout andParams:(NSDictionary *)aParams
{
    self = [super init];
    if (self) {
        state = GISRequestStateNotStarted;
        
        NSMutableDictionary *mutableParams = [[NSMutableDictionary alloc] initWithDictionary:aParams];
        self.params = mutableParams;
        //[mutableParams release];
        
        self.urlString = aUrlString;
        timeout = aTimeout;
    }
    return self;
}

- (void)setParam:(id)param forKey:(id)key
{
    if ((params != nil) && (param != nil)) {
        [params setObject:param forKey:key];
    }
}

- (void)dealloc
{
    self.urlString = nil;
    self.params = nil;
    self.connection = nil;
    self.responseData = nil;
    
    //[super dealloc];
}

- (NSMutableURLRequest *)createRequest
{
    if ([method isEqualToString:kGISPostRequest]) {
        return [self createPostRequest];
    }
    
    return [self createGetRequest];
}

- (NSMutableURLRequest *)createPostRequest
{
    NSURL *url = [[NSURL alloc] initWithString:self.urlString];
       NSLog(@"request url : %@", self.urlString);
        NSLog(@"params : %@", params);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                    ];
    
    NSString *jsonBody = [params JSONRepresentation];
    
    
    
    NSLog(@"the jsonBody is:%@",jsonBody);
    NSData *jsonData = [jsonBody dataUsingEncoding: NSASCIIStringEncoding];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:method];
    [request setHTTPBody:jsonData];
    //[url release];
    return request;
}

- (NSMutableURLRequest *)createGetRequest
{
    NSMutableString *urlBuffer = [[NSMutableString alloc] initWithString:self.urlString];
    if ([params count] > 0)
    {
        [urlBuffer appendString:@"?"];
        
        int paramIndex = 0;
        for (id paramName in params)
        {
            id paramValue = [params objectForKey:paramName];
            if (paramIndex > 0)
            {
                [urlBuffer appendString:@"&"];
            }
            paramIndex++;
            
            [urlBuffer appendFormat:@"%@=%@", URLEncodedStringFromString([paramName description]),
             URLEncodedStringFromString([paramValue description])];
        }
    }
    
    NSURL *url = [[NSURL alloc] initWithString:[urlBuffer stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    //    NSLog(@"request url : %@", url);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:timeout];
    //[url release];
    //[urlBuffer release];
    return request;
}

- (void)startDelayed
{
    @synchronized (self)
    {
        state = GISRequestStateStarted;
        NSURLRequest *request = [self createRequest];
        NSURLConnection *aConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        if (aConnection != nil)
        {
            self.connection = aConnection;
            self.responseData = [NSMutableData data];
            [[GISServerManager sharedManager] queueRequest:self];
        }
        else
        {
            [self finishWithErrorMessage:@"Can't create connection" andErrorCode:GISRequestErrorCodeConnectionError];
        }
        //[aConnection release];
    }
}

- (BOOL)hasValidResponse
{
    if (((responseCode <= kSuccessCodeMax && responseCode >= kSuccessCodeMin) || (responseCode <= kFailureCodeMax && responseCode >= kFailureCodeMin) || (responseCode <= kBusyCodeMax && responseCode >= kBusyCodeMin)) && (![responseData isEqualToData:[NSMutableData data]])) {
        return true;
    }
    
    return false;
}

- (void)generateErrorFromResponse
{
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding: NSUTF8StringEncoding];
    NSLog(@"error response string : %@, response code : %d", responseString, responseCode);
    if (responseString == nil || [responseString isKindOfClass:[NSNull class]])
    {
        [self finishWithErrorMessage:@"Can't create connection" andErrorCode:GISRequestErrorCodeConnectionError];
    }
    else
    {
        id errorJson = [responseString JSONValue];
        NSLog(@"response : %@", errorJson);
        if (errorJson == nil || [errorJson isKindOfClass:[NSNull class]]) {
            [self finishWithErrorMessage:@"Can't create connection" andErrorCode:GISRequestErrorCodeConnectionError];
        } else {
            NSString *message = [NSString stringWithString:[errorJson objectForKey:kErrorMessageKey]];
            int errorCode = [[errorJson objectForKey:kErrorCodeKey] intValue];
            [self finishWithErrorMessage:message andErrorCode:errorCode];
        }
    }
    //[responseString release];
}

- (void)start
{
    [self performSelectorOnMainThread:@selector(startDelayed) withObject:nil waitUntilDone:YES];
}

- (void)cancel
{
    @synchronized(self)
    {
        if (state == GISRequestStateFinished)
        {
            [NSObject cancelPreviousPerformRequestsWithTarget:_finishTarget selector:_finishAction object:nil];
        }
        else if (state == GISRequestStateFinishedError)
        {
            [NSObject cancelPreviousPerformRequestsWithTarget:_errorTarget selector:_errorAction object:nil];
        }
        else if (state == GISRequestStateStarted)
        {
            [self cancelConnection];
        }
        state = GISRequestStateCanceled;
        [[GISServerManager sharedManager] removeRequest:self];
    }
}

- (void)finish
{
    @synchronized(self)
    {
        if (![self isCanceled])
        {
            [self notifyFinishTarget];
        }
        [self releaseConnection];
    }
    
    [[GISServerManager sharedManager] removeRequest:self];
}

- (void)finishWithError:(NSError *)error
{
    @synchronized(self)
    {
        if (![self isCanceled])
        {
            [self notifyErrorTarget:error];
        }
        [self releaseConnection];
    }
    
    [[GISServerManager sharedManager] removeRequest:self];
}

- (void)finishWithErrorMessage:(NSString *)message andErrorCode:(NSInteger)code
{
    NSError *error = [[GISRequestError alloc] initWithRequest:self errorCode:code andMessage:message];
    [self finishWithError:error];
    //[error release];
}

//- (void)notifyFinishTarget
//{
//    objc_msgSend(_finishTarget, _finishAction, self);
//    //[finishTarget performSelector:finishAction withObject:self];
//}
//
//- (void)notifyErrorTarget:(NSError *)error
//{
//    
//    //[errorTarget performSelector:errorAction withObject:self withObject:error];
//    objc_msgSend(_startTarget, _startAction, self);
//}
//
//- (void)notifyCancelTarget
//{
//    [cancelTarget performSelector:cancelAction withObject:self];
//}



- (void)notifyFinishTarget
{
    //    [finishTarget performSelector:finishAction withObject:self];
    objc_msgSend(_finishTarget, _finishAction, self);
    
}

- (void)notifyStartTarget
{
    objc_msgSend(_startTarget, _startAction, self);
}


//- (void)notifyProgressTarget
//{
//    objc_msgSend(_progressTarget, _progressAction, self);
//}

- (void)notifyErrorTarget:(NSError *)anError
{
    //    [errorTarget performSelector:errorAction withObject:self withObject:anError];
    objc_msgSend(_errorTarget, _errorAction, anError);
}

- (void)notifyCancelTarget
{
    //    [cancelTarget performSelector:cancelAction withObject:self];
    objc_msgSend(_cancelTarget, _cancelAction, self);
    
}


- (BOOL)isCanceled
{
    return state == GISRequestStateCanceled;
}

- (void)setMethodGet
{
    method = kGISGetRequest;
}

- (void)setMethodPost
{
    method = kGISPostRequest;
}

- (void)setFinishTarget:(id)target andAction:(SEL)action
{
    _finishTarget = target;//[target retain];
    _finishAction = action;
}

- (void)setErrorTarget:(id)target andAction:(SEL)action
{
    _errorTarget = target;//[target retain];
    _errorAction = action;
}

- (void)setCancelTarget:(id)target andAction:(SEL)action
{
    _cancelTarget = target;//[target retain];
    _cancelAction = action;
}

#pragma mark -
#pragma mark Connection

- (void)releaseConnection
{
    @synchronized(self)
    {
        [self.connection cancel];
        
        self.connection = nil;
        self.responseData = nil;
    }
}

- (void)cancelConnection
{
    @synchronized (self)
    {
        [self.connection cancel];
        [self notifyCancelTarget];
    }
}

#pragma mark -
#pragma mark NSURLConnectionDelegate Methods

- (void) connection: (NSURLConnection*) connection didReceiveResponse: (NSURLResponse*) response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    responseCode = httpResponse.statusCode;
    NSLog(@"Response code : %d", responseCode);
    
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self releaseConnection];
    [self finishWithError:error];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if ([self hasValidResponse]) {
        [self finish];
        [self releaseConnection];
    } else {
        [self generateErrorFromResponse];
        [self releaseConnection];
    }
}

#pragma mark -
#pragma mark Helpers

static NSString * URLEncodedStringFromString(NSString *string)
{
    static NSString * const kAFLegalCharactersToBeEscaped = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\|~ ";
    
	return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, (CFStringRef)kAFLegalCharactersToBeEscaped, CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));//autorelease
}

@end
