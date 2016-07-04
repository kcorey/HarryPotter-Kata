//
//  PermutationSearcher.m
//  BookSaleOptimizer
//
//  Created by Ken Corey on 04/07/2016.
//  Copyright © 2016 Ken Corey. All rights reserved.
//

#import "PermutationSearcher.h"

@implementation PermutationSearcher

+ (int)sumArray:(NSArray *)order {
    
    int result = 0;
    
    for (NSNumber *aNumber in order) {
        
        result += [aNumber intValue];
    }
    
    return result;
}

+ (int)costFor:(int)count {
    
    switch(count) {
        case 1:
            return 800;
        case 2:
            return 1520;
        case 3:
            return 2160;
        case 4:
            return 2560;
        case 5:
            return 3000;
        default:
            return 0;
    }
}

+ (NSMutableArray *)reducedOrder:(NSArray *)order withDiscountIndex:(int)discountIndex {
    NSMutableArray *mutableOrder;
    mutableOrder = [order mutableCopy];
    int bookToRemove=discountIndex;
    int placeToRemove=0;
    
    // Remove the number of books from the current discount, 0 or 1 for each type of book,
    // until all the books are gone, or we've fulfilled discountIndex.
    
    while (bookToRemove
           && [self sumArray:mutableOrder] > 0) {
        
        while (placeToRemove < discountIndex
               && mutableOrder[placeToRemove] == 0) {
            
            placeToRemove++;
        }
        mutableOrder[placeToRemove] = @([mutableOrder[placeToRemove] intValue] - 1);
        bookToRemove--;
        placeToRemove++;
    }
    return mutableOrder;
}

+ (NSDictionary *)makeNodeCosting:(int)thisCost withDiscount:(NSArray *)discounts {
    NSDictionary *current;
    current = @{@"cost":@(thisCost),
                @"discounts":discounts};
    return current;
}

+ (NSDictionary *)findMinimumForOrder:(NSArray *)order {
    
    // Each node looks like this:
    // @{cost:5160 discounts:@[3,2,1]}
    // cost - price in whole pennies
    // discounts - The best discount scheme returned from whats left.  3 = the first 3 available books.

    NSDictionary *current = nil;
    NSDictionary *best = nil;
    NSDictionary *childNodes;
    int thisCost;
    NSMutableArray *mutableOrder;
    NSArray *newOrder = order;
    int totalBooks;
    
    // At each node, cycle through the different index schemes.
    // Find the value for each, and keep the best one.
    for (int discountIndex = 1;discountIndex<6;discountIndex++) {
        
        totalBooks = [self sumArray:order];
        if (totalBooks >= discountIndex
            && discountIndex <= [order count]) {
            
            // We're comparing discountIndex to the number of books in the order...If there are
            // 2 of the first book, and 2 of the second, the maximum discount you could possibly
            // get is on 2 books at a time.
            mutableOrder = [self reducedOrder:order
                            withDiscountIndex:discountIndex];

            thisCost = [self costFor:discountIndex];
            if (totalBooks - discountIndex > 0) {
                
                childNodes = [self findMinimumForOrder:mutableOrder];
                if (childNodes) {
                    
                    // prepend this discountIndex onto the array of optimum childNodes
                    NSArray *newlist = [@[@(discountIndex)] arrayByAddingObjectsFromArray:childNodes[@"discounts"]];
                    
                    current = [self makeNodeCosting:thisCost + [childNodes[@"cost"] intValue]
                                       withDiscount:newlist];
                }
            }
            else {
                
                current = [self makeNodeCosting:thisCost
                                   withDiscount:@[@(discountIndex)]];
            }

            if (!best
                || [current[@"cost"] intValue] < [best[@"cost"] intValue]) {
                
                best = current;
                newOrder = mutableOrder;
            }
        }
    }
    
    return best;
}

@end
