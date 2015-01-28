//
//  GISRequest.h
//  Gallaudet-Interpreting-Service
//
//Created by Paradigm on 02/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GISRequestError.h"

typedef enum {
	GISRequestStateNotStarted,
	GISRequestStateStarted,
	GISRequestStateFinished,
	GISRequestStateFinishedError,
    GISRequestStateCanceled
} GISRequestState;

@interface GISRequest : NSObject <NSURLConnectionDelegate>
{
@protected
    NSString *urlString;
    NSMutableDictionary *params;
    NSString *method;
    
    NSTimeInterval timeout;
    NSURLConnection *urlConnection;
    NSInteger responseCode;
    NSMutableData *responseData;
    
    GISRequestState state;
    
//    id finishTarget;
//    SEL finishAction;
//    
//    id errorTarget;
//    SEL errorAction;
//    
//    id cancelTarget;
//    SEL cancelAction;
}

@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, retain) NSDictionary *params;
@property (nonatomic, readonly) NSTimeInterval timeout;
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, readonly) NSInteger responseCode;
@property (nonatomic, retain) NSMutableData *responseData;

@property (nonatomic, assign) SEL finishAction;
@property (nonatomic, strong) id finishTarget;

@property (nonatomic, assign) SEL errorAction;
@property (nonatomic, strong) id errorTarget;

@property (nonatomic, assign) SEL cancelAction;
@property (nonatomic, strong) id cancelTarget;

//@property (nonatomic, assign) SEL progressAction;
//@property (nonatomic, strong) id progressTarget;

@property (nonatomic, assign) SEL startAction;
@property (nonatomic, strong) id startTarget;

- (id)initWithURL:(NSString *)urlString;
- (id)initWithURL:(NSString *)urlString andTimeout:(NSTimeInterval)timeout;
- (id)initWithURL:(NSString *)urlString andParams:(NSDictionary *)params;
- (id)initWithURL:(NSString *)urlString andTimeout:(NSTimeInterval)timeout andParams:(NSDictionary *)params;

- (void)setParam:(id)param forKey:(id)key;

- (void)start;
- (void)cancel;

- (void)setMethodPost;
- (void)setMethodGet;

- (void)setFinishTarget:(id)target andAction:(SEL)action;
- (void)setErrorTarget:(id)target andAction:(SEL)action;
- (void)setCancelTarget:(id)target andAction:(SEL)action;

- (NSMutableURLRequest *)createRequest;

- (void)releaseConnection;
- (void)cancelConnection;

- (void)finish;
- (void)finishWithError:(NSError *)error;
- (void)finishWithErrorMessage:(NSString *)message andErrorCode:(NSInteger)code;

- (BOOL)isCanceled;

- (void)notifyFinishTarget;
- (void)notifyErrorTarget:(NSError *)error;
- (void)notifyCancelTarget;

- (BOOL)hasValidResponse;

@end
