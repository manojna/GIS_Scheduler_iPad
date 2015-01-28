//
//  GISSummaryCell.m
//  GIS_Scheduler
//
//  Created by Anand on 18/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISSummaryCell.h"
#import "GISFonts.h"
#import "GISConstants.h"

@implementation GISSummaryCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    [_section_label setFont:[GISFonts large]];
    [_requestor_label setFont:[GISFonts normal]];
    [_unitacNumber_label setFont:[GISFonts normal]];
    [_firstName_label setFont:[GISFonts normal]];
    [_lastName_label setFont:[GISFonts normal]];
    [_email_label setFont:[GISFonts normal]];
    [_city_label setFont:[GISFonts normal]];
    [_state_label setFont:[GISFonts normal]];
    [_zip_label setFont:[GISFonts normal]];
    [_address1_label setFont:[GISFonts normal]];
    [_address2_label setFont:[GISFonts normal]];
    
    [_requestor_ans_label setFont:[GISFonts normal]];
    [_unitacNumber_ans_label setFont:[GISFonts normal]];
    [_firstName_ans_label setFont:[GISFonts normal]];
    [_lastName_ans_label setFont:[GISFonts normal]];
    [_email_ans_label setFont:[GISFonts normal]];
    [_city_ans_label setFont:[GISFonts normal]];
    [_state_ans_label setFont:[GISFonts normal]];
    [_zip_ans_label setFont:[GISFonts normal]];
    [_address1_ans_label setFont:[GISFonts normal]];
    [_address2_ans_label setFont:[GISFonts normal]];
    
    _requestor_ans_label.textColor = UIColorFromRGB(0x999999);
    _unitacNumber_ans_label.textColor = UIColorFromRGB(0x999999);
    _firstName_ans_label.textColor = UIColorFromRGB(0x999999);
    _lastName_ans_label.textColor = UIColorFromRGB(0x999999);
    _email_ans_label.textColor = UIColorFromRGB(0x999999);
    _city_ans_label.textColor = UIColorFromRGB(0x999999);
    _state_ans_label.textColor = UIColorFromRGB(0x999999);
    _zip_ans_label.textColor = UIColorFromRGB(0x999999);
    _address1_ans_label.textColor = UIColorFromRGB(0x999999);
    _address2_ans_label.textColor = UIColorFromRGB(0x999999);
    
}

@end
