//
//  GISLocationDetailsCell.h
//  GIS_Scheduler
//
//  Created by Anand on 17/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISLocationDetailsCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UILabel *locationDetailsOffcampus_label;
@property(nonatomic,strong)IBOutlet UILabel *buildingName_label;
@property(nonatomic,strong)IBOutlet UILabel *roomNo_label;
@property(nonatomic,strong)IBOutlet UILabel *roomName_label;
@property(nonatomic,strong)IBOutlet UILabel *other_label;
@property(nonatomic,strong)IBOutlet UILabel *socialProtocol_label;
@property(nonatomic,strong)IBOutlet UILabel *metroNearby_label;
@property(nonatomic,strong)IBOutlet UILabel *parking_label;
@property(nonatomic,strong)IBOutlet UILabel *garage_label;
@property(nonatomic,strong)IBOutlet UILabel *mattered_label;
@property(nonatomic,strong)IBOutlet UILabel *street_label;
@property(nonatomic,strong)IBOutlet UILabel *unknown_label;
@property(nonatomic,strong)IBOutlet UILabel *generalLocation_label;

@property (strong, nonatomic) IBOutlet UIButton *garageonCampusbtn;
@property (strong, nonatomic) IBOutlet UIButton *materedonCampusBtn;
@property (strong, nonatomic) IBOutlet UIButton *streetonCampusBtn;
@property (strong, nonatomic) IBOutlet UIButton *UnknownonCampusbtn;

@property (strong, nonatomic) IBOutlet UITextField *roomnotextField;
@property (strong, nonatomic) IBOutlet UITextField *roomNametextField;
@property (strong, nonatomic) IBOutlet UITextField *othertextField;
@property (strong, nonatomic) IBOutlet UITextView *specialProtocoltextView;
@property (strong, nonatomic) IBOutlet UIButton *buildingNamebtn;
@property(nonatomic,strong) IBOutlet UIButton *nextButton;

@end
