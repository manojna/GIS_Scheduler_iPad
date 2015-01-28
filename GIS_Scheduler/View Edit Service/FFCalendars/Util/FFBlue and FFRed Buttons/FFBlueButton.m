//
//  BlueButton.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/19/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFBlueButton.h"
#import "GISFonts.h"

@implementation FFBlueButton

#pragma mark - Synthesize

@synthesize event;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        
        self.titleLabel.numberOfLines = 0;
        [self setBackgroundColor:[UIColor clearColor]];//[UIColor colorWithRed:49./255. green:181./255. blue:247./255. alpha:0.5]];
        [self.titleLabel setFont:[GISFonts normalBold]];
        [self setTitleColor:[UIColor colorWithRed:28./255. green:195./255. blue:255./255. alpha:5.0] forState:UIControlStateNormal];
        
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
