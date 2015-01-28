//
//  AppDelegate.m
//  GIS_Scheduler
//
//  Created by Paradigm on 08/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISAppDelegate.h"
#import "GISDashBoardViewController.h"
#import "GISDashBoardListViewController.h"
#import "GISLoginViewController.h"
#import "GISConstants.h"
#import "GISFonts.h"
#import "GISAttendeesViewController.h"

@implementation GISAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    _attendeesArray = [[NSMutableArray alloc] init];
    _datesArray = [[NSMutableArray alloc] init];
    _detailArray = [[NSMutableArray alloc] init];
    _jobEventsArray = [[NSMutableArray alloc] init];
    _addNewJob_dictionary=[[NSMutableDictionary alloc]init];
    _jobDetailsArray = [[NSMutableArray alloc] init];
    _payTypeArray = [[NSMutableArray alloc] init];
    _serviceTypeArray = [[NSMutableArray alloc] init];
    _monthEventsArray = [[NSMutableArray alloc] init];
    _showEventsArray = [[NSMutableArray alloc] init];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.spiltViewController = [[UISplitViewController alloc] init];
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSString *email = [userDefaults valueForKey:kEmail];
    NSString *password = [userDefaults valueForKey:kPassword];

    
    self.detailViewController = (GISDashBoardViewController *)[[GISDashBoardViewController alloc]initWithNibName:@"GISDashBoardViewController" bundle:nil];
    GISDashBoardListViewController *masterViewController = [[GISDashBoardListViewController alloc]initWithNibName:@"GISDashBoardListViewController" bundle:nil];

    
    UINavigationController *masterView=[[UINavigationController alloc]initWithRootViewController:masterViewController];
    UINavigationController *detailView=[[UINavigationController alloc]initWithRootViewController:self.detailViewController];
    
    GISLoginViewController *loginViewController = [[GISLoginViewController alloc]initWithNibName:@"GISLoginViewController" bundle:nil];

    self.spiltViewController.delegate = self;
    self.spiltViewController.viewControllers = [NSArray arrayWithObjects:masterView,detailView,nil];
    if([email length]>0 && [password length]>0){
        
        [self.window setRootViewController:self.spiltViewController];

        
    }else{

        [self.window setRootViewController:loginViewController];

    }
    
    [self.navigationcontroller.navigationBar setTranslucent:NO];
    
    //[[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0xeef7fa)];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:247.0f/255.0f alpha:1.0f]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      UIColorFromRGB(0x00457c), NSForegroundColorAttributeName,
      [GISFonts larger], NSFontAttributeName,nil]];
    
    self.isLogout = NO;
    self.isContact = NO;
    self.isFromViewEditService = NO;
    
    self.isDateView = NO;
    self.isMonthView = NO;
    self.isWeekView = NO;
    self.isNoofAttendees = NO;
    self.isShowfromDashboard = NO;
    self.isHidefromDashboard = NO;
    self.isfilled = NO;
    self.islatestEvent = NO;
    self.isRefreshIndex = NO;
    self.isShowfromSPRequestedJobs = NO;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)splitViewController: (UISplitViewController*)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    return YES;
}

@end
