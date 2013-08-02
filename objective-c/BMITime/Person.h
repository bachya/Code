//
//  Person.h
//  BMITime
//
//  Created by Aaron Bach on 3/8/13.
//  Copyright (c) 2013 Aaron Bach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property float heightInMeters;
@property int weightInKilos;

- (float)bodyMassIndex;

@end
