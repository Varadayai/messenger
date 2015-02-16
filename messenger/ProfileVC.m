//
//  ProfileVC.m
//  DealHunter
//
//  Created by Nishant Tyagi on 8/30/14.
//  Copyright (c) 2014 Leunack Systems. All rights reserved.
//

#import "ProfileVC.h"
#import "CommonFunctions.h"
#import "LoginVC.h"

@interface ProfileVC ()

@end

@implementation ProfileVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"Create Account";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
    self.navigationController.navigationBarHidden = YES;
    //[self.scrollView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_pattern"]]];
    [self.scrollView setBackgroundColor: [UIColor colorWithRed:250/255.0f green:250/255.0f blue:250/255.0f alpha:1.0f]];


    //[self backButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)signUpBtnTouched:(UIButton *)sender
{
    int tag = sender.tag;
    
    if(tag==3)
    {
        
        LoginVC *profile = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil];
       // [self.navigationController pushViewController:profile animated:YES];
        [SIDE_MENU_CONTROLLER presentCenterViewController:profile animated:YES];

        
        
    }


    else if (([[self.userNameTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) | ([[self.passwordTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) | ([[self.reEnterPwdTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0))
    {
       // [CommonFunctions alertTitle:@"Sorry" withMessage:@"Please fill all fields for registration." withDelegate:nil];
       // return;
    }
    else if (![[self.passwordTF text] isEqualToString:[self.reEnterPwdTF text]])
    {
       // [CommonFunctions alertTitle:@"Sorry" withMessage:@"Password does not match." withDelegate:nil];
       // return;
    }
//    if (![CommonFunctions reachabiltyCheck])
//    {
//        CustomAlert *alert = [[CustomAlert alloc] initWithTitle:@"Sorry" message:@"Internet connection failure" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//        [alert show];
//    }
    else if(tag==3)
    {

        LoginVC *profile = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil];
       // [self.navigationController pushViewController:profile animated:YES];
        [SIDE_MENU_CONTROLLER presentCenterViewController:profile animated:YES];


        
    }
}

#pragma -
#pragma mark UITextField Delegates

/* ============================== Text View Delegate Called When Begin Editing ============================== */
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"textViewDidBeginEditing");

    [self scrollViewToCenterOfScreen:textField];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return TRUE;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self.scrollView setContentOffset:CGPointZero animated:YES];

    [textField resignFirstResponder];
    return TRUE ;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return TRUE ;

}

- (void)scrollViewToCenterOfScreen:(UIView *)theView
{
    CGFloat viewCenterY = theView.center.y;
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
	
    CGFloat availableHeight = applicationFrame.size.height - 200;
    // Remove area covered by keyboard
	
    CGFloat y = viewCenterY - availableHeight / 2.0;
    if (y < 0)
    {
        y = 0;
    }
    [self.scrollView  setContentOffset:CGPointMake(0, y) animated:YES];
}




@end
