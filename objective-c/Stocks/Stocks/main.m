//
//  main.m
//  Stocks
//
//  Created by Aaron Bach on 3/7/13.
//  Copyright (c) 2013 Aaron Bach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ForeignStockHolding.h"
#import "Portfolio.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // Create three stock holdings.
        StockHolding *s1 = [[StockHolding alloc] init];
        [s1 setPurchaseSharePrice:4.99];
        [s1 setCurrentSharePrice:12.42];
        [s1 setNumberOfShares:300];
        
        StockHolding *s2 = [[StockHolding alloc] init];
        [s2 setPurchaseSharePrice:12.07];
        [s2 setCurrentSharePrice:95.74];
        [s2 setNumberOfShares:10];
        
        StockHolding *s3 = [[StockHolding alloc] init];
        [s3 setPurchaseSharePrice:120.21];
        [s3 setCurrentSharePrice:12.23];
        [s3 setNumberOfShares:50];
        
        // Create two foreign stock holdings.
        ForeignStockHolding *fs1 = [[ForeignStockHolding alloc] init];
        [fs1 setPurchaseSharePrice:12.32];
        [fs1 setCurrentSharePrice:14.98];
        [fs1 setNumberOfShares:300];
        [fs1 setConversionRate:1.25];
        
        ForeignStockHolding *fs2 = [[ForeignStockHolding alloc] init];
        [fs2 setPurchaseSharePrice:100.45];
        [fs2 setCurrentSharePrice:200.12];
        [fs2 setNumberOfShares:100];
        [fs2 setConversionRate:0.45];
        
        Portfolio *p = [[Portfolio alloc] init];
        [p addStock:s1];
        [p addStock:s2];
        [p addStock:s3];
        [p addStock:fs1];
        [p addStock:fs2];
        
        NSLog(@"Total value of portfolio is $%.2f", [p getTotalValue]);
    }
    return 0;
}

