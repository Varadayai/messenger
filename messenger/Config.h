//
//  Config.h
//  WhatzzApp
//
//  Created by Konstant on 22/05/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "CommonFunctions.h"
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define DEFAULTS [NSUserDefaults standardUserDefaults]


@interface Config : NSObject {

}

//configuration section... 
extern  NSString		*SiteURL;
extern  NSString		*SiteAPIURL;
extern  NSString        *DIAGRAMURL;
extern  NSString        *COMPANYURL;
extern  NSString	*DatabaseName;
extern  NSString	*DatabasePath;

//for current location
extern CLLocationManager *locationManager; //
extern CLLocation *currentLocation;        // For Latitude & Longitude
extern CLLocationCoordinate2D coordinates; //

extern float			core_latitude;
extern float			core_longitude;

extern  NSString	*preferredLang;


// for facebook id
extern NSString             *kFBAppId ;
extern BOOL                 isFacebookLogin;


extern BOOL         isTwitterLogin;
extern BOOL         callToAddInPerk;

extern NSString		*logoLinkForShare;
extern NSString		*websiteLinkForShare;

extern NSString		*sessionId;

extern NSString		*deviceToken;
extern NSString		*commomFontSize;
extern NSString		*commomFontSizeIpad;

extern NSString		*currentFont;
extern BOOL         isPlatinumAdVisible;

extern NSMutableArray *postDealMA;
@end
