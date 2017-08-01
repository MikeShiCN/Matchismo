//
//  PlayingCard.h
//  Matchismo
//
//  Created by Mike Yuan Shi on 29/07/2017.
//  Copyright © 2017 Mike Yuan Shi. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *) validSuits;
+ (NSUInteger) maxRank;

@end
