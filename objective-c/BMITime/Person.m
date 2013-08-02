//
//  Person.m
//  BMITime
//
//  Created by Aaron Bach on 3/8/13.
//  Copyright (c) 2013 Aaron Bach. All rights reserved.
//

#import "Person.h"

@implementation Person

@synthesize heightInMeters, weightInKilos;

- (float)bodyMassIndex
{
    float h = [self heightInMeters];
    return [self weightInKilos] / (h * h);
}

@end
