//
//  Portfolio.m
//  Stocks
//
//  Created by Aaron Bach on 3/8/13.
//  Copyright (c) 2013 Aaron Bach. All rights reserved.
//

#import "Portfolio.h"
#import "StockHolding.h"

@implementation Portfolio

@synthesize stocks;

- (void)addStock:(StockHolding *)s
{
    if (!stocks)
    {
        stocks = [[NSMutableArray alloc] init];
    }
    [stocks addObject:s];
}

- (float)getTotalValue
{
    float total = 0.0;
    for (StockHolding *s in [self stocks])
    {
        total += [s valueInDollars];
    }
    return total;
}

@end
