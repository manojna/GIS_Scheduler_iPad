//
//  GISEventDetailsCell.m
//  GIS_Scheduler
//
//  Created by Anand on 15/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISEventDetailsCell.h"
#import "GISFonts.h"
#import "GISConstants.h"

@implementation GISEventDetailsCell

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
    
    [_eventName_label setFont:[GISFonts normal]];
    [_eventType_label setFont:[GISFonts normal]];
    [_ongoing_label setFont:[GISFonts normal]];
    [_openTOpublic_label setFont:[GISFonts normal]];
    [_dresscode_label setFont:[GISFonts normal]];
    [_record_broadcast_label setFont:[GISFonts normal]];
    [_open_topublicno_label setFont:[GISFonts normal]];
    [_open_topublicyes_label setFont:[GISFonts normal]];
    [_recordedno_label setFont:[GISFonts normal]];
    [_recordedyes_label setFont:[GISFonts normal]];
    [_course_label setFont:[GISFonts normal]];
    [_onGoingno_label setFont:[GISFonts normal]];
    [_onGoingyes_label setFont:[GISFonts normal]];
    [_fmsystem_label setFont:[GISFonts normal]];
    [_webinar_label setFont:[GISFonts normal]];
    [_microPhone_label setFont:[GISFonts normal]];
    [_phoneConference_label setFont:[GISFonts normal]];
    [_othertechnologies_label setFont:[GISFonts normal]];
    [_broadcastYesSelcted setFont:[GISFonts tiny]];
    
    [_eventTypebtn.titleLabel setFont:[GISFonts small]];
    [_dressCodebtn.titleLabel setFont:[GISFonts small]];
    
    [_eventTypebtn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    [_dressCodebtn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    
    [_eventName_label setText:NSLocalizedStringFromTable(@"event_name", TABLE, nil)];
    [_eventType_label setText:NSLocalizedStringFromTable(@"event_type", TABLE, nil)];
    [_ongoing_label setText:NSLocalizedStringFromTable(@"on_going", TABLE, nil)];
    [_openTOpublic_label setText:NSLocalizedStringFromTable(@"open_toPublic", TABLE, nil)];
    [_dresscode_label setText:NSLocalizedStringFromTable(@"dress_Code", TABLE, nil)];
    [_record_broadcast_label setText:NSLocalizedStringFromTable(@"recorede_braoadcast", TABLE, nil)];
    [_outSideAgency_label setText:NSLocalizedStringFromTable(@"outside_agency", TABLE, nil)];
    [_open_topublicno_label setText:NSLocalizedStringFromTable(@"no", TABLE, nil)];
    [_open_topublicyes_label setText:NSLocalizedStringFromTable(@"yes", TABLE, nil)];
    [_outSideAgencyno_label setText:NSLocalizedStringFromTable(@"no", TABLE, nil)];
    [_outSideAgencyyes_label setText:NSLocalizedStringFromTable(@"yes", TABLE, nil)];
    [_recordedno_label setText:NSLocalizedStringFromTable(@"no", TABLE, nil)];
    [_recordedyes_label setText:NSLocalizedStringFromTable(@"yes", TABLE, nil)];
    [_course_label setText:NSLocalizedStringFromTable(@"course_id", TABLE, nil)];
    [_onGoingno_label setText:NSLocalizedStringFromTable(@"no", TABLE, nil)];
    [_onGoingyes_label setText:NSLocalizedStringFromTable(@"yes", TABLE, nil)];
    [_fmsystem_label setText:NSLocalizedStringFromTable(@"fm_system", TABLE, nil)];
    [_webinar_label setText:NSLocalizedStringFromTable(@"webinar", TABLE, nil)];
    [_microPhone_label setText:NSLocalizedStringFromTable(@"micro_phone", TABLE, nil)];
    [_phoneConference_label setText:NSLocalizedStringFromTable(@"phone_conferencing", TABLE, nil)];
    [_othertechnologies_label setText:NSLocalizedStringFromTable(@"other_technologies", TABLE, nil)];
    
}

@end
