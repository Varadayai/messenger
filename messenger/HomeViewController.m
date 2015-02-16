//
//  HomeViewController.m
//  messenger
//
//  Created by saurabh sindhu on 04/02/15.
//  Copyright (c) 2015 saurabh. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginVC.h"
#import "ProfileVC.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

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
    
    [self.navigationController.navigationBar setHidden:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];


    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    
    [self.navigationController.navigationBar setHidden:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    

}

-(IBAction)login:(id)sender{
    
    LoginVC *profile = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil];
    [self.navigationController pushViewController:profile animated:YES];

    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:NO];
    
    [self.navigationController.navigationBar setHidden:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];

    
}

-(IBAction)signup:(id)sender{
    
    ProfileVC *profile = [[ProfileVC alloc] initWithNibName:@"ProfileVC" bundle:nil];
    [self.navigationController pushViewController:profile animated:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
