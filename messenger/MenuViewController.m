//
//  MenuViewController.m
//  messenger
//
//  Created by saurabh sindhu on 04/02/15.
//  Copyright (c) 2015 saurabh. All rights reserved.
//

#import "MenuViewController.h"
#import "HomeViewController.h"
#import "DealCustomCell.h"
#import "NewsFeedViewController.h"
#import "Notifications.h"
#import "GroupsViewController.h"
#import "ChatViewController.h"
#import "Newsfeed.h"



@interface MenuViewController ()

@property (nonatomic, strong) HomeViewController *homeViewController;


@end

@implementation MenuViewController

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
    
    self.navigationController.navigationBarHidden = YES;
    id desiredColor = [UIColor colorWithRed:0/255.0f green:131/255.0f blue:174/255.0f alpha:1.0f];
    
    tableDisplay.backgroundColor = desiredColor;
    tableDisplay.backgroundView.backgroundColor = desiredColor;
    
    allDataMA = [ @[@"My Profile", @"Groups" , @"Newsfeed",@"Messaging",@"Notifications"] mutableCopy ];
    
    allImages = [ @[@"my-profile-icon", @"group-icon" , @"newsfeed-icon",@"massaging-icon",@"notification-icon"] mutableCopy ];



}

#pragma mark -
#pragma mark UITableView Delegates -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [allDataMA count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    

    [cell setBackgroundColor:[UIColor clearColor]];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 4, 220, 30)];
    
    titleLabel.tag = 234234;
    titleLabel.backgroundColor = [UIColor clearColor];
    
    titleLabel.textColor = [UIColor whiteColor];
    [titleLabel setFont:[UIFont systemFontOfSize:13]];
    titleLabel.text = [allDataMA objectAtIndex:indexPath.row];

    
    [cell.contentView addSubview:titleLabel];
    
    UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(20, 8, 18, 20)];
    imgview.backgroundColor = [UIColor clearColor];
    
    NSString *cellIconName = [allImages objectAtIndex:[indexPath row]];
    UIImage *cellIcon = [UIImage imageNamed:cellIconName];
    [imgview setImage:cellIcon];
    
    [cell.contentView addSubview:imgview];

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    

    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
            
        case 0:
            
            newsfeed = [[NewsFeedViewController alloc] initWithNibName:@"NewsFeedViewController" bundle:nil];
            [SIDE_MENU_CONTROLLER presentCenterViewController:newsfeed animated:YES];
            
            break;
            
        case 1:
            
            groups = [[GroupsViewController alloc] initWithNibName:@"GroupsViewController" bundle:nil];
            [SIDE_MENU_CONTROLLER presentCenterViewController:groups animated:YES];
            

            
            break;
            
        case 2:
            
            news = [[Newsfeed alloc] initWithNibName:@"Newsfeed" bundle:nil];
            [SIDE_MENU_CONTROLLER presentCenterViewController:news animated:YES];

        
            break;
            
        case 3:
            
            chat = [[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:nil];
            [SIDE_MENU_CONTROLLER presentCenterViewController:chat animated:YES];

            
            break;
            
        case 4:
            
            
            notify = [[Notifications alloc] initWithNibName:@"Notifications" bundle:nil];
            [SIDE_MENU_CONTROLLER presentCenterViewController:notify animated:YES];
            
            
            break;

            
        default:
            break;
    }
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
