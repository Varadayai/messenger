//
//  CommonFunctions.h
//  WhatzzApp
//
//  Created by Konstant on 22/05/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <QuartzCore/QuartzCore.h>

/*
 *  System Versioning Preprocessor Macros
 */
 

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define kDeviceId [[UIDevice currentDevice] uniqueIdentifier]

#define FONT_CHANGED_NOTIFICATION @"changedFontNotification"
#define LOGOUT_NOTIFICATION @"logoutNotification"

#define CONTROLLER_CHANGED_NOTIFICATION @"changedControllerNotification"
#define FONT_CHANGED @"fontSize"
#define KADDED_VALUE(xx) (xx+32)


#define DEFAULTS [NSUserDefaults standardUserDefaults]
#define FLOWBUTTONS @"flowButtons"
#define KCONTROLLERS @"controllers"
#define KSYNC_DATA @"syncData"
#define KCOMPANY_ID_OFFLINE @"companyIdOffline"
#define KCOMPANY_NAME_OFFLINE @"companyNameOffline"
#define KCOMPANY_ID @"companyId"
#define KCOMPANY_NAME @"companyName"
#define IS_LOGIN @"login"
#define LOGIN_ONCE @"loginOnce"
#define KDB_PATH @"databasePath"
#define SHOULD_FETCHDATA @"shouldFetchData"
#define UPDATED_TIME @"updatedTime"
#define UPDATE_BOOKS @"updateBooks"
#define INSTALLATION_GUIDE @"InstallationGuide"
#define BOOK_TYPE @"booktype"
#define LOADED_COMPLETE_DATA @"loadedCompleteData"
#define KUSER_NAME @"username"
#define KPASSWORD @"password"
#define OFFLINE_STATUS  @"OFFLINE_STATUS"
#define KUSER_ID @"userId"


@interface CommonFunctions : NSObject {

    
}


@property (assign) BOOL IsOnlineSelected;
@property (assign) BOOL IsOfflineSelected;
@property (nonatomic,strong) NSString *TradeID;
@property (nonatomic,strong) NSString *CategoryID;
@property (nonatomic,strong) NSString *SubCategoryID;
@property (nonatomic,strong) NSString *Heading1;
@property (nonatomic,strong) NSString *Heading2;
@property (nonatomic,strong) NSString *Heading3;
@property (nonatomic,strong) NSString *Heading4;
@property (nonatomic,strong) NSString *Heading5;
@property (nonatomic,strong) NSString *Heading6;

+(CommonFunctions*) sharedInstance;

+ (NSString *)documentsDirectory;
+ (void)openEmail:(NSString *)address;
+ (void)openPhone:(NSString *)number;
+ (void)openSms:(NSString *)number;
+ (void)openBrowser:(NSString *)url;
+ (void)openMap:(NSString *)address;

+ (void) hideTabBar:(UITabBarController *) tabbarcontroller;
+ (void) showTabBar:(UITabBarController *) tabbarcontroller;
+ (void) checkAndCreateDatabase;
+(void) setNavigationTitle:(NSString *) title ForNavigationItem:(UINavigationItem *) navigationItem;

/**
 * Normal Alert view with only Ok btn
 */
+ (void)alertTitle:(NSString*)aTitle withMessage:(NSString*)aMsg withDelegate:(id)delegate;
+ (void)alertTitle:(NSString*)aTitle withMessage:(NSString*)aMsg;

/**
 * user for check that value is empty or not 
 * shows a alert : server not responding error
 */
+ (BOOL)isValueNotEmpty:(NSString*)aString;

/**
 * shows a alert : server not found , try again later
 */
+ (void)showServerNotFoundError;

+ (BOOL)isRetineDisplay;

- (BOOL)connected ;
+(BOOL) reachabiltyCheck;
+(BOOL)reachabilityChanged:(NSNotification*)note;
+ (BOOL) connectedToNetwork;


+ (NSString*) getImageNameForName:(NSString*) name;
+ (NSString*) getNibNameForName:(NSString*) name;
+ (CAKeyframeAnimation *) attachPopUpAnimation;
+(NSString *)statusOfLastUpdate:(NSInteger )hour;

+(void)settingOrienatationInWindow;


@end
