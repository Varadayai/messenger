//
//  LoginVC.m
//  App Reader
//
//  Created by Nishant Tyagi on 7/12/13.
//  Copyright (c) 2013 Nishant Tyagi. All rights reserved.
//

#import "LoginVC.h"
#import <QuartzCore/QuartzCore.h>
#import "CommonFunctions.h"
#import "ProfileVC.h"
#import "RootViewController.h"
#import "ChatViewController.h"



@interface LoginVC ()
{
    UIView *vwLoader;
}

@end

@implementation LoginVC

@synthesize IsOfflineSelected,IsOnlineSelected,usernameTF,passwordTF;

int Flag=0;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [[self.navigationController navigationBar] setTranslucent:NO];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeBottom;   // iOS 7 specific
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //fb stuff goes here
    self.lblLoginStatus.text = @"";
    
    
    
   // self.loginButton.delegate = self;

    
	// Do any additional setup after loading the view.
    self.navigationItem.title = @"Login";

    self.navigationController.navigationBarHidden = YES;
    //[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login-bg"]]];
    [self.scrollView setBackgroundColor: [UIColor colorWithRed:250/255.0f green:250/255.0f blue:250/255.0f alpha:1.0f]];

    
    
}




-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:NO];
    [self.navigationController.navigationBar setHidden:YES];


//    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    
    [self.navigationController.navigationBar setHidden:YES];
    
    // Get the stored data before the view loads
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *username = [defaults objectForKey:@"userName"];
    NSString *password = [defaults objectForKey:@"passCode"];
    
    usernameTF.text=username;
    passwordTF.text=password;
    
    
}

//linkedin

- (IBAction)share:(id)sender {
	
}

- (void)shareCompleted
{
	NSLog(@"shareCompleted called");
}



-(void)forgotpasCode{
    
    NSLog(@"Pass%@", self.lblEmail.text);
    
   


}




-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [self.navigationController.navigationBar setHidden:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setUsernameTF:nil];
    [self setPasswordTF:nil];
    [self setForgotPasswordTF:nil];
    [self setLoginBtn:nil];
    [self setForgotEmailTF:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
}

#pragma mark -
#pragma mark - FETCHING DATA  -






