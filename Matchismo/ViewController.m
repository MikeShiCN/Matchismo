//
//  ViewController.m
//  Matchismo
//
//  Created by Mike Yuan Shi on 29/07/2017.
//  Copyright © 2017 Mike Yuan Shi. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) NSUInteger flipCount;
@property (strong, nonatomic) PlayingCardDeck *deck;

@end

@implementation ViewController

- (PlayingCardDeck* ) deck{
    if (_deck == nil){
        _deck = [[PlayingCardDeck alloc] init];
    }
    
    return _deck;
}

- (IBAction)touchCardButton:(UIButton *)sender {

    if ([sender.currentTitle length]){
        UIImage *cardImage = [UIImage imageNamed: @"cardback"];
        [sender setBackgroundImage:cardImage forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        PlayingCard * card = (PlayingCard *)[self.deck drawRandomCard];
        if (card == nil) {
            NSLog(@"Trying to Flip, But No More Cards in Deck");
            return;
        }
        [sender setBackgroundImage:[UIImage imageNamed: @"cardfront"]
                          forState:UIControlStateNormal];
        [sender setTitle:card.contents forState:UIControlStateNormal];
//        [sender setTitle: @"A♣︎" forState: UIControlStateNormal];
    }
    self.flipCount++;
}

- (void) setFlipCount:(NSUInteger)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat: @"Flips: %lu", (unsigned long)self.flipCount];
    NSLog(@"Flipcount = %lu", self.flipCount);
}

@end
