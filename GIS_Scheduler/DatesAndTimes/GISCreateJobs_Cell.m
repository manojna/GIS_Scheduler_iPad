//
//  GISCreateJobs_Cell.m
//  GIS_Scheduler
//
//  Created by Paradigm on 11/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISCreateJobs_Cell.h"
#import "GISFonts.h"
#import "GISConstants.h"

@implementation GISCreateJobs_Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    _dateLabel.font=[GISFonts small];
    _dayLabel.font=[GISFonts small];
    _dateLabel.textColor=UIColorFromRGB(0x666666);
    _dayLabel.textColor=UIColorFromRGB(0x666666);
    _startTime_Label .font=[GISFonts normal];
    _startTime_Label.textColor=UIColorFromRGB(0x666666);
    _endTimeLabel .font=[GISFonts normal];
    _endTimeLabel.textColor=UIColorFromRGB(0x666666);
    // Configure the view for the selected state
}

@end
