//
//  GISEventLabel.m
//  GIS_Scheduler
//
//  Created by Anand on 16/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISEventLabel.h"
#import "GISFonts.h"

@implementation GISEventLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.textColor = [UIColor blackColor];
        [self setFont:[GISFonts normal]];
        
        [self setBackgroundColor:[UIColor whiteColor]];
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
