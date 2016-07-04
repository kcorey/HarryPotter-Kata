//
//  PermutationSearcherTests.m
//  BookSaleOptimizer
//
//  Created by Ken Corey on 04/07/2016.
//  Copyright © 2016 Ken Corey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PermutationSearcher.h"

@interface PermutationSearcherTests : XCTestCase

@end

@implementation PermutationSearcherTests

- (void) testCanSearchWithNilInput {
    
    NSDictionary *result = [PermutationSearcher findMinimumForOrder:nil];
    
    XCTAssertNil(result);
}

- (void) testCanSearchWithEmptyInput {
    
    NSDictionary *result = [PermutationSearcher findMinimumForOrder:[NSArray new]];
    
    XCTAssertNil(result);
}

- (void) testCanSearchWithOneInput {
    
    NSArray *inputArray = @[ @1];
    
    NSDictionary *result = [PermutationSearcher findMinimumForOrder:inputArray];
    
    XCTAssertNotNil(result);
    XCTAssertEqual([result[@"discounts"] count], 1);
}

- (void) testCanSearchWithTwoDifferentBooks {
    
    NSArray *inputArray = @[ @1, @1];
    
    NSDictionary *result = [PermutationSearcher findMinimumForOrder:inputArray];
    
    XCTAssertNotNil(result);
    XCTAssertEqual([result[@"discounts"] count], 1);
    XCTAssertEqual([result[@"discounts"][0] intValue], 2);
}

- (void) testCanSearchWithFourDifferentBooks {
    
    NSArray *inputArray = @[ @1, @1, @1, @1];
    
    NSDictionary *result = [PermutationSearcher findMinimumForOrder:inputArray];
    
    XCTAssertNotNil(result);
    XCTAssertEqual([result[@"discounts"] count], 1);
    XCTAssertEqual([result[@"discounts"][0] intValue], 4);
}

- (void) testCanSearchWithFiveDifferentBooks {
    
    NSArray *inputArray = @[ @1, @1, @1, @1, @1];
    
    NSDictionary *result = [PermutationSearcher findMinimumForOrder:inputArray];
    
    XCTAssertNotNil(result);
    XCTAssertEqual([result[@"discounts"] count], 1);
    XCTAssertEqual([result[@"discounts"][0] intValue], 5);
}

- (void) testCanSearchWithTwoSameBooks {
    
    NSArray *inputArray = @[ @2];
    
    NSDictionary *result = [PermutationSearcher findMinimumForOrder:inputArray];
    
    XCTAssertNotNil(result);
    XCTAssertEqual([result[@"discounts"] count], 2);
    XCTAssertEqual([result[@"discounts"][0] intValue], 1);
    XCTAssertEqual([result[@"discounts"][1] intValue], 1);
}

- (void) testCanSearchWithFourSameBooks {
    
    NSArray *inputArray = @[ @4];
    
    NSDictionary *result = [PermutationSearcher findMinimumForOrder:inputArray];
    
    XCTAssertNotNil(result);
    XCTAssertEqual([result[@"discounts"] count], 4);
    XCTAssertEqual([result[@"discounts"][0] intValue], 1);
    XCTAssertEqual([result[@"discounts"][1] intValue], 1);
    XCTAssertEqual([result[@"discounts"][2] intValue], 1);
    XCTAssertEqual([result[@"discounts"][3] intValue], 1);
}

- (void) testCanSearchWithTwoBooksTwoCopies {
    
    NSArray *inputArray = @[ @2, @2];
    
    NSDictionary *result = [PermutationSearcher findMinimumForOrder:inputArray];
    
    XCTAssertNotNil(result);
    XCTAssertEqual([result[@"discounts"] count], 2);
    XCTAssertEqual([result[@"discounts"][0] intValue], 2);
    XCTAssertEqual([result[@"discounts"][1] intValue], 2);
}

- (void) testCanSearchWithComplexBookOrder {
    
    NSArray *inputArray = @[ @2, @2, @2, @1, @1];
    
    NSDictionary *result = [PermutationSearcher findMinimumForOrder:inputArray];
    
    XCTAssertNotNil(result);
    XCTAssertEqual([result[@"discounts"] count], 2);
    XCTAssertEqual([result[@"discounts"][0] intValue], 4);
    XCTAssertEqual([result[@"discounts"][1] intValue], 4);
}

@end
