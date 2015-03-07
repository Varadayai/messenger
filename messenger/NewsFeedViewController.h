//
//  NewsFeedViewController.h
//  messenger
//
//  Created by saurabh sindhu on 11/02/15.
//  Copyright (c) 2015 saurabh. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewsFeedViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    
    IBOutlet UITableView *newsfeedTable;
    IBOutlet UIView *infoView;
    IBOutlet UILabel *members,*conv,*line1,*line2;
}

@property (nonatomic, strong) UIView *paintView;


-(IBAction)butt1:(id)sender;
-(IBAction)butt2:(id)sender;
-(IBAction)dialog:(id)sender;


@end
