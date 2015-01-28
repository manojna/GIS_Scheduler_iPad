//
//  GISDatesTimesDetailCell.h
//  GIS_Scheduler
//
//  Created by Paradigm on 18/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISDatesTimesDetailCell : UITableViewCell
@property(nonatomic,strong) IBOutlet UILabel *saveLabel;
@property(nonatomic,strong) IBOutlet UILabel *cancelLabel;
@property(nonatomic,strong) IBOutlet UILabel *dateLabel;
@property(nonatomic,strong) IBOutlet UILabel *dayLabel;
@property(nonatomic,strong) IBOutlet UILabel *startTime_Label;
@property(nonatomic,strong) IBOutlet UILabel *endTimeLabel;
@property(nonatomic,strong) IBOutlet UIButton *editButton;
@property(nonatomic,strong) IBOutlet UIButton *deleteButton;
@property(nonatomic,strong) IBOutlet UIImageView *edit_imageView;
@property(nonatomic,strong) IBOutlet UIImageView *delete_imageview;

@property(nonatomic,strong)IBOutlet UIView *saveCancel_UIview;
@property(nonatomic,strong)IBOutlet UIView *date_UIview;
@property(nonatomic,strong)IBOutlet UIView *startTime_UIview;
@property(nonatomic,strong)IBOutlet UIView *endTime_UIview;

@property(nonatomic,strong)IBOutlet UITextField *date_TextField;
@property(nonatomic,strong)IBOutlet UITextField *startTime_TextField;
@property(nonatomic,strong)IBOutlet UITextField *endTime_TextField;

@property(nonatomic,strong)IBOutlet UIButton *date_edit_button_detailView;
@property(nonatomic,strong)IBOutlet UIButton *startTime_edit_button_detailView;
@property(nonatomic,strong)IBOutlet UIButton *endTime_edit_button_detailView;

@property(nonatomic,strong)IBOutlet UIButton *save_button_detailView;
@property(nonatomic,strong)IBOutlet UIButton *cancel_button_detailView;
@end
