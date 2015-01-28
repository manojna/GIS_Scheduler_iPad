//
//  PCLogger.h
//
//  Created by Paradigm Creatives on 15/09/11.
//  Copyright (c) 2011 Paradigm Creatives Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UncaughtExceptionHandler.h"

typedef enum {
    PC_LOG_INFO = 1,
    PC_LOG_WARN,
    PC_LOG_FATAL
}PCLogType;

@interface PCLogger : NSObject
{
    NSString *filePath;
}

+ (PCLogger *)sharedLogger;
- (void)logToSave:(NSString *)str ofType:(PCLogType)logType;
- (void)uploadFileToS3;
- (void)createNewLogFile;
- (NSString *)getUUID;

@end
