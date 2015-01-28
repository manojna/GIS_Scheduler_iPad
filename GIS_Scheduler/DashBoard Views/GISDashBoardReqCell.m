//
//  GISDashBoardReqCell.m
//  GIS_Scheduler
//
//  Created by Anand on 01/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISDashBoardReqCell.h"
#import "GISFonts.h"

@implementation GISDashBoardReqCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    [_accountName_Label setFont:[GISFonts normal]];
    [_requestID_Label setFont:[GISFonts normal]];
    [_eventType_Label setFont:[GISFonts normal]];
    [_otherServices_Label setFont:[GISFonts normal]];
    [_requestSubmissinDate_Label setFont:[GISFonts normal]];
    [_dateOfEarlier_Label setFont:[GISFonts normal]];
    [_status_Label setFont:[GISFonts normal]];
    [_scheduler_Label setFont:[GISFonts normal]];
}

@end
