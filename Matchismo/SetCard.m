//
//  SetCard.m
//  Matchismo
//
//  Created by Yuan Shi on 2017/8/13.
//  Copyright © 2017年 Mike Yuan Shi. All rights reserved.
//

#import "SetCard.h"

@interface SetCard()

@property (nonatomic) NSInteger  testValue;

@end

@implementation SetCard

+ (NSArray *) validShapes {
    return @[@"▲", @"●", @"■"];
}

+ (NSArray *) validColors {
    return @[@"Red", @"Yellow", @"Blue"];
}

+ (NSArray *) validShades {
    return @[@"Open", @"Stripped", @"Solid"];
}

+ (NSArray *) validNumbers {
    return @[@"1", @"2", @"3"];
}

- (void) setNumber:(NSString *)number {
    if ([[SetCard validNumbers] containsObject: number]) {
        _number = number;
    } else {
        NSLog(@"setNumber: got invalid number :%@", number);
    }
}

- (void) setShade:(NSString *)shade {
    if ([[SetCard validShades] containsObject: shade]) {
        _shade = shade;
    } else {
        NSLog(@"setShade: got invalid shade :%@", shade);
    }
}

- (void) setColor:(NSString *)color {
    if ([[SetCard validColors] containsObject: color]) {
        _color = color;
    } else {
        NSLog(@"setColor: got invalid color :%@", color);
    }
}

- (void) setShape:(NSString *)shape {
    if ([[SetCard validShapes] containsObject: shape]) {
        _shape = shape;
    } else {
        NSLog(@"setShape: got invalid shape :%@", shape);
    }
}

- (NSString *) contents {
    NSArray * contentsArray = @[[self number], [self shape], [self shade], [self color]];
    return [contentsArray componentsJoinedByString:@"."];

}

- (BOOL) setMatchWithSelector: (NSArray *) allCards sel: (SEL)sel {
    BOOL matched = NO;
    if ([allCards count] != 3){
        NSLog(@"%s: cards number incorrect, should be 3", __func__);
        return NO;
    }
    
    NSMutableArray * valueArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++){
        valueArray[i] = [allCards[i] performSelector:sel];
    }

    if ([valueArray[0] isEqualToString: valueArray[1]]
        && [valueArray[0] isEqualToString: valueArray[2]]) {
        matched = YES;
    }
    
    if ((![valueArray[0] isEqualToString:valueArray[1]])
        &&(![valueArray[0] isEqualToString:valueArray[2]])
        &&(![valueArray[1] isEqualToString:valueArray[2]])) {
        matched = YES;
    }

    NSLog(@"V1=%@, V2=%@, V3=%@", valueArray[0], valueArray[1], valueArray[2]);
    
    return matched;
}
static const int SCORE_FOR_MATCH = 16;
static const int PENALTY_FOR_MISMATCH = -16;
- (int) match:(NSArray *)otherCards {
    int score = 0;
    NSMutableArray * allCards = [[NSMutableArray alloc] init];
    [allCards addObjectsFromArray:otherCards];
    [allCards addObject:self];
    
    BOOL matched = YES;
    matched = matched && ([self setMatchWithSelector:allCards sel:@selector(number)]);
    matched = matched && ([self setMatchWithSelector:allCards sel:@selector(shape)]);
    matched = matched && ([self setMatchWithSelector:allCards sel:@selector(shade)]);
    matched = matched && ([self setMatchWithSelector:allCards sel:@selector(color)]);
    
    if (matched){
        score = SCORE_FOR_MATCH;
    } else {
        score = PENALTY_FOR_MISMATCH;
    }
    
    return score;
}

@end
