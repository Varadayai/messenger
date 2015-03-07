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
#import "DAKeyboardControl.h"


#import "DAKeyboardControl.h"



#define kInputHeight 40.0f
#define kLineHeight 30.0f
#define kButtonWidth 78.0f


@interface GroupsViewController ()<SWRevealTableViewCellDelegate,SWRevealTableViewCellDataSource,UIActionSheetDelegate>
{
    NSIndexPath *_revealingCellIndexPath;
    NSInteger _sectionTitleRowCount;
}

@end

@implementation GroupsViewController

BOOL toggleIsOn;


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
    
    tableViewM = [[UITableView alloc] initWithFrame:CGRectMake(0.0f,
                                                               150.0f,
                                                               self.view.bounds.size.width,
                                                               418.0f)];
    tableViewM.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:tableViewM];
    
    tableViewM.dataSource=self;
    tableViewM.delegate=self;
    
    tableViewM.hidden=YES;

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
    
    if(toggleIsOn){
        
        toolBar.hidden=YES;
        
        _paintView=[[UIView alloc]initWithFrame:CGRectMake(0, 45, 320, 560)];
        [_paintView setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:_paintView];
        
        
        UILabel *lbl2 = [[UILabel alloc] init];
        [lbl2 setFrame:CGRectMake(18.0f, 20.0f, 20, 20)];
        lbl2.backgroundColor=[UIColor clearColor];
        lbl2.textColor=[UIColor colorWithRed:184.0f/255.0f green:184.0f/255.0f blue:184.0f/255.0f alpha:1];
        lbl2.userInteractionEnabled=NO;
        lbl2.text= @"To";
        [lbl2 setFont:[UIFont systemFontOfSize:14]];
        //self.lbl1.textAlignment = NSTextAlignmentCenter;
        [_paintView addSubview:lbl2];
        
        
        UITextField* textF = [[UITextField alloc] initWithFrame:CGRectMake(50, 20, 180, 20)];
        
        
        textF.borderStyle = UITextBorderStyleNone;
        textF.textColor = [UIColor colorWithRed:184.0f/255.0f green:184.0f/255.0f blue:184.0f/255.0f alpha:1];
        textF.font = [UIFont systemFontOfSize:17];
        textF.placeholder = @"search name";
        textF.autocorrectionType = UITextAutocorrectionTypeNo;
        textF.keyboardType = UIKeyboardTypeDefault;
        textF.returnKeyType = UIReturnKeyDefault;
        textF.clearButtonMode = UITextFieldViewModeWhileEditing;
        textF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textF.delegate = self;
        [_paintView addSubview:textF];
        
        
        // Input field
        toolBar1 = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f,
                                                                         self.view.bounds.size.height - 40.0f,
                                                                         self.view.bounds.size.width,
                                                                         40.0f)];
        toolBar1.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:toolBar1];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10.0f,
                                                                               6.0f,
                                                                               toolBar1.bounds.size.width - 68.0f,
                                                                               30.0f)];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [toolBar1 addSubview:textField];
        
        UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        sendButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        //[sendButton setTitle:@"Send" forState:UIControlStateNormal];
        [sendButton setBackgroundImage:[UIImage imageNamed:@"sent-btn"] forState:UIControlStateNormal];
        
        sendButton.frame = CGRectMake(toolBar1.bounds.size.width - 48.0f,
                                      6.0f,
                                      46.0f,
                                      30.0f);
        [toolBar1 addSubview:sendButton];
        
        
        
        self.view.keyboardTriggerOffset = toolBar1.bounds.size.height;
        
        [self.view addKeyboardPanningWithFrameBasedActionHandler:^(CGRect keyboardFrameInView, BOOL opening, BOOL closing) {
            /*
             Try not to call "self" inside this block (retain cycle).
             But if you do, make sure to remove DAKeyboardControl
             when you are done with the view controller by calling:
             [self.view removeKeyboardControl];
             */
            
            
            CGRect toolBarFrame = toolBar1.frame;
            toolBarFrame.origin.y = keyboardFrameInView.origin.y - toolBarFrame.size.height;
            toolBar1.frame = toolBarFrame;
            
            //CGRect tableViewFrame = tableView.frame;
            // tableViewFrame.size.height = toolBarFrame.origin.y;
            // tableView.frame = tableViewFrame;
        } constraintBasedActionHandler:nil];
        
    }
    else {
        
//        toolBar1.hidden=YES;
//        toolBar.hidden=NO;


        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        
        _paintView.hidden=YES;
        
        
    }
    
    toggleIsOn = !toggleIsOn;
    
    
    
 

}

-(void)sendPressed2:(id)sender{
    
    
    
    
}

