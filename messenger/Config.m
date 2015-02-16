//
//  Config.M
//  WhatzzApp
//
//  Created by smartDAta on 22/05/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "Config.h"


@implementation Config

NSString		*SiteAPIURL				=       @"http://dealhunter.com/dealapp/api/index.php/";



NSString		*ShowPerPage			= @"20";

NSString		*DatabaseName			= @"appReaderDB.sqlite";
NSString		*DatabasePath;

NSString	*preferredLang = @"en";

//for current location
CLLocationManager *locationManager;							//
CLLocation *currentLocation;								// For Latitude & Longitude
CLLocationCoordinate2D coordinates;							//

//for live
float			core_latitude;		
float			core_longitude;

// for facebook iD 
NSString *kFBAppId                     = @"";

//--------------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------------



NSString		*logoLinkForShare = @"";
NSString		*websiteLinkForShare =@"";


BOOL            callToAddInPerk;

NSString		*sessionId = @"";

BOOL         isPlatinumAdVisible;

NSString		*deviceToken;
NSString		*commomFontSize = @"12";
NSString		*commomFontSizeIpad = @"20";
NSString		*currentFont = @"";

NSMutableArray *postDealMA = nil;

@end