//
//  GISServiceProviderPopUpViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 12/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISServiceProviderPopUpViewController.h"
#import "GISJobAssignmentCell.h"
#import "GISJobAssignmentViewController.h"
#import "GISServiceProviderObject.h"

@interface GISServiceProviderPopUpViewController ()

@end

@implementation GISServiceProviderPopUpViewController
@synthesize popOverArray;

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
    // Do any additional setup after loading the view from its nib.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.popOverArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISJobAssignmentCell *cell=(GISJobAssignmentCell *)[tableView dequeueReusableCellWithIdentifier:@"SPCell"];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"GISServiceProviderCell" owner:self options:nil] objectAtIndex:0];
    }
    GISServiceProviderObject *spObj=[self.popOverArray objectAtIndex:indexPath.row];
    cell.serviceProvider_JobAssignment_label.text=spObj.service_Provider_String;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
      return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISServiceProviderObject *spObj=[self.popOverArray objectAtIndex:indexPath.row];
    [_delegate_list sendServiceProviderName:spObj.service_Provider_String :spObj.id_String];
}

-(IBAction)doneButton_Pressed:(id)sender
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