-(IBAction)buttonSel:(UIButton*)sender{
    
    if (sender.tag==1) {
        
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

        
        tableViewM.hidden=YES;
        
        memberTable.hidden=NO;
        
        toolBar.hidden=YES;
        
        
        [line1 setHidden:YES];
        
        [line2 setHidden:NO];
        
        conv.textColor = [UIColor colorWithRed:0/255.f green:123/255.f blue:168/255.f alpha:1];

        members.textColor = [UIColor colorWithRed:224/255.f green:224/255.f blue:224/255.f alpha:1];
        
        
    }
    
    else if (sender.tag==2){
        
        memberTable.hidden=YES;
        
        toolBar1.hidden=YES;
        
        [line1 setHidden:NO];
        
        [line2 setHidden:YES];
  
        members.textColor = [UIColor colorWithRed:0/255.f green:123/255.f blue:168/255.f alpha:1];
        
        conv.textColor = [UIColor colorWithRed:224/255.f green:224/255.f blue:224/255.f alpha:1];
        
        
        tableViewM.hidden=NO;
        
        toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f,
                                                                         self.view.bounds.size.height - 40.0f,
                                                                         self.view.bounds.size.width,
                                                                         40.0f)];
        toolBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:toolBar];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10.0f,
                                                                               6.0f,
                                                                               toolBar.bounds.size.width - 68.0f,
                                                                               30.0f)];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [toolBar addSubview:textField];
        
        UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        sendButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        //[sendButton setTitle:@"Send" forState:UIControlStateNormal];
        [sendButton setBackgroundImage:[UIImage imageNamed:@"chat-sent"] forState:UIControlStateNormal];

        sendButton.frame = CGRectMake(toolBar.bounds.size.width - 48.0f,
                                      6.0f,
                                      32.0f,
                                      32.0f);
        [toolBar addSubview:sendButton];
        
        
        self.view.keyboardTriggerOffset = toolBar.bounds.size.height;
        
        [self.view addKeyboardPanningWithFrameBasedActionHandler:^(CGRect keyboardFrameInView, BOOL opening, BOOL closing) {
            /*
             Try not to call "self" inside this block (retain cycle).
             But if you do, make sure to remove DAKeyboardControl
             when you are done with the view controller by calling:
             [self.view removeKeyboardControl];
             */
            
            
            CGRect toolBarFrame = toolBar.frame;
            toolBarFrame.origin.y = keyboardFrameInView.origin.y - toolBarFrame.size.height;
            toolBar.frame = toolBarFrame;
            
            CGRect tableViewFrame = tableViewM.frame;
            tableViewFrame.size.height = toolBarFrame.origin.y;
            tableViewM.frame = tableViewFrame;
            
           
            
        } constraintBasedActionHandler:nil];

        [tableViewM reloadData]; 
        
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
    
    
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 6, cell.bounds.size.width-60, 15)];
    
    detailLabel.tag = 345345;
    detailLabel.backgroundColor = [UIColor clearColor];
    
    detailLabel.textColor = [UIColor colorWithRed:141.0/255.f green:141.0/255.f blue:141.0/255.f alpha:1];
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
    
    if (tableViewM.hidden==NO) {
        
        
        UILabel *detailLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(45, 10, cell.bounds.size.width-100, 45)];
        
        detailLabel1.tag = 345346;
        detailLabel1.backgroundColor = [UIColor clearColor];
        
        detailLabel1.textColor = [UIColor blackColor];
        [detailLabel1 setFont:[UIFont boldSystemFontOfSize:10]];
        detailLabel1.layer.shadowColor = [[UIColor whiteColor] CGColor];
        detailLabel1.lineBreakMode = NSLineBreakByWordWrapping;
        detailLabel1.numberOfLines = 0;
        detailLabel1.layer.shadowOpacity = 0.7;
        detailLabel1.layer.shouldRasterize=YES;
        detailLabel1.text = @"UChicgo football gme versus Pacific(Ore) cancelled!";
        [cell.contentView addSubview:detailLabel1];
        
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(280,20, 18, 16)];
        
        [button setBackgroundImage:[UIImage imageNamed:@"conversations_plus.png"] forState:UIControlStateNormal];

        [button addTarget:self action:@selector(buttonPressedAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button];
    
        
        
    }
    
    tableView.allowsSelection = NO;

    
    return cell;
}

- (void)buttonPressedAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    int row = button.tag;
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
//    UIActionSheet *actSheet = [[UIActionSheet alloc] initWithTitle:@"Delete Actions"
//                                                          delegate:self
//                                                 cancelButtonTitle:@"Cancel"
//                                            destructiveButtonTitle:@"Delete Now"
//                                                 otherButtonTitles:nil ];
//    
//    [actSheet setTag:0];
//    [actSheet showFromCellButtonItem:cellItem animated:YES];
}


- (void)_performDeleteAction
{
    _sectionTitleRowCount -= 1;
    [memberTable deleteRowsAtIndexPaths:@[_revealingCellIndexPath] withRowAnimation:UITableViewRowAnimationFade];
}


- (void)presentRenameActionSheetForItem:(SWCellButtonItem*)cellItem
{
//    UIActionSheet *actSheet = [[UIActionSheet alloc] initWithTitle:@"More Actions"
//                                                          delegate:self
//                                                 cancelButtonTitle:@"Cancel"
//                                            destructiveButtonTitle:nil
//                                                 otherButtonTitles:@"Action Rename", nil ];
//    
//    [actSheet setTag:1];
//    [actSheet showFromCellButtonItem:cellItem animated:YES];
}


- (void)_performRenameAction
{
    NSLog( @"Rename Tapped");
}


- (void)presentMoreActionSheetForItem:(SWCellButtonItem*)cellItem
{
//    UIActionSheet *actSheet = [[UIActionSheet alloc] initWithTitle:@"More Actions"
//                                                          delegate:self
//                                                 cancelButtonTitle:@"Cancel"
//                                            destructiveButtonTitle:nil
//                                                 otherButtonTitles:@"Action One", @"Action Two", @"Action Three", nil ];
//    
//    [actSheet setTag:2];
//    [actSheet showFromCellButtonItem:cellItem animated:YES];
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
