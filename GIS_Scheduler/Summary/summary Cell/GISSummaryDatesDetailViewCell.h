//
//  GISSummaryDatesDetailViewCell.h
//  GIS_Scheduler
//
//  Created by Anand on 18/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISSummaryDatesDetailViewCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UILabel *date_label;
@property(nonatomic,strong)IBOutlet UILabel *day_label;
@property(nonatomic,strong)IBOutlet UILabel *startTime_label;
@property(nonatomic,strong)IBOutlet UILabel *endTime_label;

@end
