//
//  Card.h
//  Matchismo
//
//  Created by Mike Yuan Shi on 29/07/2017.
//  Copyright © 2017 Mike Yuan Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSArray *) otherCards;

@end
