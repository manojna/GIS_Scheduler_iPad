
//
//  GISJobDetailsCell.m
//  GIS_Scheduler
//
//  Created by Paradigm on 12/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISJobDetailsCell.h"
#import "GISFonts.h"

@implementation GISJobDetailsCell

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
    
    
    [_job_ID_Label setFont:[GISFonts small]];
    [_job_date_Label setFont:[GISFonts small]];
    [_start_time_Label setFont:[GISFonts small]];
    [_end_time_Label setFont:[GISFonts small]];
    [_typeOf_service_Label setFont:[GISFonts small]];
    [_service_provider_Label setFont:[GISFonts small]];
    [_payType_Label setFont:[GISFonts small]];
    [_timely_Label setFont:[GISFonts small]];
    [_billAmt_Label setFont:[GISFonts small]];
    [_slots_Label setFont:[GISFonts small]];

}

@end
