//
//  StockHolding.m
//  Stocks
//
//  Created by Aaron Bach on 3/7/13.
//  Copyright (c) 2013 Aaron Bach. All rights reserved.
//

#import "StockHolding.h"

@implementation StockHolding

@synthesize purchaseSharePrice, currentSharePrice, numberOfShares;

- (float)costInDollars
{
    return purchaseSharePrice * numberOfShares;
}

- (float) valueInDollars
{
    return currentSharePrice * numberOfShares;
}

@end
