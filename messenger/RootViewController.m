//
//  RootViewController.m
//  messenger
//
//  Created by saurabh sindhu on 04/02/15.
//  Copyright (c) 2015 saurabh. All rights reserved.
//

#import "RootViewController.h"
#import "PZSideMenuViewController.h"
#import "ChatViewController.h"
#import "MenuViewController.h"

@interface RootViewController ()

@property (nonatomic, strong) PZSideMenuViewController *sideMenuViewController;


@end

@implementation RootViewController



- (id)init
{
    
   self = [super initWithNibName:@"RootViewController" bundle:nil];
        
  
    if (self)
    {
        
      
            
            // Prepare side menu view controller
            _sideMenuViewController = [[PZSideMenuViewController alloc] initWithCenterViewController:[[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:nil]];
            _sideMenuViewController.leftViewController = [[UINavigationController alloc] initWithRootViewController:[[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil]];
            
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _sideMenuViewController = [[PZSideMenuViewController alloc] initWithCenterViewController:[[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:nil]];
    _sideMenuViewController.leftViewController = [[UINavigationController alloc] initWithRootViewController:[[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil]];
    
    [self addChildViewController:_sideMenuViewController];
    [self.view addSubview:_sideMenuViewController.view];
    _sideMenuViewController.view.frame = self.view.bounds;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
