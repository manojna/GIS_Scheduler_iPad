//
//  GISLocationOnCampusCell.m
//  GIS_Scheduler
//
//  Created by Anand on 18/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISLocationOnCampusCell.h"
#import "GISConstants.h"
#import "GISFonts.h"

@implementation GISLocationOnCampusCell

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
    
    [_nextButton setBackgroundColor:UIColorFromRGB(0x00457c)];
    
    [_locationDetailsOncampus_label setFont:[GISFonts large]];
    [_storeLocation_label setFont:[GISFonts normal]];
    [_location_name_label setFont:[GISFonts normal]];
    [_address1_label setFont:[GISFonts normal]];
    [_address2_label setFont:[GISFonts normal]];
    [_state_label setFont:[GISFonts normal]];
    [_zip_label setFont:[GISFonts normal]];
    [_parking_label setFont:[GISFonts normal]];
    [_garage_label setFont:[GISFonts normal]];
    [_mattered_label setFont:[GISFonts normal]];
    [_street_label setFont:[GISFonts normal]];
    [_unknown_label setFont:[GISFonts normal]];
    [_closestmetro_label setFont:[GISFonts normal]];
    [_specialProtocol_label setFont:[GISFonts normal]];
    [_otherInfo_label setFont:[GISFonts normal]];
    [_city_label setFont:[GISFonts normal]];
    [_storeLocationbtn.titleLabel setFont:[GISFonts small]];
    [_closestMetrobtn.titleLabel setFont:[GISFonts small]];
    
    [_locationDetailsOncampus_label setText:NSLocalizedStringFromTable(@"locationDetails_offcampus", TABLE, nil)];
    [_storeLocation_label setText:NSLocalizedStringFromTable(@"store_location", TABLE, nil)];
    [_location_name_label setText:NSLocalizedStringFromTable(@"location_name", TABLE, nil)];
    [_address1_label setText:NSLocalizedStringFromTable(@"address1", TABLE, nil)];
    [_address2_label setText:NSLocalizedStringFromTable(@"address2", TABLE, nil)];
    [_state_label setText:NSLocalizedStringFromTable(@"state", TABLE, nil)];
    [_zip_label setText:NSLocalizedStringFromTable(@"zip", TABLE, nil)];
    [_parking_label setText:NSLocalizedStringFromTable(@"parking", TABLE, nil)];
    [_garage_label setText:NSLocalizedStringFromTable(@"garage", TABLE, nil)];
    [_mattered_label setText:NSLocalizedStringFromTable(@"matered", TABLE, nil)];
    [_street_label setText:NSLocalizedStringFromTable(@"street", TABLE, nil)];
    [_unknown_label setText:NSLocalizedStringFromTable(@"unknown", TABLE, nil)];
    [_closestmetro_label setText:NSLocalizedStringFromTable(@"closest_metro", TABLE, nil)];
    [_specialProtocol_label setText:NSLocalizedStringFromTable(@"special_protocol", TABLE, nil)];
    [_otherInfo_label setText:NSLocalizedStringFromTable(@"other_info", TABLE, nil)];
    [_city_label setText:NSLocalizedStringFromTable(@"city", TABLE, nil)];
    
    [_nextButton setTitle:NSLocalizedStringFromTable(@"next", TABLE, nil) forState:UIControlStateNormal];


}

@end