- (IBAction)commonBtnTouched:(UIButton *)sender {
    
    int tag = sender.tag;
    
    switch (tag) {
        case 1:
        {
            
            if (([[self.usernameTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) | ([[self.passwordTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0))
            {
               [CommonFunctions alertTitle:@"Sorry" withMessage:@"Please enter email and password to continue." withDelegate:nil];
                return;
            }

            [self.scrollView setContentOffset:CGPointZero animated:YES];
            
            [self.passwordTF resignFirstResponder];
            [self.usernameTF resignFirstResponder];
            
            

            
        }
        break;
            
        case 2:
        {
            
            ChatViewController *chat = [[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:nil];
            
            
            [SIDE_MENU_CONTROLLER presentCenterViewController:chat animated:YES];
     
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
          
            ProfileVC *profile = [[ProfileVC alloc] initWithNibName:@"ProfileVC" bundle:nil];
           // [self.navigationController pushViewController:profile animated:YES];
            
            
            [SIDE_MENU_CONTROLLER presentCenterViewController:profile animated:YES];


            
        }
            break;
         case 5:
        {
            
//            FPassword *passcode = [[FPassword alloc] initWithNibName:@"FPassword" bundle:nil];
//            [self.navigationController pushViewController:passcode animated:YES];

            
        }
            break;
            
        case 6:
        {
//            ProfileVC *tempVC = [[ProfileVC alloc] initWithNibName:@"ProfileVC" bundle:nil];
//            [self.navigationController pushViewController:tempVC animated:YES];
        }
            break;

        default:
            break;
    }
}

-(IBAction)rememberPass:(UIButton *)sender{
  
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];


    [sender setSelected:!sender.isSelected] ;
    
    if ((sender.isSelected)) {
        
        [defaults setObject:usernameTF.text forKey:@"userName"];
        [defaults setObject:passwordTF.text forKey:@"passCode"];
        

    }
    else
    {
        [defaults setObject:@"" forKey:@"userName"];
        [defaults setObject:@"" forKey:@"passCode"];
    }
    [defaults synchronize];

}

#pragma mark - WEB SERVICE -



- (IBAction)closeBtnTouched:(UIButton *)sender {
    [self.popUpView setHidden:YES];
    [self.popUpView endEditing:YES];
    [self.popUpView2 setHidden:YES];
    [self.popUpView2 endEditing:YES];

}

-(void)hideLoader
{
    if(vwLoader)
    {
        [vwLoader.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [vwLoader removeFromSuperview];
        vwLoader = nil;
    }

}
-(void)showLoader
{
    [self hideLoader];
    vwLoader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    vwLoader.backgroundColor = [[UIColor clearColor] colorWithAlphaComponent:0.4];
    [self.view addSubview:vwLoader];
    
}


- (IBAction)sendPwdBtnTouched:(UIButton *)sender {
    
   }

-(void)sendEmailToServer:(UIButton *)sender
{    
   }

#pragma mark -
#pragma mark - Other Methods
//add alert like animation

- (void) attachPopUpAnimation : (UIView *) PopUpView
{

    [PopUpView setHidden:NO];

    CAKeyframeAnimation *animation = [CAKeyframeAnimation
                                      animationWithKeyPath:@"transform"];
    
    CATransform3D scale1 = CATransform3DMakeScale(0.5, 0.5, 1);
    CATransform3D scale2 = CATransform3DMakeScale(1.2, 1.2, 1);
    CATransform3D scale3 = CATransform3DMakeScale(0.9, 0.9, 1);
    CATransform3D scale4 = CATransform3DMakeScale(1.0, 1.0, 1);
    
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3],
                            [NSValue valueWithCATransform3D:scale4],
                            nil];
    [animation setValues:frameValues];
    
    NSArray *frameTimes = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.5],
                           [NSNumber numberWithFloat:0.9],
                           [NSNumber numberWithFloat:1.0],
                           nil];
    [animation setKeyTimes:frameTimes];
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = .5;
    
    [PopUpView.layer addAnimation:animation forKey:@"popup"];
}

# pragma mark -
# pragma mark -  UITextField Delegates -

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{

    
    [self scrollViewToCenterOfScreen:textField];
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:self.usernameTF])
    {
        [self .passwordTF becomeFirstResponder];
        [self scrollViewToCenterOfScreen:textField];
    }
    else
    {
        [textField resignFirstResponder];
        [self.scrollView setContentOffset:CGPointZero animated:YES];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:self.usernameTF] )
	{
        [self.usernameTF resignFirstResponder];
        
        [self scrollViewToCenterOfScreen:self.passwordTF];
                
	}
    else if([textField isEqual:self.passwordTF])
    {
        [textField resignFirstResponder];
        [self.scrollView setContentOffset:CGPointZero animated:YES];
    }
    else
    {
        [textField resignFirstResponder];
        
        [UIView animateWithDuration:0.4f
                         animations:^(void) {
                             CGRect rect = self.popUpView.frame;
                             
                             rect.origin.y = -10.0f;
                             
                             self.popUpView.frame = rect;
                         }];
    }
    
    return YES;
}


- (void)scrollViewToCenterOfScreen:(UIView *)theView
{
    CGFloat viewCenterY = theView.center.y;
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
	
    CGFloat availableHeight = applicationFrame.size.height - 300;            // Remove area covered by keyboard
	
    CGFloat y = viewCenterY - availableHeight / 2.0;
    if (y < 0)
    {
        y = 0;
    }
    [self.scrollView  setContentOffset:CGPointMake(0, y+20) animated:YES];
}

#pragma mark-
#pragma mark-
@end
