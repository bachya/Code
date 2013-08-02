//
//  Logger.m
//  Callbacks
//
//  Created by Aaron Bach on 3/10/13.
//  Copyright (c) 2013 Aaron Bach. All rights reserved.
//

#import "Logger.h"

@implementation Logger

@synthesize incomingData;

- (void)sayOuch:(NSTimer *)t
{
    NSLog(@"Ouch!");
}

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data
{
    NSLog(@"Received %lu bytes", [data length]);
    
    if (!incomingData) {
        incomingData = [[NSMutableData alloc] init];
    }
    
    [incomingData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Got it all!");
    
    NSString *string = [[NSString alloc] initWithData:incomingData
                                             encoding:NSUTF8StringEncoding];
    
    incomingData = nil;
    NSLog(@"String has %lu characters", [string length]);
    
    NSLog(@"The whole string is %@", string);
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    NSLog(@"Connection failed: %@", [error localizedDescription]);
    incomingData = nil;
}

- (void)zoneChange:(NSNotification *)note
{
    NSLog(@"The system time zone has changed!");
}

@end
