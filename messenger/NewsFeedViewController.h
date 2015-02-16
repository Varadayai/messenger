//
//  NewsFeedViewController.h
//  messenger
//
//  Created by saurabh sindhu on 11/02/15.
//  Copyright (c) 2015 saurabh. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewsFeedViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
    IBOutlet UITableView *newsfeedTable;
    IBOutlet UIView *infoView;
}

-(IBAction)butt1:(id)sender;
-(IBAction)butt2:(id)sender;


@end
