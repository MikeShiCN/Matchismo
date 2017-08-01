//
//  Deck.h
//  Matchismo
//
//  Created by Mike Yuan Shi on 29/07/2017.
//  Copyright © 2017 Mike Yuan Shi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
- (void)addCard:(Card *) card atTop:(BOOL)atTop;
- (void)addCard:(Card *) card;

- (Card *)drawRandomCard;

@end
