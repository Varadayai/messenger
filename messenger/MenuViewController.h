//
//  MenuViewController.h
//  messenger
//
//  Created by saurabh sindhu on 04/02/15.
//  Copyright (c) 2015 saurabh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsFeedViewController;
@class Notifications;
@class GroupsViewController;
@class ChatViewController;


@interface MenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    IBOutlet UITableView *tableDisplay;
    NSMutableArray *allDataMA,*allImages;
    NewsFeedViewController *newsfeed;
    Notifications *notify;
    GroupsViewController *groups;
    ChatViewController *chat;

}

@end
