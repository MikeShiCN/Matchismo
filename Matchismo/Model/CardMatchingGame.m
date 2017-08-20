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
@property (nonatomic, strong, readwrite) NSString *status;
@property (nonatomic, strong) NSMutableArray *statusArray;

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

- (void) setStatus:(NSString *)status {
    _status = status;
    [self.statusArray addObject:status];
}

- (NSMutableArray *) statusArray {
    if (!_statusArray) {
        _statusArray = [[NSMutableArray alloc] init];
    }
    return _statusArray;
}

- (NSArray *)getStatusArray {
    return self.statusArray;
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

- (NSString *) getCardsString:(NSArray *)cards{
    NSMutableString * cardsString = [[NSMutableString alloc] init];
    
    for (Card *card in cards){
        [cardsString appendString: card.contents];
    }
    
    return cardsString;
}

//Choose a card and Match again n-cards
- (void)chooseCardAtIndex:(NSUInteger) index {
    if (index >= [self.cards count]) {
        NSLog(@"Index[%lu] out of bounds in [%s]",  (unsigned long)index, __func__);
        return;
    }
    
    Card * curCard = [self cardAtIndex:index];
    
    if (curCard.isMatched) {
        //should never happen
        NSLog(@"Fatal: Choosing a card already matched! card = [%@]", curCard.contents);
        return;
    }
    
    //Flip the card
    curCard.chosen = !curCard.isChosen;
    self.score += COST_TO_CHOOSE;
    
    NSMutableArray * allChosenCards = [[NSMutableArray alloc] init];
    
    for (Card * card in self.cards) {
        if (card.isChosen) {
            [allChosenCards addObject:card];
        }
    }
    NSLog(@"count = %lu, mode=%d", (unsigned long)[allChosenCards count], self.mode);
    if ([allChosenCards count] == self.mode) {
        //Let's Match
        NSMutableArray * allOtherChosenCards = [[NSMutableArray alloc] init];
        [allOtherChosenCards addObjectsFromArray:allChosenCards];
        [allOtherChosenCards removeObject:curCard];
        
        int matchScore = [curCard match:allOtherChosenCards];
        self.score += matchScore;
        
        if (matchScore > 0){
            for (Card * card in allChosenCards) {
                card.matched = YES;
                card.chosen = NO;
            }
            self.status = [NSString stringWithFormat:@"Matched:%@ for %d points",
                           [self getCardsString:allChosenCards], matchScore];
            
        } else {
            for (Card * card in allOtherChosenCards) {
                card.chosen = NO;
            }
            self.status = [NSString stringWithFormat:@"%@ don't match! %d points penalty!",
                          [self getCardsString:allChosenCards], matchScore];
        }
        
    } else {
//        self.status = [self getCardsString:allChosenCards];
    }
    NSLog(@"%@", self.status);

}

@end
