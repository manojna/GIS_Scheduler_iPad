//
//  PCLogger.m
//
//  Created by Paradigm Creatives on 15/09/11.
//  Copyright (c) 2011 Paradigm Creatives Pvt. Ltd. All rights reserved.
//

#import "PCLogger.h"
#import "AmazonClientManager.h"
#import "PCDebug.h"

#include <sys/sysctl.h>
#include <sys/utsname.h>


#define kLogBucketName @"AmazonLogBucketName"
#define ACCESS_KEY     @"AKIAJ5E4ZRPJYFKHNGZA"
#define SECRET_KEY     @"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"

@interface PCLogger(Private)

- (NSString*)stringOfLogType:(PCLogType)type;
- (NSString *)getUUID;

@end

@implementation PCLogger

static PCLogger *manager = nil;

#pragma mark -
#pragma mark Singleton methods

+ (PCLogger *)sharedLogger
{
	@synchronized(self)
	{
		if ( manager == nil )
		{
			manager = [[self alloc] init];
            
		}
	}	
	return manager;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (manager == nil)
        {
            manager = [super allocWithZone:zone];
        }
    }
    return manager;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;
}

- (id)autorelease
{
    return self;
}

- (oneway void)release
{
    // do nothing
}

- (id)init
{
    self = [super init];
    if (self) {
        InstallUncaughtExceptionHandler();
        [self createNewLogFile];
        [self logDeviceSpecifications];
    }
    
    return self;
}

