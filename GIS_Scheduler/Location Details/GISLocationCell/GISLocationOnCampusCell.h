//
//  GISLocationOnCampusCell.h
//  GIS_Scheduler
//
//  Created by Anand on 18/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISLocationOnCampusCell : UITableViewCell
    
@property(nonatomic,strong) IBOutlet UIButton *nextButton;

@property(nonatomic,strong)IBOutlet UILabel *locationDetailsOncampus_label;
@property(nonatomic,strong)IBOutlet UILabel *storeLocation_label;
@property(nonatomic,strong)IBOutlet UILabel *location_name_label;
@property(nonatomic,strong)IBOutlet UILabel *address1_label;
@property(nonatomic,strong)IBOutlet UILabel *address2_label;
@property(nonatomic,strong)IBOutlet UILabel *city_label;
@property(nonatomic,strong)IBOutlet UILabel *state_label;
@property(nonatomic,strong)IBOutlet UILabel *parking_label;
@property(nonatomic,strong)IBOutlet UILabel *garage_label;
@property(nonatomic,strong)IBOutlet UILabel *mattered_label;
@property(nonatomic,strong)IBOutlet UILabel *street_label;
@property(nonatomic,strong)IBOutlet UILabel *unknown_label;
@property(nonatomic,strong)IBOutlet UILabel *zip_label;
@property(nonatomic,strong)IBOutlet UILabel *closestmetro_label;
@property(nonatomic,strong)IBOutlet UILabel *specialProtocol_label;
@property(nonatomic,strong)IBOutlet UILabel *otherInfo_label;

@property (strong, nonatomic) IBOutlet UIButton *storeLocationbtn;
@property (strong, nonatomic) IBOutlet UIButton *closestMetrobtn;
@property (strong, nonatomic) IBOutlet UIButton *garagebtn;
@property (strong, nonatomic) IBOutlet UIButton *materedBtn;
@property (strong, nonatomic) IBOutlet UIButton *streetBtn;
@property (strong, nonatomic) IBOutlet UIButton *Unknownbtn;
@property (strong, nonatomic) IBOutlet UIButton *transportationyesBtn;
@property (strong, nonatomic) IBOutlet UIButton *transportationnoBtn;

@property (strong, nonatomic) IBOutlet UITextField *locationtextField;
@property (strong, nonatomic) IBOutlet UITextField *citytextField;
@property (strong, nonatomic) IBOutlet UITextField *statetextField;
@property (strong, nonatomic) IBOutlet UITextField *ziptextField;

@property (strong, nonatomic) IBOutlet UITextView *address1Textview;
@property (strong, nonatomic) IBOutlet UITextView *address2Textview;
@property (strong, nonatomic) IBOutlet UITextView *specialTextview;
@property (strong, nonatomic) IBOutlet UITextView *otherinfoTextview;




@end
