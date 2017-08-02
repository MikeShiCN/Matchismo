//
//  PlayingCard.m
//  Matchismo
//
//  Created by Mike Yuan Shi on 29/07/2017.
//  Copyright © 2017 Mike Yuan Shi. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *) contents {
    NSArray * rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)validSuits {
    return @[@"♥︎", @"♦︎", @"♠︎", @"♣︎"];
}

@synthesize suit = _suit;

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    } else {
        NSLog(@"suit not valid:%@", suit);
    }
}

- (NSString *) suit {
    return _suit ? _suit : @"?";
}

+ (NSArray *) rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10",
             @"J", @"Q", @"K"];
}

+ (NSUInteger) maxRank {
    return [[self rankStrings] count] -1;
}

- (void) setRank:(NSUInteger)rank {
    if (rank > [PlayingCard maxRank]){
        NSLog(@"rank beyond range : %lu", rank);
    } else {
        _rank = rank;
    }
}

static const int REWARD_BONUS_MULTIPLIER = 4;

- (int)match:(NSArray *) otherCards{
    int score = 0;
    if ([otherCards count] == 1){
        PlayingCard * otherCard = otherCards[0];
        if (self.rank == otherCard.rank){
            score = 4 * REWARD_BONUS_MULTIPLIER; //reward for rank match
        } else if ([self.suit isEqualToString: otherCard.suit]){
            score = 1 * REWARD_BONUS_MULTIPLIER; //reward for suit match
        } else {
            score = 0; //Penalty for mis-match
        }
    }
    
    return score;
}

@end
