//
//  PCDebug.h
//
//  Created by Paradigm Creatives on 2.11.12.
//  Copyright (c) 2011 Paradigm Creatives Pvt. Ltd. All rights reserved.
//

#import "PCDebug.h"

#define kButtonTitleContinue    @"Continue"
#define kButtonTitleAbort       @"Abort"

#ifdef ASSERTS

BOOL blockingAlertActive;

@interface AlertViewDelegate : NSObject<UIActionSheetDelegate>
{
	NSString* alertMessage;
}

- (id)initWithExpression:(const char*)expression andMessage:(NSString*)message inFile:(const char*) file andLine:(int)line inFunction:(const char*)function;
- (void)show;

@end

@implementation AlertViewDelegate

- (void)actionSheet:(UIActionSheet*)view didDismissWithButtonIndex:(NSInteger) buttonIndex
{
    NSString *buttonTitle = [view buttonTitleAtIndex:buttonIndex];
    NSLog(@"Assertion notification: '%@'", buttonTitle);
    if ([buttonTitle isEqualToString:kButtonTitleAbort])
    {     
        abort();
    }
    
    blockingAlertActive = NO;
}

- (void) actionSheetCancel:(UIActionSheet*)view
{
    blockingAlertActive = NO;
}

- (id)initWithExpression:(const char *)expression andMessage:(NSString *)message inFile:(const char *)file andLine:(int)line inFunction:(const char *)function
{
    self = [super init];
    if (self)
    {     
        alertMessage = [[NSString alloc] initWithFormat:@"Assertion: (%s)\n with message: %@\n fails in:%s\nin file: %s:%d", expression, message, function, file, line];
    }
	return self;
}

- (void)dealloc
{
    [alertMessage release];
    [super dealloc];
}

- (void) show
{
	UIActionSheet* view = [[UIActionSheet alloc] initWithTitle:alertMessage
                                                      delegate:self 
											 cancelButtonTitle:nil 
                                        destructiveButtonTitle:kButtonTitleAbort 
                                             otherButtonTitles:nil];
    [view addButtonWithTitle:kButtonTitleContinue];
	UIView* parentView = [UIApplication sharedApplication].keyWindow;
	[view showInView:parentView];
	[view release];
}

@end

#endif // #ifdef PC_ASSERTS

void _PCLog(NSString *format, va_list args);

static PCLogLevel g_PCLogLevel = PCLogLevelWarn;

void PCLogSetLogLevel(PCLogLevel level) {
#ifdef DEBUG
    g_PCLogLevel = level;
#endif
}

void _PCLogCrit(NSString *format, ...) {
#ifdef DEBUG
    if (g_PCLogLevel < PCLogLevelCrit) return;
    va_list ap;
    va_start(ap, format);
    NSString *fmt = [[NSString alloc] initWithFormat:@"PCLog/C: %@", format];
    _PCLog(fmt, ap);
    [fmt release];
    va_end(ap);
#endif
}

void _PCLogError(NSString *format, ...) {
#ifdef DEBUG
    if (g_PCLogLevel < PCLogLevelError) return;
    va_list ap;
    va_start(ap, format);
    NSString *fmt = [[NSString alloc] initWithFormat:@"PCLog/E: %@", format];
    _PCLog(fmt, ap);
    [fmt release];
    va_end(ap);
#endif
}

void _PCLogWarn(NSString *format, ...) {
#ifdef DEBUG
    if (g_PCLogLevel < PCLogLevelWarn) return;
    va_list ap;
    va_start(ap, format);
    NSString *fmt = [[NSString alloc] initWithFormat:@"PCLog/W: %@", format];
    _PCLog(fmt, ap);
    [fmt release];
    va_end(ap);
#endif
}

void _PCLogInfo(NSString *format, ...) {
#ifdef DEBUG
    if (g_PCLogLevel < PCLogLevelInfo) return;
    va_list ap;
    va_start(ap, format);
    NSString *fmt = [[NSString alloc] initWithFormat:@"PCLog/I: %@", format];
    _PCLog(fmt, ap);
    [fmt release];
    va_end(ap);
#endif
}

void _PCLogDebug(NSString *format, ...) {
#ifdef DEBUG
    if (g_PCLogLevel < PCLogLevelDebug) return;
    va_list ap;
    va_start(ap, format);
    NSString *fmt = [[NSString alloc] initWithFormat:@"PCLog/D: %@", format];
    _PCLog(fmt, ap);
    [fmt release];
    va_end(ap);
#endif
}

void _PCLog(NSString *format, va_list args)
{
    NSLogv(format, args);
}

const char * __shorten_path(const char * path);

void _PCAssert(const char* expression, const char* file, int line, const char* function)
{
#ifdef DEBUG
    _PCAssertMsg(expression, file, line, function, @"");
#endif
}

void _PCAssertMsg(const char* expression, const char* file, int line, const char* function, NSString *message)
{
#ifdef DEBUG
    _PCAssertMsgv(expression, file, line, function, message);
#endif
}

void _PCAssertMsgv(const char* expression, const char* file, int line, const char* function, NSString *format, ...)
{
#ifdef DEBUG
    file = __shorten_path(file);
    
    va_list ap;
    va_start(ap, format);    
    NSString *message = [[NSString alloc] initWithFormat:format arguments:ap];    
    NSString *consoleMessage = [[NSString alloc] initWithFormat:@"PCLog/ASSERT: (%s) in %s:%d %s message:'%@'", expression, file, line, function, message];
    //NSLog(@"%@", consoleMessage);
    [consoleMessage release];
    [message release];
    va_end(ap);
    
#ifdef ASSERTS
    AlertViewDelegate* alertDelegate = [[AlertViewDelegate alloc] initWithExpression:expression andMessage:message inFile:file andLine:line inFunction:function];
    [alertDelegate show];
    [message release];
    
    blockingAlertActive = TRUE;    
	while (blockingAlertActive)
	{
		while(CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0, TRUE) == kCFRunLoopRunHandledSource);
	}
#endif
#endif
}

const char * __shorten_path(const char * path)
{
	const char *to_return = path;
	const char *p = path; while (*p) ++p;
	while (p >= path)
	{
		--p;
		if (*p == '/')
        {
			to_return = p+1;
            break;
        }
	}
	
	return to_return;
}

