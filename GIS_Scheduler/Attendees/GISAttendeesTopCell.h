//
//  GISAttendeesCell.h
//  GIS_Scheduler
//
//  Created by Paradigm on 15/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GISAttendeesTopCell : UITableViewCell


@property(nonatomic,strong)IBOutlet UILabel *expectedNo_Label;
@property(nonatomic,strong)IBOutlet UILabel *genderPreference_Label;
@property(nonatomic,strong)IBOutlet UILabel *serviceProvider_preference_Label;
@property(nonatomic,strong)IBOutlet UILabel *preference_Label;

@property(nonatomic,strong)IBOutlet UILabel *expectedNo_answer_Label;
@property(nonatomic,strong)IBOutlet UILabel *genderPreference_answer_Label;
@property(nonatomic,strong)IBOutlet UILabel *preference_answer_Label;

@property(nonatomic,strong)IBOutlet UILabel *firstname_Label;
@property(nonatomic,strong)IBOutlet UILabel *lastname_Label;
@property(nonatomic,strong)IBOutlet UILabel *email_Label;
@property(nonatomic,strong)IBOutlet UILabel *modeOf_Label;
@property(nonatomic,strong)IBOutlet UILabel *directly_utilized_services_Label;
@property(nonatomic,strong)IBOutlet UILabel *servicesNeeded_Label;


@property(nonatomic,strong)IBOutlet UILabel *directly_utilized_services_Label_2;
@property(nonatomic,strong)IBOutlet UILabel *modeOf_Label_2;


@property(nonatomic,strong)IBOutlet UILabel *modeOf_answer_Label;
@property(nonatomic,strong)IBOutlet UILabel *directly_utilized_services_answer_Label;
@property(nonatomic,strong)IBOutlet UILabel *servicesNeeded_answer_Label;


@property(nonatomic,strong)IBOutlet UILabel *attendeesList_Label;
@property(nonatomic,strong)IBOutlet UILabel *attendee_Label;
@property(nonatomic,strong)IBOutlet UILabel *attendee_count_Label;


@property(nonatomic,strong)IBOutlet UITextField *firstname_textField;
@property(nonatomic,strong)IBOutlet UITextField *lastname_textField;
@property(nonatomic,strong)IBOutlet UITextField *email_textField;
@property(nonatomic,strong)IBOutlet UIButton *modeOf_Button;
@property(nonatomic,strong)IBOutlet UIButton *directly_utilized_services_Button;
@property(nonatomic,strong)IBOutlet UIButton *servicesNeeded_Button;
@property(nonatomic,strong)IBOutlet UIButton *genderPreference_Button;
@property(nonatomic,strong)IBOutlet UIButton *preference_Button;
@property(nonatomic,strong)IBOutlet UIButton *nextButton;



@property(nonatomic,strong)IBOutlet UILabel *primaryAudience_Label;
@property(nonatomic,strong)IBOutlet UITextField *primaryAudience_TextField;
@property(nonatomic,strong)IBOutlet UIImageView *primaryAudience_ImageView;
@property(nonatomic,strong)IBOutlet UIButton *primaryAudience_button;
@property(nonatomic,strong)IBOutlet UILabel *primaryAudience_answer_Label;

@property (nonatomic, readwrite) NSInteger cellSectionNumber;
@property (nonatomic, readwrite) NSInteger cellRowNumber;
@property (nonatomic, retain) NSIndexPath *cellIndexpath;

@property(nonatomic,strong)IBOutlet UIView *primaryAudience_UIView;

@end
