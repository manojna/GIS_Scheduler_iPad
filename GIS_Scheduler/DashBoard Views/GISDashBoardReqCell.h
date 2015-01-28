//
//  GISDashBoardReqCell.h
//  GIS_Scheduler
//
//  Created by Anand on 01/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISDashBoardReqCell : UITableViewCell

@property(nonatomic,strong) IBOutlet UILabel *accountName_Label;
@property(nonatomic,strong) IBOutlet UILabel *requestID_Label;
@property(nonatomic,strong) IBOutlet UILabel *eventType_Label;
@property(nonatomic,strong) IBOutlet UILabel *otherServices_Label;
@property(nonatomic,strong) IBOutlet UILabel *requestSubmissinDate_Label;
@property(nonatomic,strong) IBOutlet UILabel *dateOfEarlier_Label;
@property(nonatomic,strong) IBOutlet UILabel *status_Label;
@property(nonatomic,strong) IBOutlet UILabel *scheduler_Label;




@end
