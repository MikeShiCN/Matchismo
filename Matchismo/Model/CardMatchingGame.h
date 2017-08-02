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
@interface CardMatchingGame : NSObject

- (instancetype) initWithCardCount: (NSUInteger)count usingDeck:(Deck *) deck;

- (void)chooseCardAtIndex:(NSUInteger) index;

- (Card *)cardAtIndex: (NSUInteger) index;

@property (nonatomic, readonly) NSInteger score;

@end
