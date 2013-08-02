//
//  Logger.h
//  Callbacks
//
//  Created by Aaron Bach on 3/10/13.
//  Copyright (c) 2013 Aaron Bach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Logger : NSObject

@property NSMutableData *incomingData;

- (void)sayOuch:(NSTimer *)t;

@end
