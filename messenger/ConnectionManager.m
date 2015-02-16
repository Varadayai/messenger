//
//  ConnectionManager.m
//  ASISample
//
//  Created by Kuldeep Saini on 24/06/13.
//  Copyright (c) 2013 Kuldeep Saini. All rights reserved.
//

#import "ConnectionManager.h"

@implementation ConnectionManager
@synthesize delegate;
@synthesize responseData;
@synthesize responseString;

-(void)sendRequestWithURL:(NSString*)strURL andPostBody:(NSString*)strPostBody
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strURL]];
  
    NSData *myRequestData = [ NSData dataWithBytes: [ strPostBody UTF8String ] length: [ strPostBody length]];

    NSString *postLength =  [NSString stringWithFormat:@"%d", [strPostBody length]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody: myRequestData ];
    
    [request setTimeoutInterval:200];
    
    requestConnection= [NSURLConnection connectionWithRequest:request delegate:self];
    
    
    if(requestConnection)
    {
        responseData = nil;
        responseData=[[NSMutableData alloc] init];
    }
}

#pragma mark - Connection Delegates

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [responseData setLength: 0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(connectionFailureWithError:)]){
        [self.delegate performSelector:@selector(connectionFailureWithError:) withObject:error];
    }
    

}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *dataString = [[NSString alloc] initWithData:responseData encoding:NSISOLatin1StringEncoding];
    NSLog(@" Final Response = %@",dataString);
    self.responseString = dataString;
    dataString = nil;
    
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(connectionSucceedWithResponse:)]){
        [self.delegate performSelector:@selector(connectionSucceedWithResponse:) withObject:self];
    }

}

@end
