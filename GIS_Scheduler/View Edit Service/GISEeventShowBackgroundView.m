//
//  GISEeventShowBackgroundView.m
//  GIS_Scheduler
//
//  Created by Anand on 18/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//




#import "GISEeventShowBackgroundView.h"

@implementation GISEeventShowBackgroundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setBackgroundColor:[UIColor colorWithRed:49./255. green:181./255. blue:247./255. alpha:0.5]];
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
