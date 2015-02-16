//
//  AppDelegate.h
//  messenger
//
//  Created by saurabh sindhu on 04/02/15.
//  Copyright (c) 2015 saurabh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic)IBOutlet UIWindow *window;

@property (nonatomic, strong, readonly) RootViewController *rootViewController;

@property (strong, nonatomic) UINavigationController *navController;

+(AppDelegate*) getSharedInstance;

@end
