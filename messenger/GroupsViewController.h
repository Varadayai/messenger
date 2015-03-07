//
//  GroupsViewController.h
//  messenger
//
//  Created by saurabh sindhu on 14/02/15.
//  Copyright (c) 2015 saurabh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    
    IBOutlet UILabel *members,*conv,*line1,*line2;
    
    IBOutlet UIButton *butt1,*butt2;
    
    IBOutlet UITableView *memberTable;
    
    UITableView *tableViewM;
    
    UIToolbar *toolBar,*toolBar1;
    
      
}

@property (nonatomic, strong) UIView *paintView;


-(IBAction)buttonSel:(UIButton*)sender;
-(IBAction)logout:(id)sender;
-(IBAction)addMembers:(id)sender;
-(IBAction)buttonSlide:(id)sender;

@end
