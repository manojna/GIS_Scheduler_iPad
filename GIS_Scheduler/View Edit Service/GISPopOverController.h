//
//  GISPopOverController.h
//  GIS_Scheduler
//
//  Created by Anand on 16/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFEvent.h"

@protocol TestEventDetailPopoverControllerProtocol <NSObject>
@required
- (void)showPopoverEventDetailWithEvent:(FFEvent *)_event;
@end

@interface GISPopOverController : UIPopoverController

@property (nonatomic, strong) id<TestEventDetailPopoverControllerProtocol> testProtocol;

- (id)initWithEvent:(FFEvent *)eventInit ;

@end
