//
//  GISDashBoardListViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 09/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISDashBoardListViewController.h"
#import "GISConstants.h"
#import "GISFonts.h"
#import "GISDashBoardViewController.h"
#import "GISDatabaseManager.h"
#import "GISLoginViewController.h"
#import "GISServiceProviderRequestedJobsViewController.h"
#import "GISJobAssignmentViewController.h"
#import "GISFindRequestJobsViewController.h"


#define LOGOUT_TAG 1632

@interface GISDashBoardListViewController ()

@end

@implementation GISDashBoardListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if ([_dashBoard_ListTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_dashBoard_ListTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    hideClicked = NO;
    sectionhideClicked  = NO;
    rowClicked = NO;
    rowsectionClicked = NO;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(rowSelcted:) name:kRowSelected object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSIndexPath* selectedCellIndexPath= [NSIndexPath indexPathForRow:0 inSection:0];
    [self tableView:_dashBoard_ListTableView didSelectRowAtIndexPath:selectedCellIndexPath];
    [_dashBoard_ListTableView selectRowAtIndexPath:selectedCellIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(hideClicked || sectionhideClicked)
        return 13;
    
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 1){
        
        if(hideClicked)
            return 0;
        else
            return 3;
    }
    if(section == 2){
        
        if(sectionhideClicked)
            return 0;
        else
            return 2;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellHere"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
    }
    
    cell.backgroundColor = UIColorFromRGB(0x00457c);
    
    UIButton *cellButtonImage = [UIButton buttonWithType:UIButtonTypeCustom];
    cellButtonImage.frame = CGRectMake(8,8, 25, 25);
    _cellLabel = [[UILabel alloc]initWithFrame:CGRectMake(42,11, 250, 25)];
    _cellLabel.textColor = UIColorFromRGB(0xefefef);
    _cellLabel.tag = indexPath.row+1;
    [_cellLabel setFont:[GISFonts large]];
    [cellButtonImage setTag:indexPath.row+2];
    
    [cell addSubview:cellButtonImage];
    [cell addSubview:_cellLabel];
    
    if(indexPath.section == 0){
        _cellLabel.text = @"Dashboard";
        [cellButtonImage setBackgroundImage:[UIImage imageNamed:@"dashboard.png"] forState:UIControlStateNormal];
    }else if(indexPath.section == 3){
        _cellLabel.text = @"Find Requests/Jobs";
        [cellButtonImage setBackgroundImage:[UIImage imageNamed:@"find_requests_jobs.png"] forState:UIControlStateNormal];
    }else if(indexPath.section == 4){
        _cellLabel.text = @"Logout";
        [cellButtonImage setBackgroundImage:[UIImage imageNamed:@"logout.png"] forState:UIControlStateNormal];
    }else if(indexPath.section == 1){
        
        _cellLabel.frame = CGRectMake(55,11, 250, 25);
        
        if(indexPath.row == 0)
            _cellLabel.text = @"Add Service Request";
        if(indexPath.row == 1)
            _cellLabel.text = @"View/Edit Service Request";
        if(indexPath.row == 2)
            _cellLabel.text = @"Service Provider Requested Jobs";
    }else if(indexPath.section == 2){
        
        _cellLabel.frame = CGRectMake(55,11, 250, 25);
        
        if(indexPath.row == 0)
            _cellLabel.text = @"Job Assignment";
        if(indexPath.row == 1)
            _cellLabel.text = @"View/Edit Schedule";
    }

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView* headerView;
    
    headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel* headerLabel = [[UILabel alloc] init];
    headerLabel.frame = CGRectMake(42, 16, 320, 20);
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = UIColorFromRGB(0xefefef);
    headerLabel.font = [GISFonts large];
    [headerLabel setTextAlignment:NSTextAlignmentLeft];
    headerLabel.textColor = [UIColor whiteColor];
    [headerView setBackgroundColor:UIColorFromRGB(0x00457c)];
    
    UIButton *headerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    headerButton.tag = section;
    [headerButton addTarget:self action:@selector(hideRows:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:headerButton];
    
    UIButton *headerCellButton = [UIButton buttonWithType:UIButtonTypeCustom];
    headerCellButton.frame = CGRectMake(8,8, 25, 25);
    [headerCellButton setTag:section];
    
    if(section == 1){
        
        [headerView addSubview:headerLabel];
        [headerView addSubview:headerCellButton];
        headerLabel.text = @"Requests/Jobs";
        
        if(rowClicked){
            headerLabel.textColor = UIColorFromRGB(0xe8d3a4);
            [headerCellButton setBackgroundImage:[UIImage imageNamed:@"requests_jobs_pressed.png"] forState:UIControlStateNormal];
            [headerButton setBackgroundColor:UIColorFromRGB(0x00508f)];
        }
        else{
            headerLabel.textColor = UIColorFromRGB(0xefefef);
            [headerCellButton setBackgroundImage:[UIImage imageNamed:@"requests_jobs.png"] forState:UIControlStateNormal] ;
        }
        
        
    }else  if(section == 2){
        
        [headerView addSubview:headerLabel];
        [headerView addSubview:headerCellButton];
        headerLabel.text = @"Scheduling";
        if(rowsectionClicked){
            headerLabel.textColor = UIColorFromRGB(0xe8d3a4);
            [headerCellButton setBackgroundImage:[UIImage imageNamed:@"scheduling_pressed.png"] forState:UIControlStateNormal];
            [headerButton setBackgroundColor:UIColorFromRGB(0x00508f)];
        }
        else{
            headerLabel.textColor = UIColorFromRGB(0xefefef);
            [headerCellButton setBackgroundImage: [UIImage imageNamed:@"scheduling.png"] forState:UIControlStateNormal];
        }

    }else if(section == 0){
        
        UIImageView *labelImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 110, 50)];
        labelImageView.image = [UIImage imageNamed:@"logo.png"] ;
        [headerView addSubview:labelImageView];
        
        UILabel* headerLabel = [[UILabel alloc] init];
        headerLabel.frame = CGRectMake(222, 55, 125, 20);
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.font = [GISFonts large];
        [headerLabel setTextAlignment:NSTextAlignmentLeft];
        headerLabel.textColor = [UIColor whiteColor];
        NSString *versionNumber = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        headerLabel.text = [NSString stringWithFormat:@"Version  %@",versionNumber];
        
        [headerView addSubview:headerLabel];
        
    }else{
        
        [headerView setBackgroundColor:UIColorFromRGB(0x00457c)];
    }
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 80;
    if(section == 1)
        return 50;
    if(section == 2)
        return 50;
    return 0;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *currentSelectedIndexPath = [tableView indexPathForSelectedRow];
    if (currentSelectedIndexPath != nil)
    {
        [[tableView cellForRowAtIndexPath:currentSelectedIndexPath] setBackgroundColor:UIColorFromRGB(0x00457c)];
    }
    
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    rowClicked = NO;
    rowsectionClicked = NO;
    
    [_dashBoard_ListTableView reloadData];
    
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = UIColorFromRGB(0x00508f);
    
    UILabel *label = (UILabel *)[cell viewWithTag:indexPath.row+1];
    if(label != nil)
        label.textColor = UIColorFromRGB(0xe8d3a4);
    
    UIButton *cellBtn = (UIButton *)[cell viewWithTag:indexPath.row+2];
    
    if(cellBtn != nil){
        if(indexPath.section == 0){
            [cellBtn setBackgroundImage:[UIImage imageNamed:@"dashboard_pressed.png"] forState:UIControlStateNormal];
        }else if(indexPath.section == 3){
            [cellBtn setBackgroundImage:[UIImage imageNamed:@"find_requests_jobs_pressed.png"] forState:UIControlStateNormal];
        }else if(indexPath.section == 4){
            [cellBtn setBackgroundImage:[UIImage imageNamed:@"logout_pressed.png"] forState:UIControlStateNormal];
        }
    }

     if(indexPath.section == 4){
        //cell.contentView.backgroundColor = UIColorFromRGB(0x00457c);
        UIAlertView *alertVIew = [[UIAlertView alloc] initWithTitle:@"Logout:" message:@"Are you sure want to logout ?" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        alertVIew.tag = LOGOUT_TAG;
        alertVIew.delegate = self;
        [alertVIew show];
//         GISFindRequestJobsViewController *detailViewController = (GISFindRequestJobsViewController *)[[GISFindRequestJobsViewController alloc]initWithNibName:@"GISFindRequestJobsViewController" bundle:nil];
//         UINavigationController *detailView=[[UINavigationController alloc]initWithRootViewController:detailViewController];
//         
//         NSMutableArray* arr = [[NSMutableArray alloc] initWithArray:appDelegate.spiltViewController.viewControllers];
//         [arr replaceObjectAtIndex:1 withObject:detailView]; //index 1 corresponds to the detail VC
         
//         @try {
//             appDelegate.spiltViewController.viewControllers = arr;
//         }
//         @catch (NSException *exception) {
//             NSLog(@"Exception in ---- Dash Board --- appDelegate.spiltViewController.viewControllers = arr");
//         }
    }
   else
   {
            
       UINavigationController *navController=(UINavigationController *)[appDelegate.spiltViewController.viewControllers lastObject];
       
       for(UIViewController *viewcontroller in navController.viewControllers)
       {
           if([viewcontroller isKindOfClass:[GISDashBoardViewController class]])
           {
               GISDashBoardViewController *dashBoardViewController=(GISDashBoardViewController *)viewcontroller;
               [dashBoardViewController pushToViewController:indexPath.section rowValue:indexPath.row];
           }
       }
   }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [_dashBoard_ListTableView reloadData];
    
    if(alertView.tag == LOGOUT_TAG && buttonIndex == 1)
    {
        appDelegate.isLogout = YES;
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:kEmail];
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:kPassword];
        [[GISDatabaseManager sharedDataManager] reloadTheDatabaseFile];
        GISLoginViewController *loginView_controller=[[GISLoginViewController alloc]initWithNibName:@"GISLoginViewController" bundle:nil];
         appDelegate.window.rootViewController=loginView_controller;
        [appDelegate.window makeKeyAndVisible];
    }
}

-(IBAction)hideRows:(id)sender{
    
    if([sender tag] == 1){
        if(!hideClicked)
            hideClicked = YES;
        else
            hideClicked = NO;
        
        rowClicked = YES;
        rowsectionClicked = NO;
        
    }
    if([sender tag] == 2){
        if(!sectionhideClicked)
            sectionhideClicked = YES;
        else
            sectionhideClicked = NO;
        
        rowsectionClicked = YES;
        rowClicked = NO;
       
    }
    [_dashBoard_ListTableView reloadData];
}

-(void)rowSelcted:(NSNotification *) notification{
    
    NSDictionary *infoDict=notification.userInfo;
    
    BOOL isWhiteColorSelcted;
    
    if(infoDict != nil){
        isWhiteColorSelcted = [[infoDict objectForKey:@"isWhieColor"] boolValue];
    }else{
        isWhiteColorSelcted = NO;
    }
    
    if(isWhiteColorSelcted){

    
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        [self tableView:_dashBoard_ListTableView didSelectRowAtIndexPath:indexPath];
        
    }else{
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
        [self tableView:_dashBoard_ListTableView didSelectRowAtIndexPath:indexPath];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
