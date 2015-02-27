//
//  GroupsViewController.m
//  messenger
//
//  Created by saurabh sindhu on 14/02/15.
//  Copyright (c) 2015 saurabh. All rights reserved.
//

#import "GroupsViewController.h"
#import "SWRevealTableViewCell.h"
#import "LoginVC.h"


@interface GroupsViewController ()<SWRevealTableViewCellDelegate,SWRevealTableViewCellDataSource,UIActionSheetDelegate>
{
    NSIndexPath *_revealingCellIndexPath;
    NSInteger _sectionTitleRowCount;
}

@end

@implementation GroupsViewController

typedef enum
{
    SectionTitle = 0,
    SectionImage,
    SectionsCount,
} Sections;


static NSString *RevealCellReuseIdentifier = @"RevealCellReuseIdentifier";


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
    
    _sectionTitleRowCount = 2;

    // Do any additional setup after loading the view from its nib.
}

-(IBAction)buttonSlide:(id)sender{
    

    [SIDE_MENU_CONTROLLER openLeftSideViewControllerAnimated:YES completion:nil];
   
    
}

-(IBAction)logout:(id)sender{
    
    LoginVC *login = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil];
    
    [SIDE_MENU_CONTROLLER presentCenterViewController:login animated:YES];
  
    
}

-(IBAction)addMembers:(id)sender{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invitation" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add Members",@"Invite Members via Email",@"Invite Guests via Email", nil];
    
    [alert show];
}

-(IBAction)buttonSel:(UIButton*)sender{
    
    if (sender.tag==1) {
        
        [line1 setHidden:NO];
        
        [line2 setHidden:YES];
        
        members.textColor = [UIColor colorWithRed:0/255.f green:123/255.f blue:168/255.f alpha:1];

        conv.textColor = [UIColor colorWithRed:224/255.f green:224/255.f blue:224/255.f alpha:1];
        
        
    }
    
    else if (sender.tag==2){
        
        [line1 setHidden:YES];
        
        [line2 setHidden:NO];
  
        conv.textColor = [UIColor colorWithRed:0/255.f green:123/255.f blue:168/255.f alpha:1];
        
        members.textColor = [UIColor colorWithRed:224/255.f green:224/255.f blue:224/255.f alpha:1];
        
        
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return SectionsCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _sectionTitleRowCount;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWRevealTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RevealCellReuseIdentifier];
    if ( cell == nil )
    {
        cell = [[SWRevealTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:RevealCellReuseIdentifier];
    }
    
    cell.delegate = self;
    cell.dataSource = self;
    
    if ( indexPath.section == SectionTitle)
    {
        cell.cellRevealMode = SWCellRevealModeReversedWithAction;
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    // Configure the cell...
    //  cell.detailTextLabel.text = @"Detail text";
    
    //    cell.textLabel.text = [NSString stringWithFormat:@"My cell content %ld", (long)indexPath.section];
    
    
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 15, cell.bounds.size.width-60, 15)];
    
    detailLabel.tag = 345345;
    detailLabel.backgroundColor = [UIColor clearColor];
    
    detailLabel.textColor = [UIColor blackColor];
    [detailLabel setFont:[UIFont boldSystemFontOfSize:11]];
    detailLabel.layer.shadowColor = [[UIColor whiteColor] CGColor];
    detailLabel.layer.shadowOpacity = 0.7;
    detailLabel.layer.shouldRasterize=YES;
    detailLabel.text = @"Alexender Wilson";
    [cell.contentView addSubview:detailLabel];
    
    
    
    UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 30, 35)];
    imgview.backgroundColor = [UIColor clearColor];
    imgview.layer.borderWidth = 1.0;
    imgview.userInteractionEnabled = NO;
    imgview.layer.cornerRadius =YES;
    [imgview setImage: [UIImage imageNamed:@"avatar"]];
    
    [cell.contentView addSubview:imgview];
    
