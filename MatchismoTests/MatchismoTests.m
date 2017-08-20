//
//  MatchismoTests.m
//  MatchismoTests
//
//  Created by Mike Yuan Shi on 29/07/2017.
//  Copyright © 2017 Mike Yuan Shi. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SetCard.h"

@interface MatchismoTests : XCTestCase

@property (nonatomic, strong) SetCard* setCard;


@end

@implementation MatchismoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.setCard = [[SetCard alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSetCardMatchAllSame {
    self.setCard.color = @"Yellow";
    self.setCard.number = @"1";
    self.setCard.shape = @"●";
    self.setCard.shade = @"Solid";
    
    NSArray * otherCards = @[self.setCard, self.setCard];
    int score = [self.setCard match:otherCards];
    XCTAssert(score == 16);
    
}


- (void)testArrayConcat {
    self.setCard.color = @"Yellow";
    self.setCard.number = @"1";
    self.setCard.shape = @"●";
    self.setCard.shade = @"Solid";
    
    NSLog(@"%@", self.setCard.contents);
    XCTAssert([self.setCard.contents isEqualToString: @"1.●.Solid.Yellow"]);
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    self.setCard.color = @"Yellow";
    self.setCard.number = @"2";
    self.setCard.shape = @"●";
    self.setCard.shade = @"Solid";
    XCTAssert([self.setCard.contents isEqualToString: @"2.●.Solid.Yellow"]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
