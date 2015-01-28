//
//  GISDashBoardSPCell.m
//  GIS_Scheduler
//
//  Created by Anand on 01/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISDashBoardSPCell.h"
#import "GISFonts.h"

@implementation GISDashBoardSPCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    [_payType_btn.titleLabel setFont:[GISFonts small]];
    [_response_status_btn.titleLabel setFont:[GISFonts small]];

}

@end
