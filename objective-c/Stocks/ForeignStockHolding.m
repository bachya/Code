//
//  ForeignStockHolding.m
//  Stocks
//
//  Created by Aaron Bach on 3/8/13.
//  Copyright (c) 2013 Aaron Bach. All rights reserved.
//

#import "ForeignStockHolding.h"

@implementation ForeignStockHolding

@synthesize conversionRate;

- (float)costInDollars
{
    return [super costInDollars] * conversionRate;
}

- (float)valueInDollars
{
    return [super valueInDollars] * conversionRate;
}

@end
