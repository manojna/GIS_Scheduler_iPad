//
//  GISCommentCell.m
//  GIS_Scheduler
//
//  Created by Anand on 18/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISCommentCell.h"
#import "GISFonts.h"
#import "GISConstants.h"

@implementation GISCommentCell

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
    
    [_accountsAdministration_label setFont:[GISFonts large]];
    [_noComments_label setFont:[GISFonts normal]];
    [_scheduler_label setFont:[GISFonts large]];
    
    [_accountsAdministration_label setText:NSLocalizedStringFromTable(@"account_administration", TABLE, nil)];
    [_scheduler_label setText:NSLocalizedStringFromTable(@"scheduler", TABLE, nil)];

}

@end
