//
//  EditView.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/19/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>
#import "GISPopOverTableViewController.h"

#import "FFEvent.h"

@protocol FFEditEventViewProtocol <NSObject>
@required
- (void)saveEvent:(FFEvent *)_event;
- (void)deleteEvent:(FFEvent *)_event;
- (void)removeThisView:(UIView *)view;
@end

@interface FFEditEventView : UIView<PopOverSelected_Protocol,UIPopoverControllerDelegate>
{
    BOOL isPaytype;
    BOOL isServiceprovider;
    GISAppDelegate *appDelegate;
    NSString *payType_string;
    NSString *serviceType_string;
    NSString *subRole_string;
}

@property (nonatomic, strong) id<FFEditEventViewProtocol> protocol;
@property (nonatomic,strong) UIPopoverController *popover;
@property (nonatomic,strong) UIView *backgroundView;
@property (nonatomic,strong) UIView *ServicebackgroundView;
@property (nonatomic,strong) UIView *payTypeBackgroundView;
@property (nonatomic,strong) NSArray *serviceTypeArray;

- (id)initWithFrame:(CGRect)frame event:(FFEvent *)_event;

@end
