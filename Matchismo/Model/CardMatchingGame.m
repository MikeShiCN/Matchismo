//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Yuan Shi on 2017/8/1.
//  Copyright © 2017年 Mike Yuan Shi. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;

@end

@implementation CardMatchingGame


//Designated Initializer
- (instancetype) initWithCardCount: (NSUInteger)count usingDeck:(Deck *) deck {
    self = [super init];
    if (!self) {return self;}
    
    for (unsigned i = 0; i < count; i++){
        self.cards[i] = [deck drawRandomCard];
        if (!self.cards[i]) { return nil; }
    }
    
    return self;
}

- (void) setScore:(NSInteger)score {
    NSLog(@"Score = %ld", score);
    _score = score;
}

- (NSMutableArray *) cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

- (Card *)cardAtIndex:(NSUInteger)index{
    if (index >= [self.cards count]){
        NSLog(@"index[%u] beyond count in %s", (unsigned) index, __func__);
    }
    
    return self.cards[index];
}

static const int COST_TO_CHOOSE = -1;

- (void)chooseCardAtIndex:(NSUInteger) index {
    if (index >= [self.cards count]) {
        NSLog(@"Index[%lu] out of bounds in [%s]",  (unsigned long)index, __func__);
        return;
    }
    
//    Card * curCard = self.cards[index];
    Card * curCard = [self cardAtIndex:index];
    if (curCard.isChosen || curCard.isMatched) {
        curCard.chosen = false;
        return;
    }
    
    curCard.chosen = true;
    self.score += COST_TO_CHOOSE;
    for (Card * otherCard in self.cards){
        if (otherCard == curCard) { continue; }
        if (otherCard.isChosen){
            int matchScore = [curCard match:@[otherCard]];
            self.score += matchScore;
            if (matchScore > 0){
                curCard.matched = true;
                otherCard.matched = true;
                curCard.chosen = false;
                otherCard.chosen = false;
            } else {
                otherCard.chosen = false;
            }
        }
    }
}

@end
