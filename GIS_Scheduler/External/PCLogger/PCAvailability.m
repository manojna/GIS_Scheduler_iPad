//
//  PCAvailability.h
//
//  Created by Paradigm Creatives on 2.11.12.
//  Copyright (c) 2011 Paradigm Creatives Pvt. Ltd. All rights reserved.
//


#import "PCAvailability.h"
#import "PCDebug.h"

static PCSystemVersion systemVersion;

void PCAvailabilityDetectSystemVersion(void)
{	
	NSArray *tokens = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
	int multiplier = 10000;
	
	systemVersion = 0;	
	for (int i = 0; i < tokens.count; ++i)
	{
		int val = [[tokens objectAtIndex:i] intValue];
		systemVersion += val * multiplier;
		multiplier /= 100;
	}
	
	PCLogInfo(@"System version: %d", systemVersion);
}

BOOL PCAvailabilitySystemVersionAvailable(PCSystemVersion version)
{
	return systemVersion >= version;
}

