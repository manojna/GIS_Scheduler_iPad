//
//  GISPreparationMaterialCell.m
//  GIS_Scheduler
//
//  Created by Anand on 17/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISPreparationMaterialCell.h"
#import "GISConstants.h"
#import "GISFonts.h"

@implementation GISPreparationMaterialCell

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
    
    [_othertechnologies_label setFont:[GISFonts normal]];
    [_otherservicesneeded_label setFont:[GISFonts large]];
    [_other_label setFont:[GISFonts normal]];
    [_document_label setFont:[GISFonts normal]];
    [_blackboardaccess_label setFont:[GISFonts normal]];
    [_website_label setFont:[GISFonts normal]];
    [_preparationMaterial_label setFont:[GISFonts large]];
    [_eventDescription_label setFont:[GISFonts large]];
    [_description_label setFont:[GISFonts normal]];
    [_captioning_type_label setFont:[GISFonts normal]];
    [_viewingType_label setFont:[GISFonts normal]];
    [_ofUsers_label setFont:[GISFonts normal]];
    [_otherServices_label setFont:[GISFonts normal]];
    [_document_attach_label setFont:[GISFonts normal]];
    
    [_otherServicesbtn.titleLabel setFont:[GISFonts small]];
    [_captionTypebtn.titleLabel setFont:[GISFonts small]];
    [_viewingTypebtn.titleLabel setFont:[GISFonts small]];
    
    [_otherServicesbtn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    [_captionTypebtn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    [_viewingTypebtn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    
    [_othertechnologies_label setText:NSLocalizedStringFromTable(@"preparation_material_label", TABLE, nil)];
    [_otherservicesneeded_label setText:NSLocalizedStringFromTable(@"other_servicesNeeded", TABLE, nil)];
    [_other_label setText:NSLocalizedStringFromTable(@"other", TABLE, nil)];
    [_document_label setText:NSLocalizedStringFromTable(@"document", TABLE, nil)];
    [_blackboardaccess_label setText:NSLocalizedStringFromTable(@"blackboard_access", TABLE, nil)];
    [_website_label setText:NSLocalizedStringFromTable(@"website", TABLE, nil)];
    [_preparationMaterial_label setText:NSLocalizedStringFromTable(@"preparation_material", TABLE, nil)];
    [_eventDescription_label setText:NSLocalizedStringFromTable(@"event_description", TABLE, nil)];
    [_description_label setText:NSLocalizedStringFromTable(@"description", TABLE, nil)];
    [_captioning_type_label setText:NSLocalizedStringFromTable(@"captioning_type", TABLE, nil)];
    [_viewingType_label setText:NSLocalizedStringFromTable(@"viewing_type", TABLE, nil)];
    [_ofUsers_label setText:NSLocalizedStringFromTable(@"of_users", TABLE, nil)];
    [_otherServices_label setText:NSLocalizedStringFromTable(@"other_services", TABLE, nil)];
    
    [_nextButton setTitle:NSLocalizedStringFromTable(@"next", TABLE, nil) forState:UIControlStateNormal];
    [_nextButton.layer setCornerRadius:3.0f];
    [[_nextButton layer] setMasksToBounds:YES];
    [_nextButton setTitleColor:UIColorFromRGB(0xe8d4a2) forState:UIControlStateNormal];
    _nextButton.titleLabel.font=[GISFonts larger];
   
}

@end
