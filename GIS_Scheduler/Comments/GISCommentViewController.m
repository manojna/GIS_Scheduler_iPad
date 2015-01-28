//
//  GISCommentViewController.m
//  GIS_Scheduler
//
//  Created by Anand on 18/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISCommentViewController.h"
#import "GISCommentCell.h"
#import "GISConstants.h"
#import "GISFonts.h"
#import "GISStoreManager.h"

@interface GISCommentViewController ()

@end

@implementation GISCommentViewController

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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    [_commentTableView reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISCommentCell *commentCell;
        
    commentCell=(GISCommentCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return commentCell.frame.size.height;
}
    
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        GISCommentCell *cell;
        
        cell=(GISCommentCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if(cell==nil)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISCommentCell" owner:self options:nil]objectAtIndex:0];
        }
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        cell.commentTextView.delegate = self;
        cell.commentTextView.text = NSLocalizedStringFromTable(@"add_Comments", TABLE, nil);
        cell.commentTextView.textColor = UIColorFromRGB(0x00457c);
        [cell.commentTextView setFont:[GISFonts normal]];
    
    NSMutableArray *chooseReqDetailedArray=[[GISStoreManager sharedManager]getChooseRequestDetailsObjects];
    if (chooseReqDetailedArray.count>0) {
        _chooseRequestDetailsObj=[chooseReqDetailedArray lastObject];
    }
    cell.noComments_label.text = [self returningstring:_chooseRequestDetailsObj.adminComments_String_chooseReqParsedDetails];
    cell.commentTextView.text =[self returningstring:_chooseRequestDetailsObj.schedulerComments_String_chooseReqParsedDetails];
    
        return cell;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
        if ([textView.text isEqualToString:NSLocalizedStringFromTable(@"add_Comments", TABLE, nil)]) {
            textView.text = @"";
            textView.textColor = [UIColor blackColor];
        }
        [textView becomeFirstResponder];
}
    
- (void)textViewDidEndEditing:(UITextView *)textView
{
        if ([textView.text isEqualToString:@""]) {
            //textView.text = @"Add Comments";
            textView.textColor = UIColorFromRGB(0x00457c);
        }
        [textView resignFirstResponder];
}


-(NSString *)returningstring:(id)string
{
    if ([string length] == 0)
    {
        return @"";
    }
    else
    {
        if (![string isKindOfClass:[NSString class]])
        {
            NSString *str= [string stringValue];
            return str;
        }
        else
        {
            return string;
        }
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
