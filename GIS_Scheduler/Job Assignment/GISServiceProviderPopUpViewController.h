//
//  GISServiceProviderPopUpViewController.h
//  GIS_Scheduler
//
//  Created by Paradigm on 12/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ListOfServiceProvidersProtocol <NSObject>

-(void)sendServiceProviderName:(NSString *)name_str :(NSString*)id_str;

@end
@interface GISServiceProviderPopUpViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *serviceProvider_tableView;
    
    IBOutlet UINavigationBar *navBar;
    
}
@property(nonatomic,strong)id <ListOfServiceProvidersProtocol> delegate_list;
@property(nonatomic,strong)NSMutableArray *popOverArray;
-(IBAction)doneButton_Pressed:(id)sender;
@end
