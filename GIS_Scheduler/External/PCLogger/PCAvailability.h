//
//  PCAvailability.h
//
//  Created by Paradigm Creatives on 2.11.12.
//  Copyright (c) 2011 Paradigm Creatives Pvt. Ltd. All rights reserved.
//

#ifndef PCAvailability_h
#define PCAvailability_h

#import <UIKit/UIKit.h>

#ifndef __IPHONE_3_2
#define __IPHONE_3_2     30200
#endif

#ifndef __IPHONE_4_0
#define __IPHONE_4_0     40000
#endif

#ifndef __IPHONE_5_0
#define __IPHONE_5_0     50000
#endif

#ifndef __IPHONE_6_0
#define __IPHONE_6_0     60000
#endif

#define PC_SYSTEM_VERSION_MIN __IPHONE_5_0

#define PC_IOS_SDK_AVAILABLE(sdk_ver) (__IPHONE_OS_VERSION_MAX_ALLOWED >= (sdk_ver))
#define PC_SYSTEM_VERSION_AVAILABLE(sys_ver) PCAvailabilitySystemVersionAvailable(sys_ver)
#define PC_SELECTOR_AVAILABLE(obj, sel) [(obj) respondsToSelector:@selector(sel)]
#define PC_CLASS_AVAILABLE(className) (NSClassFromString(@#className) != nil)

typedef NSUInteger PCSystemVersion;

void PCAvailabilityDetectSystemVersion(void);
BOOL PCAvailabilitySystemVersionAvailable(PCSystemVersion version);

#endif
