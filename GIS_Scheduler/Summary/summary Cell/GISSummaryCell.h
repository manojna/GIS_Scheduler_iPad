//
//  GISSummaryCell.h
//  GIS_Scheduler
//
//  Created by Anand on 18/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISSummaryCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UILabel *requestor_label;
@property(nonatomic,strong)IBOutlet UILabel *unitacNumber_label;
@property(nonatomic,strong)IBOutlet UILabel *firstName_label;
@property(nonatomic,strong)IBOutlet UILabel *lastName_label;
@property(nonatomic,strong)IBOutlet UILabel *email_label;
@property(nonatomic,strong)IBOutlet UILabel *zip_label;
@property(nonatomic,strong)IBOutlet UILabel *address1_label;
@property(nonatomic,strong)IBOutlet UILabel *address2_label;
@property(nonatomic,strong)IBOutlet UILabel *city_label;
@property(nonatomic,strong)IBOutlet UILabel *state_label;
@property(nonatomic,strong)IBOutlet UILabel *section_label;

@property(nonatomic,strong)IBOutlet UILabel *requestor_ans_label;
@property(nonatomic,strong)IBOutlet UILabel *unitacNumber_ans_label;
@property(nonatomic,strong)IBOutlet UILabel *firstName_ans_label;
@property(nonatomic,strong)IBOutlet UILabel *lastName_ans_label;
@property(nonatomic,strong)IBOutlet UILabel *email_ans_label;
@property(nonatomic,strong)IBOutlet UILabel *zip_ans_label;
@property(nonatomic,strong)IBOutlet UILabel *address1_ans_label;
@property(nonatomic,strong)IBOutlet UILabel *address2_ans_label;
@property(nonatomic,strong)IBOutlet UILabel *city_ans_label;
@property(nonatomic,strong)IBOutlet UILabel *state_ans_label;
@property(nonatomic,strong)IBOutlet UILabel *section_ans_label;

@property(nonatomic,strong)IBOutlet UIButton *edit_button;
@property(nonatomic,strong)IBOutlet UITextView *descriptionTextview;
@end