//    UIButton   * checkBox=[UIButton buttonWithType:UIButtonTypeCustom];
//    checkBox.tag=indexPath.row;
//    checkBox.frame=CGRectMake(270,15, 20, 20);
//    [cell.contentView addSubview:checkBox];
//    [checkBox setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//    [checkBox addTarget:self action:@selector(checkBoxClicked:) forControlEvents:UIControlEventTouchUpInside];
    
   // [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    return cell;
}

-(void)checkBoxClicked:(id)sender{
    
    UIButton *tappedButton = (UIButton*)sender;
    
    if([tappedButton.currentImage isEqual:[UIImage imageNamed:@""]]) {
        [sender  setImage:[UIImage imageNamed: @"right-mark.png"] forState:UIControlStateNormal];
    }
    
    else {
        [sender setImage:[UIImage imageNamed:@""]forState:UIControlStateNormal];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 65;
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


#pragma mark - SWRevealTableViewCell delegate

- (void)revealTableViewCell:(SWRevealTableViewCell *)revealTableViewCell willMoveToPosition:(SWCellRevealPosition)position
{
    if ( position == SWCellRevealPositionCenter )
        return;
    
    for ( SWRevealTableViewCell *cell in [memberTable visibleCells] )
    {
        if ( cell == revealTableViewCell )
            continue;
        
        [cell setRevealPosition:SWCellRevealPositionCenter animated:YES];
    }
}


- (void)revealTableViewCell:(SWRevealTableViewCell *)revealTableViewCell didMoveToPosition:(SWCellRevealPosition)position
{
    
}


#pragma mark - SWRevealTableViewCell data source

- (NSArray*)leftButtonItemsInRevealTableViewCell:(SWRevealTableViewCell *)revealTableViewCell
{
    SWCellButtonItem *item1 = [SWCellButtonItem itemWithTitle:@"Select" handler:^(SWCellButtonItem *item, SWRevealTableViewCell *cell)
                               {
                                   NSLog( @"Select Tapped");
                                   return YES;
                               }];
    
    item1.backgroundColor = [UIColor colorWithRed:0 green:0.5 blue:1 alpha:1];
    item1.tintColor = [UIColor whiteColor];
    item1.width = 50;
    
    SWCellButtonItem *item2 = [SWCellButtonItem itemWithTitle:@"Snap" handler:^(SWCellButtonItem *item, SWRevealTableViewCell *cell)
                               {
                                   NSLog( @"Snap Tapped");
                                   return YES;
                               }];
    
    item2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:1];
    item2.image = [UIImage imageNamed:@"heart.png"];
    item2.width = 50;
    item2.tintColor = [UIColor whiteColor];
    
    NSLog( @"Providing left Items");
    return @[item1,item2];
}


- (NSArray*)rightButtonItemsInRevealTableViewCell:(SWRevealTableViewCell *)revealTableViewCell
{
    NSArray *items = nil;
    NSIndexPath *indexPath = [memberTable indexPathForCell:revealTableViewCell];
    NSInteger section = indexPath.section;
    
    if ( section == SectionTitle )
    {
        SWCellButtonItem *item1 = [SWCellButtonItem itemWithTitle:@"Remove" handler:^(SWCellButtonItem *item, SWRevealTableViewCell *cell)
                                   {
                                       _revealingCellIndexPath = [memberTable indexPathForCell:cell];
                                       [self presentDeleteActionSheetForItem:item];
                                       return NO;
                                   }];
        
        item1.backgroundColor = [UIColor redColor];
        item1.tintColor = [UIColor whiteColor];
        item1.width = 75;
        
        SWCellButtonItem *item2 = [SWCellButtonItem itemWithTitle:@"Mark Owner" handler:^(SWCellButtonItem *item, SWRevealTableViewCell *cell)
                                   {
                                       _revealingCellIndexPath = [memberTable indexPathForCell:cell];
                                       [self presentRenameActionSheetForItem:item];
                                       return NO;
                                   }];
        
        item2.backgroundColor = [UIColor colorWithRed:0.0/255.f green:131.0/255.f blue:174.0/255.f alpha:1];
        item2.tintColor = [UIColor whiteColor];
        item2.width = 75;
        
        //        SWCellButtonItem *item3 = [SWCellButtonItem itemWithTitle:@"More" handler:^(SWCellButtonItem *item, SWRevealTableViewCell *cell)
        //                                   {
        //                                       _revealingCellIndexPath = [newsfeedTable indexPathForCell:cell];
        //                                       [self presentMoreActionSheetForItem:item];
        //                                       return NO;
        //                                   }];
        //
        //        item3.backgroundColor = [UIColor lightGrayColor];
        //        item3.width = 50;
        
        items = @[item1,item2];
    }
    
    
    NSLog( @"Providing right Items");
    return items;
}


#pragma mark - ButtonItemAdd action

- (void)buttonItemAddAction:(id)sender
{
    NSIndexPath *insertingPath = [NSIndexPath indexPathForRow:0 inSection:SectionTitle];
    _sectionTitleRowCount += 1;
    
    [memberTable insertRowsAtIndexPaths:@[insertingPath] withRowAnimation:UITableViewRowAnimationFade];
}


#pragma mark - UIActionSheet


- (void)presentDeleteActionSheetForItem:(SWCellButtonItem*)cellItem
{
    UIActionSheet *actSheet = [[UIActionSheet alloc] initWithTitle:@"Delete Actions"
                                                          delegate:self
                                                 cancelButtonTitle:@"Cancel"
                                            destructiveButtonTitle:@"Delete Now"
                                                 otherButtonTitles:nil ];
    
    [actSheet setTag:0];
    [actSheet showFromCellButtonItem:cellItem animated:YES];
}


- (void)_performDeleteAction
{
    _sectionTitleRowCount -= 1;
    [memberTable deleteRowsAtIndexPaths:@[_revealingCellIndexPath] withRowAnimation:UITableViewRowAnimationFade];
}


- (void)presentRenameActionSheetForItem:(SWCellButtonItem*)cellItem
{
    UIActionSheet *actSheet = [[UIActionSheet alloc] initWithTitle:@"More Actions"
                                                          delegate:self
                                                 cancelButtonTitle:@"Cancel"
                                            destructiveButtonTitle:nil
                                                 otherButtonTitles:@"Action Rename", nil ];
    
    [actSheet setTag:1];
    [actSheet showFromCellButtonItem:cellItem animated:YES];
}


- (void)_performRenameAction
{
    NSLog( @"Rename Tapped");
}


- (void)presentMoreActionSheetForItem:(SWCellButtonItem*)cellItem
{
    UIActionSheet *actSheet = [[UIActionSheet alloc] initWithTitle:@"More Actions"
                                                          delegate:self
                                                 cancelButtonTitle:@"Cancel"
                                            destructiveButtonTitle:nil
                                                 otherButtonTitles:@"Action One", @"Action Two", @"Action Three", nil ];
    
    [actSheet setTag:2];
    [actSheet showFromCellButtonItem:cellItem animated:YES];
}


- (void)_performMoreActionAtIndex:(NSInteger)index
{
    switch ( index )
    {
        case 0:
            NSLog( @" Action One Tapped");
            break;
            
        case 1:
            NSLog( @" Action Two Tapped");
            break;
            
        case 2:
            NSLog( @" Action Three Tapped");
            break;
            
        default:
            break;
    }
}


// UIActionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //NSLog( @"clickedButtonAtIndex: %d", buttonIndex );
    
    if ( buttonIndex == [actionSheet cancelButtonIndex] )
    {
        NSLog( @"Cancel");
    }
    else
    {
        NSInteger index = buttonIndex - actionSheet.firstOtherButtonIndex;
        
        switch ( actionSheet.tag )
        {
            case 0:  // delete
                [self _performDeleteAction];
                break;
                
            case 1:  // rename
                [self _performRenameAction];
                break;
                
            case 2:  // more
                [self _performMoreActionAtIndex:index];
                break;
                
            default:
                break;
        }
    }
    
    SWRevealTableViewCell *cell = (id)[memberTable cellForRowAtIndexPath:_revealingCellIndexPath];
    [cell setRevealPosition:SWCellRevealPositionCenter animated:YES];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
