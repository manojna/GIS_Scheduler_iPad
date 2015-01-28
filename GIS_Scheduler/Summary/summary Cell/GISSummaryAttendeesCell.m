//
//  GISSummaryAttendeesCell.m
//  GIS_Scheduler
//
//  Created by Anand on 18/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISSummaryAttendeesCell.h"
#import "GISFonts.h"
#import "GISConstants.h"

@implementation GISSummaryAttendeesCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    [_modeOf_communication_label setFont:[GISFonts large]];
    [_directly_utilized_label setFont:[GISFonts normal]];
    [_other_services_label setFont:[GISFonts normal]];
    [_firstName_label setFont:[GISFonts normal]];
    [_lastName_label setFont:[GISFonts normal]];
    [_attendee_label setFont:[GISFonts large]];
    [_attendee_count_label setFont:[GISFonts large]];
    [_email_label setFont:[GISFonts normal]];
    
    [_modeOf_communication_ans_label setFont:[GISFonts large]];
    [_directly_utilized_ans_label setFont:[GISFonts normal]];
    [_other_services_ans_label setFont:[GISFonts normal]];
    [_firstName_ans_label setFont:[GISFonts normal]];
    [_lastName_ans_label setFont:[GISFonts normal]];
    [_email_ans_label setFont:[GISFonts normal]];
    
    _modeOf_communication_ans_label.textColor = UIColorFromRGB(0x999999);
    _directly_utilized_ans_label.textColor = UIColorFromRGB(0x999999);
    _firstName_ans_label.textColor = UIColorFromRGB(0x999999);
    _lastName_ans_label.textColor = UIColorFromRGB(0x999999);
    _other_services_ans_label.textColor = UIColorFromRGB(0x999999);
    _email_ans_label.textColor = UIColorFromRGB(0x999999);
    _attendee_count_label.textColor = UIColorFromRGB(0x00457c);
    _attendee_label.textColor = UIColorFromRGB(0x00457c);

}

@end
