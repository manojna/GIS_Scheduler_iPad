//
//  PCDebug.h
//
//  Created by Paradigm Creatives on 2.11.12.
//  Copyright (c) 2011 Paradigm Creatives Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    PCLogLevelNone  = 0,
    PCLogLevelCrit  = 1,
    PCLogLevelError = 2,
    PCLogLevelWarn  = 3,
    PCLogLevelInfo  = 4,
    PCLogLevelDebug = 5
} PCLogLevel;


void PCLogSetLogLevel(PCLogLevel level);

void _PCLogCrit(NSString *format, ...);
void _PCLogError(NSString *format, ...);
void _PCLogWarn(NSString *format, ...);
void _PCLogInfo(NSString *format, ...);
void _PCLogDebug(NSString *format, ...);

void _PCAssert(const char* expression, const char* file, int line, const char* function);
void _PCAssertMsg(const char* expression, const char* file, int line, const char* function, NSString *message);
void _PCAssertMsgv(const char* expression, const char* file, int line, const char* function, NSString *format, ...);

#ifndef PCLogCrit
#define PCLogCrit(...) _PCLogCrit(__VA_ARGS__)
#endif

#ifndef PCLogError
#define PCLogError(...) _PCLogError(__VA_ARGS__)
#endif

#ifndef PCLogWarn
#define PCLogWarn(...) _PCLogWarn(__VA_ARGS__)
#endif

#ifndef PCLogInfo
#define PCLogInfo(...) _PCLogInfo(__VA_ARGS__)
#endif

#ifndef PCLogDebug
#define PCLogDebug(...) _PCLogDebug(__VA_ARGS__)
#endif

#define PCAssert(expression) if (!(expression)) _PCAssert(#expression, __FILE__, __LINE__, __FUNCTION__)    
#define PCAssertMsg(expression, msg) if (!(expression)) _PCAssertMsg(#expression, __FILE__, __LINE__, __FUNCTION__, (msg))
#define PCAssertMsgv(expression, msg, ...) if (!(expression)) _PCAssertMsgv(#expression, __FILE__, __LINE__, __FUNCTION__, (msg), __VA_ARGS__)


