//
//  GISPopOverTableViewController.h
//  GIS_Scheduler
//
//  Created by Paradigm on 21/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISAppDelegate.h"

@protocol PopOverSelected_Protocol <NSObject>
-(void)sendTheSelectedPopOverData: (NSString *)id_str value:(NSString *)value_str;
@end
@interface GISPopOverTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
{
    IBOutlet UITableView *popOverTableView;

    GISAppDelegate *appDelegate;
    
    UIDatePicker *datePicker;
    
    NSDateFormatter *dateformatter;
    
    IBOutlet UISearchBar *popOverSearchBar;
    
}
//+(GISPopOverTableViewController *)sharedManager;
@property(readwrite,nonatomic)int tagValue;
@property(nonatomic,strong)NSString *view_String;
@property(nonatomic,strong)NSString *value_String;
@property(nonatomic,strong)NSString *dateTimeMoveUp_string;
@property(nonatomic,strong) IBOutlet UITableView *popOverTableView;
@property(nonatomic,strong) IBOutlet UITableView *popOver_TableView;

@property(nonatomic,strong) id <PopOverSelected_Protocol> popOverDelegate;
@property(nonatomic,strong)NSMutableArray *popOverArray;
@property (weak,nonatomic) IBOutlet NSLayoutConstraint *tableHeightConstraint;
@property(nonatomic,strong)NSMutableArray *noOfAttendeesIdArray;
@property (strong,nonatomic) NSMutableArray *filteredArray;
@property(nonatomic,strong) IBOutlet UIView *popOverView;

@end