-(void)logDeviceSpecifications
{
    [self logToSave:@"--------------------------------------------------------------------" ofType:PC_LOG_INFO];
    [self logToSave:@"--------------------Device Specifications---------------------------" ofType:PC_LOG_INFO];
    
    [self logToSave:[NSString stringWithFormat:@"App Name : %@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]] ofType:PC_LOG_INFO];
    [self logToSave:[NSString stringWithFormat:@"Model : %@",[UIDevice currentDevice].model] ofType:PC_LOG_INFO];
    [self logToSave:[NSString stringWithFormat:@"SystemVersion : %@",[UIDevice currentDevice].systemVersion] ofType:PC_LOG_INFO];
    [self logToSave:[NSString stringWithFormat:@"Platform : %@",[self platformString]] ofType:PC_LOG_INFO];
    [self logToSave:[NSString stringWithFormat:@"LocalizedModel : %@",[UIDevice currentDevice].localizedModel] ofType:PC_LOG_INFO];
    [self logToSave:[NSString stringWithFormat:@"Name : %@",[UIDevice currentDevice].name] ofType:PC_LOG_INFO];
    
    [self logToSave:[NSString stringWithFormat:@"Bundle Path : %@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]] ofType:PC_LOG_INFO];

    [self logToSave:@"--------------------------------------------------------------------" ofType:PC_LOG_INFO];

}

- (NSString *) platformString{
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"])    return @"iPhone 4 CDMA";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 WiFi";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 GSM";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 CDMA";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 CDMAS";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini Wifi";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (Wi-Fi + Cellular)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (Wi-Fi + Cellular MM)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 WiFi";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 CDMA";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 GSM";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 Wifi";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    return @"Unknown";
}


#pragma mark -
#pragma mark Class methods

- (void)createNewLogFile
{
//#ifdef DEBUG
   // NSString *folderPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *folderPath = NSTemporaryDirectory();
    
    NSFileManager *fm = [NSFileManager defaultManager];
    folderPath = [folderPath stringByAppendingPathComponent:@"/Logs"];
    NSError *error = nil;
    [fm createDirectoryAtPath:folderPath withIntermediateDirectories:NO attributes:nil error:&error];
    
    NSArray *dirContents = [fm contentsOfDirectoryAtPath:folderPath error:nil];
    
    for (int i = 0; i < [dirContents count]; i++) {
        if([[dirContents objectAtIndex:i] rangeOfString:@".txt"].location != NSNotFound) {
            NSString *path = [NSString stringWithFormat:@"%@/%@",folderPath,[dirContents objectAtIndex:i]];
            [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        }
    }
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd.MM.yyyy"];   //Creating dateformatter when and converting the dateformatter into string
    NSString *dateString =[dateFormat stringFromDate:date] ;
    [dateFormat release];
    
    NSString *fileName = [NSString stringWithFormat:@"%@/%@%@.txt", 
                          folderPath,[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"],dateString];
    filePath = [[NSString alloc]initWithString:fileName];
//#endif
}

- (void)logToSave:(NSString *)str ofType:(PCLogType)logType
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^(void) {
                       // do some time consuming things here
                       NSString *infoString = [self stringOfLogType:logType];
                       
                       
                       //#ifdef DEBUG
                       
                       //NSLog(@"%@",str);
                       
                       //Getting the previous content which is present in projectname09.15.2011 sothat we can append the new string
                       
                       NSDate *date = [NSDate date];
                       NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
                       [dateFormat1 setDateFormat:@"MMMM dd,yyyy hh:mm a"];
                       NSString *dateString1 = [dateFormat1 stringFromDate:date];
                       [dateFormat1 release];
                       
                       NSString *content = [[NSString alloc] initWithFormat:@"\n%@\t%@\t%@",dateString1,infoString,str];
                       
                       //#endif
                       
                       
                       if(![[NSFileManager defaultManager] fileExistsAtPath:filePath])
                           [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
                       
                       NSFileHandle *file = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
                       [file seekToEndOfFile];
                       [file writeData:[content dataUsingEncoding:NSUTF8StringEncoding]];
                       [file closeFile];
                       [content release];
                       
                       dispatch_sync(dispatch_get_main_queue(), ^{
                           [self performSelectorOnMainThread:@selector(uploadFileToS3) withObject:nil waitUntilDone:YES];
                       });
                       
                   });
    
    
}

- (NSString*)stringOfLogType:(PCLogType)type
{
    NSString *result = nil;
    switch(type) {
        case PC_LOG_INFO:
            result = @"INFO";
            break;
        case PC_LOG_WARN:
            result = @"WARN";
            break;
        case PC_LOG_FATAL:
            result = @"FATAL";
            break;
        default:
            result = @"INFO";
    }
    return result;
}

- (NSString *)getUUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return [(NSString *)string autorelease];
}

-(void)uploadfile:(NSString *)file
{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
    [dateFormat1 setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString1 = [dateFormat1 stringFromDate:date];
    [dateFormat1 release];
    
    id name = [[NSBundle mainBundle] objectForInfoDictionaryKey:kLogBucketName];
    NSString *bucketName = nil;
    if ((name != nil) && [name isKindOfClass:[NSString class]]) {
        
        bucketName = (NSString *)name;
        // NSLog(@"bucket name is %@",bucketName);
    } else {
        PCLogDebug(@"Bucket name couldn't be parsed");
    }
    // TODO: add name of identifier for device
    
    @try {
        NSString *amazonPath = [NSString stringWithFormat:@"%@_v%@_%@",[UIDevice currentDevice].name,[[[NSBundle mainBundle] infoDictionary ] objectForKey: @"CFBundleVersion"],[self getUUID]];
        
        AmazonS3Client *s3 = [[[AmazonS3Client alloc] initWithAccessKey:ACCESS_KEY withSecretKey:SECRET_KEY] autorelease];
        S3CreateBucketRequest *cbr = [[[S3CreateBucketRequest alloc] initWithName:bucketName] autorelease];
        [s3 createBucket:cbr];
        
        S3PutObjectRequest *por = [[[S3PutObjectRequest alloc] initWithKey:[NSString stringWithFormat:@"logs/iOS/%@/%@.log", dateString1, amazonPath] inBucket:bucketName] autorelease];
        
        por.contentType = @"text/plain";
        por.cannedACL   = [S3CannedACL publicRead];
        por.data = [NSData dataWithContentsOfFile:file];
        
        [s3 putObject:por];
        
        [[NSFileManager defaultManager] removeItemAtPath:file error:nil];
    }
    @catch ( AmazonServiceException *exception ) {
        NSLog( @"Upload Failed, Reason: %@", exception );
    }
    
}


- (void)uploadFileToS3
{
//#ifdef DEBUG
    [self uploadfile:filePath];
//#endif
}

@end
