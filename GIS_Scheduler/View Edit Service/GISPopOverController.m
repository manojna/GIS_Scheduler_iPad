//
//  GISPopOverController.m
//  GIS_Scheduler
//
//  Created by Anand on 16/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISPopOverController.h"
#import "GISViewEditListViewController.h"
#import "FFDateManager.h"


@implementation GISPopOverController

@synthesize testProtocol;

int Count = 0;


-(id)initWithEvent:(FFEvent *)eventInit {
        
    GISViewEditListViewController *vlistView=[[GISViewEditListViewController alloc]initWithNibName:@"GISViewEditListViewController" bundle:nil];
    vlistView.testEvent = eventInit;
    Count = 0;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SHOW_WEEK_EVENT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showTestEventDetails:) name:SHOW_WEEK_EVENT object:nil];
    
    vlistView.preferredContentSize = CGSizeMake(300, 250);
    
    self = [super initWithContentViewController:vlistView];
    
    return self;
}


- (void)showTestEventDetails:(NSNotification *)notification {
    
    NSDictionary *infoDict=notification.userInfo;
    
    if(infoDict != nil){
        FFEvent *event = [infoDict objectForKey:@"event"];
        
        [self dismissPopoverAnimated:YES];
        
        if ([testProtocol respondsToSelector:@selector(showPopoverEventDetailWithEvent:)]) {
            
            if(Count == 0){
                [testProtocol showPopoverEventDetailWithEvent:event];
                Count ++;
            }
            else{
                //Count = 0;
                [[NSNotificationCenter defaultCenter] removeObserver:self name:SHOW_WEEK_EVENT object:nil];
                return;
            }

        }
        
    }
}


//- (void)showMonthEventDetails:(NSNotification *)notification {
//    
//    NSDictionary *infoDict=notification.userInfo;
//    
//    if(infoDict != nil){
//        FFEvent *event = [infoDict objectForKey:@"event"];
//        
//        [self dismissPopoverAnimated:YES];
//        
//        if ([testProtocol respondsToSelector:@selector(showPopoverEventDetailWithEvent:)]) {
//            
//            if(Count < 1){
//                [testProtocol showPopoverEventDetailWithEvent:event];
//                Count ++;
//            }
//            else{
//                Count = 0;
//                [[NSNotificationCenter defaultCenter] removeObserver:self name:SHOW_MONTH_EVENT object:nil];
//                return;
//            }
//            
//        }
//        
//    }
//}


@end
