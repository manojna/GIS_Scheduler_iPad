//
//  GISCommentCell.h
//  GIS_Scheduler
//
//  Created by Anand on 18/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISCommentCell : UITableViewCell
    

@property (nonatomic,strong) IBOutlet UITextView *commentTextView;

@property(nonatomic,strong)IBOutlet UILabel *accountsAdministration_label;
@property(nonatomic,strong)IBOutlet UILabel *noComments_label;
@property(nonatomic,strong)IBOutlet UILabel *scheduler_label;

@end
