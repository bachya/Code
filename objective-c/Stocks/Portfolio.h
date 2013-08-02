//
//  Portfolio.h
//  Stocks
//
//  Created by Aaron Bach on 3/8/13.
//  Copyright (c) 2013 Aaron Bach. All rights reserved.
//

#import <Foundation/Foundation.h>
@class StockHolding;

@interface Portfolio : NSObject

@property (strong) NSMutableArray *stocks;

- (void)addStock:(StockHolding *)s;
- (float)getTotalValue;

@end
