//
//  GISViewEditListVIewCell.m
//  GIS_Scheduler
//
//  Created by Anand on 16/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISViewEditListVIewCell.h"
#import "GISFonts.h"

@implementation GISViewEditListVIewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    [_jobName setFont:[GISFonts normal]];
    [_eventTime setFont:[GISFonts normal]];
    [_eventTitle setFont:[GISFonts normal]];
}

@end
