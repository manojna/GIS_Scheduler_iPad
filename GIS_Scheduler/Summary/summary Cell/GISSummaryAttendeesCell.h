//
//  GISSummaryAttendeesCell.h
//  GIS_Scheduler
//
//  Created by Anand on 18/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISSummaryAttendeesCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UILabel *modeOf_communication_label;
@property(nonatomic,strong)IBOutlet UILabel *directly_utilized_label;
@property(nonatomic,strong)IBOutlet UILabel *firstName_label;
@property(nonatomic,strong)IBOutlet UILabel *lastName_label;
@property(nonatomic,strong)IBOutlet UILabel *other_services_label;
@property(nonatomic,strong)IBOutlet UILabel *attendee_label;
@property(nonatomic,strong)IBOutlet UILabel *attendee_count_label;
@property(nonatomic,strong)IBOutlet UILabel *email_label;

@property(nonatomic,strong)IBOutlet UILabel *modeOf_communication_ans_label;
@property(nonatomic,strong)IBOutlet UILabel *directly_utilized_ans_label;
@property(nonatomic,strong)IBOutlet UILabel *firstName_ans_label;
@property(nonatomic,strong)IBOutlet UILabel *lastName_ans_label;
@property(nonatomic,strong)IBOutlet UILabel *other_services_ans_label;
@property(nonatomic,strong)IBOutlet UILabel *email_ans_label;

@end
