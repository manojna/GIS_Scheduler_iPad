//
//  GISDatesTimesDetailCell.m
//  GIS_Scheduler
//
//  Created by Paradigm on 18/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISDatesTimesDetailCell.h"
#import "GISFonts.h"
#import "GISConstants.h"
@implementation GISDatesTimesDetailCell

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

    // Configure the view for the selected state

    self.dateLabel.textColor=UIColorFromRGB(0x666666);
    self.dayLabel.textColor=UIColorFromRGB(0x666666);
    self.startTime_Label.textColor=UIColorFromRGB(0x666666);
    self.endTimeLabel.textColor=UIColorFromRGB(0x666666);
    
    self.date_TextField.textColor=UIColorFromRGB(0x666666);
    self.startTime_TextField.textColor=UIColorFromRGB(0x666666);
    self.endTime_TextField.textColor=UIColorFromRGB(0x666666);
    
    self.dateLabel.font=[GISFonts small];
    self.dayLabel.font=[GISFonts small];
    self.startTime_Label.font=[GISFonts small];
    self.endTimeLabel.font=[GISFonts small];
}

@end
