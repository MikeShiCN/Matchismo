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

//This method will match any number of cards!
- (int)match:(NSArray *) otherCards{
    int score = 0;
    NSMutableArray *allCards = [[NSMutableArray alloc] init];
    [allCards addObjectsFromArray:otherCards];
    [allCards addObject:self];
    
    NSMutableDictionary * rankDict = [[NSMutableDictionary alloc] init];
    NSMutableDictionary * suitDict = [[NSMutableDictionary alloc] init];
    
    //Fuck Objective C... Why can't I put POD in dictionaries.
    //And Two NSNumber just can't add?! WTF...
    
    for (PlayingCard *card in allCards) {
        if (!suitDict[card.suit]) { // not in dict
            suitDict[card.suit] = @1;
        } else {
            suitDict[card.suit] = [NSNumber numberWithInt: [suitDict[card.suit] intValue] + 1];
        }
        
        if (!rankDict[[NSNumber numberWithUnsignedLong:card.rank]]){
            rankDict[[NSNumber numberWithUnsignedLong:card.rank]] = @1;
        } else {
            rankDict[[NSNumber numberWithUnsignedLong:card.rank]] =
                [NSNumber numberWithInt: [rankDict[[NSNumber numberWithUnsignedLong:card.rank]] intValue] + 1];
        }
    }
    
    int suitScore = 0;
    NSLog(@"SuitCount = %lu, RankCount = %lu", [suitDict count], [rankDict count]);
    for (NSString *suit in suitDict) {
        int count = [suitDict[suit] intValue];
        if (count > 1) {
            suitScore += 1 * (count - 1) * REWARD_BONUS_MULTIPLIER;
        }
    }
    
    int rankScore = 0;
    for (NSNumber * rank in rankDict) {
        int count = [rankDict[rank] intValue];
        if (count > 1) {
            rankScore += 4 * (count - 1) * REWARD_BONUS_MULTIPLIER;
        }
    }
    
    score = MAX(suitScore, rankScore);
    
    NSLog(@"suitScore = %d, rankScore = %d, finalScore = %d", suitScore, rankScore, score);
    
    return score;
}

@end
