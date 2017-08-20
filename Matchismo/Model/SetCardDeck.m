//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Yuan Shi on 2017/8/20.
//  Copyright © 2017年 Mike Yuan Shi. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype) init {
    self = [super init];
    
    if (self) {
        for (NSString * shape in [SetCard validShapes]) {
            for (NSString * number in [SetCard validColors]) {
                for (NSString * shade in [SetCard validShades]) {
                    for (NSString * color in [SetCard validColors]) {
                        SetCard * card = [[SetCard alloc] init];
                        card.number = number;
                        card.color = color;
                        card.shape = shape;
                        card.shade = shade;
                        [self addCard:card];
                    }
                }
            }
        }
        
    }
    
    return self;
}

@end
