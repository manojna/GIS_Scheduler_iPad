//
//  GISDashBoardListViewController.h
//  GIS_Scheduler
//
//  Created by Paradigm on 09/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISAppDelegate.h"

@class GISDashBoardViewController;

@interface GISDashBoardListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    int rowCount;
    BOOL hideClicked;
    BOOL sectionhideClicked;
    BOOL rowClicked;
    BOOL rowsectionClicked;
    GISAppDelegate *appDelegate;
}

@property (nonatomic,strong)  IBOutlet UITableView *dashBoard_ListTableView;
@property (nonatomic,strong) IBOutlet UILabel *cellLabel;
@end
