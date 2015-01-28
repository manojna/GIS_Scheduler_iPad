//
//  GISEventDetailsCell.h
//  GIS_Scheduler
//
//  Created by Anand on 15/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISEventDetailsCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UILabel *eventName_label;
@property(nonatomic,strong)IBOutlet UILabel *eventType_label;
@property(nonatomic,strong)IBOutlet UILabel *openTOpublic_label;
@property(nonatomic,strong)IBOutlet UILabel *dresscode_label;
@property(nonatomic,strong)IBOutlet UILabel *record_broadcast_label;
@property(nonatomic,strong)IBOutlet UILabel *ongoing_label;
@property(nonatomic,strong)IBOutlet UILabel *course_label;
@property(nonatomic,strong)IBOutlet UILabel *othertechnologies_label;
@property(nonatomic,strong)IBOutlet UILabel *fmsystem_label;
@property(nonatomic,strong)IBOutlet UILabel *microPhone_label;
@property(nonatomic,strong)IBOutlet UILabel *phoneConference_label;
@property(nonatomic,strong)IBOutlet UILabel *webinar_label;
@property(nonatomic,strong)IBOutlet UILabel *open_topublicyes_label;
@property(nonatomic,strong)IBOutlet UILabel *open_topublicno_label;
@property(nonatomic,strong)IBOutlet UILabel *recordedyes_label;
@property(nonatomic,strong)IBOutlet UILabel *recordedno_label;
@property(nonatomic,strong)IBOutlet UILabel *onGoingyes_label;
@property(nonatomic,strong)IBOutlet UILabel *onGoingno_label;
@property(nonatomic,strong)IBOutlet UILabel *outSideAgency_label;
@property(nonatomic,strong)IBOutlet UILabel *outSideAgencyyes_label;
@property(nonatomic,strong)IBOutlet UILabel *outSideAgencyno_label;
@property(nonatomic,strong)IBOutlet UITextField *eventName_textField;
@property(nonatomic,strong)IBOutlet UITextField *course_textField;

@property (strong, nonatomic) IBOutlet UIButton *opentoPublicbtn1;
@property (strong, nonatomic) IBOutlet UIButton *opentoPublicbtn2;
@property (strong, nonatomic) IBOutlet UIButton *recorded1;
@property (strong, nonatomic) IBOutlet UIButton *recorded2;
@property (strong, nonatomic) IBOutlet UIButton *onGoing1;
@property (strong, nonatomic) IBOutlet UIButton *ongoing2;
@property (strong, nonatomic) IBOutlet UIButton *outsideAgency1;
@property (strong, nonatomic) IBOutlet UIButton *outsideAgency2;
@property (strong, nonatomic) IBOutlet UIButton *fmSystembtn;
@property (strong, nonatomic) IBOutlet UIButton *microPhonebtn;
@property (strong, nonatomic) IBOutlet UIButton *phnConferencebtn;
@property (strong, nonatomic) IBOutlet UIButton *webinarbtn;
@property (strong, nonatomic) IBOutlet UIButton *eventTypebtn;
@property (strong, nonatomic) IBOutlet UIButton *dressCodebtn;
@property (strong, nonatomic) IBOutlet UILabel *broadcastYesSelcted;


@end
