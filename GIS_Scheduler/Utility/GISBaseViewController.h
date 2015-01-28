//
//  GISBaseViewController.h
//  Gallaudet-Interpreting-Service
//
//  Created by Anand on 13/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISBaseViewController : UIViewController<UISplitViewControllerDelegate>
{
    IBOutlet UIView *datListView;
    IBOutlet UIView *dashBoard_UIView;
    BOOL isHide;
}

-(void)createCustomNavigationBar:(NSString *)title;
-(IBAction)menuTapped:(id)sender;
-(IBAction)doneButtonClicked:(id)sender;
-(void)selectPopOver:(NSNotification *) notification;
- (IBAction)hideAndUnHideMaster:(id)sender;
@property(nonatomic,readwrite) BOOL isMasterHide;


@end
