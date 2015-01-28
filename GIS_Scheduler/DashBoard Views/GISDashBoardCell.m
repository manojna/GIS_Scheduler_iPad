//
//  GISDashBoardCell.m
//  GIS_Scheduler
//
//  Created by Paradigm on 11/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISDashBoardCell.h"
#import "GISFonts.h"

@implementation GISDashBoardCell


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
    
    [_accountName_Label setFont:[GISFonts normal]];
    [_requestID_Label setFont:[GISFonts normal]];
    [_eventType_Label setFont:[GISFonts normal]];
    [_otherServices_Label setFont:[GISFonts normal]];
    [_earliestDate_Label setFont:[GISFonts normal]];
    [_approvalDate_Label setFont:[GISFonts normal]];
    [_approvedBy_Label setFont:[GISFonts normal]];
    [_status_Label setFont:[GISFonts normal]];
    [_scheduler_Label setFont:[GISFonts normal]];
    
}

@end
