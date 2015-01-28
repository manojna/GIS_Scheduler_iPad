//
//  GISViewEditListVIewCell.h
//  GIS_Scheduler
//
//  Created by Anand on 16/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISViewEditListVIewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *jobName;
@property (strong, nonatomic) IBOutlet UILabel *eventTime;
@property (strong, nonatomic) IBOutlet UILabel *eventTitle;

@end
