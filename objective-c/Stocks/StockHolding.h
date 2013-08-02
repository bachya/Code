//
//  StockHolding.h
//  Stocks
//
//  Created by Aaron Bach on 3/7/13.
//  Copyright (c) 2013 Aaron Bach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockHolding : NSObject

@property float purchaseSharePrice, currentSharePrice;
@property int numberOfShares;

- (float)costInDollars;
- (float)valueInDollars;

@end
