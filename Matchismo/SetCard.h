//
//  SetCard.h
//  Matchismo
//
//  Created by Yuan Shi on 2017/8/13.
//  Copyright © 2017年 Mike Yuan Shi. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

+ (NSArray *) validShapes;
+ (NSArray *) validNumbers;
+ (NSArray *) validShades;
+ (NSArray *) validColors;

@property (strong, nonatomic) NSString * number;
@property (strong, nonatomic) NSString * color;
@property (strong, nonatomic) NSString * shape;
@property (strong, nonatomic) NSString * shade;

@end
