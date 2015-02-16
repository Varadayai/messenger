//
//  ConnectionManager.h
//  ASISample
//
//  Created by Kuldeep Saini on 24/06/13.
//  Copyright (c) 2013 Kuldeep Saini. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ConnectionManagerDelegate <NSObject>

@optional
-(void)connectionSucceedWithResponse:(id)request;
-(void)connectionFailureWithError:(NSError*)error;

@end

@interface ConnectionManager : NSObject
{
    NSMutableData *responseData;
    NSString *responseString;
    NSURLConnection *requestConnection;
}

@property (nonatomic, assign) id<ConnectionManagerDelegate> delegate;
@property (nonatomic,strong) NSMutableData *responseData;
@property (nonatomic,strong) NSString *responseString;

-(void)sendRequestWithURL:(NSString*)strURL andPostBody:(NSString*)strPostBody;

@end
