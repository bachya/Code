//
//  Employee.h
//  BMITime
//
//  Created by Aaron Bach on 3/8/13.
//  Copyright (c) 2013 Aaron Bach. All rights reserved.
//

#import "Person.h"
@class Asset;

@interface Employee : Person

@property NSString *lastName;
@property Person *spouse;
@property NSMutableArray *children;
@property int employeeID;
@property NSMutableArray *assets;

- (void)addAssetsObject:(Asset *)a;
- (unsigned int)valueOfAssets;

@end
