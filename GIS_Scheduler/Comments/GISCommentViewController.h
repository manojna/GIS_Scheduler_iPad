//
//  GISCommentViewController.h
//  GIS_Scheduler
//
//  Created by Anand on 18/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISChooseRequestDetailsObject.h"

@interface GISCommentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>

@property(nonatomic,strong)GISChooseRequestDetailsObject *chooseRequestDetailsObj;
@property(nonatomic,strong) IBOutlet UITableView *commentTableView;

@end
