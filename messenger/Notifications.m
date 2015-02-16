//
//  Notifications.m
//  messenger
//
//  Created by saurabh sindhu on 13/02/15.
//  Copyright (c) 2015 saurabh. All rights reserved.
//

#import "Notifications.h"

@interface Notifications ()

@end

@implementation Notifications

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)openLeft
{
    [SIDE_MENU_CONTROLLER openLeftSideViewControllerAnimated:YES completion:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
