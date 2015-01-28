//
//  GISLocationDetailsCell.m
//  GIS_Scheduler
//
//  Created by Anand on 17/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISLocationDetailsCell.h"
#import "GISFonts.h"
#import "GISConstants.h"

@implementation GISLocationDetailsCell

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
    
    [_locationDetailsOffcampus_label setFont:[GISFonts large]];
    [_buildingName_label setFont:[GISFonts normal]];
    [_roomName_label setFont:[GISFonts normal]];
    [_roomNo_label setFont:[GISFonts normal]];
    [_other_label setFont:[GISFonts normal]];
    [_socialProtocol_label setFont:[GISFonts normal]];
    [_metroNearby_label setFont:[GISFonts normal]];
    [_parking_label setFont:[GISFonts normal]];
    [_garage_label setFont:[GISFonts normal]];
    [_mattered_label setFont:[GISFonts normal]];
    [_street_label setFont:[GISFonts normal]];
    [_unknown_label setFont:[GISFonts normal]];
    [_generalLocation_label setFont:[GISFonts normal]];
    [_buildingNamebtn.titleLabel setFont:[GISFonts small]];
    [_nextButton setBackgroundColor:UIColorFromRGB(0x00457c)];
    [_nextButton setTitle:NSLocalizedStringFromTable(@"next", TABLE, nil) forState:UIControlStateNormal];

    [_locationDetailsOffcampus_label setText:NSLocalizedStringFromTable(@"location_details_onCampus", TABLE, nil)];
    [_buildingName_label setText:NSLocalizedStringFromTable(@"building_name", TABLE, nil)];
    [_roomName_label setText:NSLocalizedStringFromTable(@"room_name", TABLE, nil)];
    [_roomNo_label setText:NSLocalizedStringFromTable(@"room_no", TABLE, nil)];
    [_other_label setText:NSLocalizedStringFromTable(@"other_info", TABLE, nil)];
    [_socialProtocol_label setText:NSLocalizedStringFromTable(@"social_protocol", TABLE, nil)];
    [_metroNearby_label setText:NSLocalizedStringFromTable(@"metro_nearby", TABLE, nil)];
    [_parking_label setText:NSLocalizedStringFromTable(@"parking", TABLE, nil)];
    [_garage_label setText:NSLocalizedStringFromTable(@"garage", TABLE, nil)];
    [_mattered_label setText:NSLocalizedStringFromTable(@"matered", TABLE, nil)];
    [_street_label setText:NSLocalizedStringFromTable(@"street", TABLE, nil)];
    [_unknown_label setText:NSLocalizedStringFromTable(@"unknown", TABLE, nil)];
    [_generalLocation_label setText:NSLocalizedStringFromTable(@"general_location", TABLE, nil)];
    
    [_nextButton.layer setCornerRadius:3.0f];
    [[_nextButton layer] setMasksToBounds:YES];
    [_nextButton setTitleColor:UIColorFromRGB(0xe8d4a2) forState:UIControlStateNormal];
    _nextButton.titleLabel.font=[GISFonts larger];

}

@end
