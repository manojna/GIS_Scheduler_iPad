//
//  GISSummaryRequestModificationCell.h
//  GIS_Scheduler
//
//  Created by Anand on 30/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISSummaryRequestModificationCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UITextView *addnotes_textView;
@property(nonatomic,strong)IBOutlet UILabel *request_label;
@property(nonatomic,strong)IBOutlet UIButton *checkButton;

@end
