
//
//  GISAttendeesCell.m
//  GIS_Scheduler
//
//  Created by Paradigm on 15/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISAttendeesTopCell.h"
#import "GISFonts.h"
#import "GISConstants.h"
@implementation GISAttendeesTopCell

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
    self.expectedNo_Label.font=[GISFonts normal];
    self.expectedNo_answer_Label.font=[GISFonts small];
    self.genderPreference_Label.font=[GISFonts normal];
    self.genderPreference_answer_Label.font=[GISFonts small];
    self.serviceProvider_preference_Label.font=[GISFonts normal];
    self.preference_answer_Label.font=[GISFonts small];
    self.preference_Label.font=[GISFonts normal];
    self.primaryAudience_answer_Label.font=[GISFonts small];
    self.primaryAudience_Label.font=[GISFonts normal];
    
    self.firstname_Label.font=[GISFonts normal];
    self.lastname_Label.font=[GISFonts normal];
    self.email_Label.font=[GISFonts normal];
    self.attendeesList_Label.font=[GISFonts large];
    self.attendee_Label.font=[GISFonts large];
    self.attendee_count_Label.font=[GISFonts large];
    self.firstname_textField.font=[GISFonts small];
    self.lastname_textField.font=[GISFonts small];
    self.email_textField.font=[GISFonts small];
    self.modeOf_answer_Label.font=[GISFonts small];
    self.directly_utilized_services_answer_Label.font=[GISFonts small];
    self.servicesNeeded_answer_Label.font=[GISFonts small];

    self.modeOf_Label_2.font=[GISFonts normal];
    self.modeOf_Label.font=[GISFonts normal];
    self.directly_utilized_services_Label_2.font=[GISFonts normal];
    self.directly_utilized_services_Label.font=[GISFonts normal];
    self.servicesNeeded_Label.font=[GISFonts normal];
    
    /////////TextColor
    self.expectedNo_Label.textColor=UIColorFromRGB(0x666666);
    self.expectedNo_answer_Label.textColor=UIColorFromRGB(0x666666);
    self.genderPreference_Label.textColor=UIColorFromRGB(0x666666);
    self.genderPreference_answer_Label.textColor=UIColorFromRGB(0x666666);
    self.serviceProvider_preference_Label.textColor=UIColorFromRGB(0x666666);
    self.preference_answer_Label.textColor=UIColorFromRGB(0x666666);
    self.preference_Label.textColor=UIColorFromRGB(0x666666);
    self.primaryAudience_Label.textColor=UIColorFromRGB(0x666666);
    self.primaryAudience_answer_Label.textColor=UIColorFromRGB(0x666666);
    
    self.firstname_Label.textColor=UIColorFromRGB(0x666666);
    self.lastname_Label.textColor=UIColorFromRGB(0x666666);
    self.email_Label.textColor=UIColorFromRGB(0x666666);
    self.attendee_Label.textColor=UIColorFromRGB(0x666666);
    self.attendee_count_Label.textColor=UIColorFromRGB(0x666666);
    self.firstname_textField.textColor=UIColorFromRGB(0x666666);
    self.lastname_textField.textColor=UIColorFromRGB(0x666666);
    self.email_textField.textColor=UIColorFromRGB(0x666666);
    self.modeOf_answer_Label.textColor=UIColorFromRGB(0x666666);
    self.directly_utilized_services_answer_Label.textColor=UIColorFromRGB(0x666666);
    self.servicesNeeded_answer_Label.textColor=UIColorFromRGB(0x666666);
    
    
    self.attendeesList_Label.textColor=UIColorFromRGB(0x00457c);
    self.attendee_Label.textColor=UIColorFromRGB(0x00457c);
    self.attendee_count_Label.textColor=UIColorFromRGB(0x00457c);
    
    self.modeOf_Label_2.textColor=UIColorFromRGB(0x666666);
    self.modeOf_Label.textColor=UIColorFromRGB(0x666666);
    self.directly_utilized_services_Label_2.textColor=UIColorFromRGB(0x666666);
    self.directly_utilized_services_Label.textColor=UIColorFromRGB(0x666666);
    self.servicesNeeded_Label.textColor=UIColorFromRGB(0x666666);
    
    self.nextButton.backgroundColor=UIColorFromRGB(0x00457c);
    [self.nextButton setTitleColor:UIColorFromRGB(0xe8d4a2) forState:UIControlStateNormal];
    self.nextButton.titleLabel.font=[GISFonts larger];
    [self.nextButton.layer setCornerRadius:3.0f];
    
    ////////////////Localized strings
    
    self.expectedNo_Label.text=NSLocalizedStringFromTable(@"select_no_of_expected_attendees", TABLE, nil);
    self.genderPreference_Label.text=NSLocalizedStringFromTable(@"gender_Preference", TABLE, nil);
    self.serviceProvider_preference_Label.text=NSLocalizedStringFromTable(@"service_Provider", TABLE, nil);
    self.preference_Label.text=NSLocalizedStringFromTable(@"preference", TABLE, nil);
    
    self.firstname_Label.text=NSLocalizedStringFromTable(@"first_name", TABLE, nil);
    self.lastname_Label.text=NSLocalizedStringFromTable(@"last_name", TABLE, nil);
    self.email_Label.text=NSLocalizedStringFromTable(@"email", TABLE, nil);
    self.attendeesList_Label.text=NSLocalizedStringFromTable(@"attendees_List", TABLE, nil);
    self.attendee_Label.text=NSLocalizedStringFromTable(@"attendee", TABLE, nil);
    
    self.modeOf_Label_2.text=NSLocalizedStringFromTable(@"communication", TABLE, nil);
    self.modeOf_Label.text=NSLocalizedStringFromTable(@"primary_mode_of", TABLE, nil);
    self.directly_utilized_services_Label_2.text=NSLocalizedStringFromTable(@"services", TABLE, nil);
    self.directly_utilized_services_Label.text=NSLocalizedStringFromTable(@"directly_utilized", TABLE, nil);
    self.servicesNeeded_Label.text=NSLocalizedStringFromTable(@"service_Needed", TABLE, nil);
    [self.nextButton setTitle:NSLocalizedStringFromTable(@"next", TABLE, nil) forState:UIControlStateNormal];
    
    /////////////////
}

@end
