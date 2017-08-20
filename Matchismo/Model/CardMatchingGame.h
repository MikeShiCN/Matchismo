//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Yuan Shi on 2017/8/1.
//  Copyright © 2017年 Mike Yuan Shi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

typedef enum{
    twoCardGame = 2,
    threeCardGame = 3
} GameMode;

@interface CardMatchingGame : NSObject

- (instancetype) initWithCardCount: (NSUInteger)count usingDeck:(Deck *) deck;

- (void)chooseCardAtIndex:(NSUInteger) index;

- (Card *)cardAtIndex: (NSUInteger) index;

- (NSArray *) getStatusArray;

@property (nonatomic, readonly) NSInteger score;

@property (nonatomic) GameMode mode;

@property (strong, nonatomic, readonly) NSString *status;

@end

