//
//  GISBaseViewController.m
//  Gallaudet-Interpreting-Service
//
//  Created by Anand on 13/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISBaseViewController.h"
#import "GISConstants.h"
#import "GISFonts.h"
#import "GISAppDelegate.h"


@interface GISBaseViewController ()

@end

@implementation GISBaseViewController

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
    
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    
    //add the your gestureRecognizer , where to detect the touch..
    [self.view addGestureRecognizer:rightRecognizer];
    
    self.navigationItem.title = @"Dashboard";
    
    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
    leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [leftRecognizer setNumberOfTouchesRequired:1];
    
    [self.view addGestureRecognizer:leftRecognizer];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectPopOver:) name:kSelectPopOver object:nil];
    
    UIPinchGestureRecognizer *twoFingerPinch = [[UIPinchGestureRecognizer alloc]
                                                initWithTarget:self
                                                action:@selector(handlePinch:)];
    
    [[self view] addGestureRecognizer:twoFingerPinch];

}

-(void)createCustomNavigationBar:(NSString *)title
{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:232.0f/255.0f green:212.0f/255.0f blue:146.0f/255.0f alpha:1.0f]}];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName : [GISFonts normal]}];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.0f/255.0f green:69.0f/255.0f blue:124.0f/255.0f alpha:1.0f];
    
    UIImage *btnImage = [UIImage imageNamed:@"done_icon.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(2,10, btnImage.size.width, btnImage.size.height);
    [button setBackgroundImage:btnImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(doneButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem=[[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem=rightBarItem;
    
    UIImage *btnImagee = [UIImage imageNamed:@"menu_icon.png"];
    UIButton *backButton=[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame=CGRectMake(0, 0, btnImagee.size.width, btnImagee.size.height)
    ;
    [backButton setImage:btnImagee forState:UIControlStateNormal];
    backButton.backgroundColor=[UIColor clearColor];
    [backButton addTarget:self action:@selector(menuTapped:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem=[[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem=leftBarItem;
    
   // self.navigationItem.title=title;
//    UINavigationBar *naviBarObj = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
//    [self.view addSubview:naviBarObj];
    
}

-(void)customDismissViewcontroller:(UIViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

-(void)doneButtonClicked:(id)sender{
    
}
-(void)menuTapped:(id)sender{
    
}

- (BOOL)splitViewController: (UISplitViewController*)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    return self.isMasterHide;
}


- (IBAction)hideAndUnHideMaster:(id)sender
{
    datListView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    UIButton *btn = (UIButton*)sender;
    GISAppDelegate *appDelegate1 = (GISAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.isMasterHide= isHide;
    NSString *buttonTitle = self.isMasterHide ? @""  : @"  ";//@""== Unhide   @"  "==Hide
    if (isHide)
    {
        dashBoard_UIView.hidden=NO;
        CGRect frame1=datListView.frame;
        frame1.origin.x=75;
        datListView.frame=frame1;
        
        dashBoard_UIView.hidden=NO;
    }
    else
    {
        dashBoard_UIView.hidden=YES;
        CGRect frame1=datListView.frame;
        frame1.origin.x=0;
        datListView.frame=frame1;
        
        dashBoard_UIView.hidden=YES;
        
    }
    
    [btn setTitle:buttonTitle forState:UIControlStateNormal];
    [ appDelegate1.spiltViewController.view setNeedsLayout ];
    appDelegate1.spiltViewController.delegate = self;
    
    [appDelegate1.spiltViewController willRotateToInterfaceOrientation:self.interfaceOrientation duration:0];
}

- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    NSLog(@"rightSwipeHandle");
    isHide = NO;
    [self performSelector:@selector(hideAndUnHideMaster:) withObject:nil];
}

- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    NSLog(@"leftSwipeHandle");
    isHide = YES;
    [self performSelector:@selector(hideAndUnHideMaster:) withObject:nil];
}

-(void)selectPopOver:(NSNotification *) notification{
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kSelectPopOver object:nil];
    
}

- (void)handlePinch:(UIPinchGestureRecognizer *)gestureRecognizer
{
    CGFloat mCurrentScale = 0.0;
    CGFloat mLastScale  = 0.0;
    
    NSLog(@"Pinch scale: %f", gestureRecognizer.scale);
    mCurrentScale += [gestureRecognizer scale] - mLastScale;
    mLastScale = [gestureRecognizer scale];
    
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            NSLog(@"Pinch start:");
        } break;
        case UIGestureRecognizerStateChanged:
        {
            //NSLog(@"scale = %f", recognizer.scale);
            NSLog(@"Pinch origin:");
            
        } break;
        case UIGestureRecognizerStateEnded:
        {
            NSLog(@"Pinch end:");
            mLastScale = 1.0;
            
            if(gestureRecognizer.scale < 1.0){
                mCurrentScale = 1.0;
            }
            if(gestureRecognizer.scale > 1.5){
                mCurrentScale = 1.0;
            }
        } break;
        default :
        {
            NSLog(@"other state");
        }
    }
    CGAffineTransform currentTransform = CGAffineTransformIdentity;
    //currentTransform = CGAffineTransformMakeRotation (M_PI * 270 / 180.0f);
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, mCurrentScale, mCurrentScale);
    self.view.transform = newTransform;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
