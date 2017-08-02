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
#import "CardMatchingGame.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic) NSUInteger flipCount;
@property (strong, nonatomic) PlayingCardDeck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@end

@implementation ViewController

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
    }
    return _game;
}

- (PlayingCardDeck *) createDeck{
    return [[PlayingCardDeck alloc] init];
}

- (PlayingCardDeck* ) deck{
    if (_deck == nil){
        _deck = [self createDeck];
    }
    
    return _deck;
}

- (void)newGame {
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                              usingDeck:[self createDeck]];
}

- (void) updateUI{
    for (unsigned i = 0; i < [self.cardButtons count]; i++) {
        PlayingCard * card = (PlayingCard *)[self.game cardAtIndex:i];
        UIButton * button = self.cardButtons[i];
        if (card.isChosen || card.isMatched) {
            [button setTitle:card.contents forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"cardfront"] forState:UIControlStateNormal];
        } else {
            [button setTitle:@"" forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"cardback"]
                              forState:UIControlStateNormal];
        }
        
        if (card.isMatched){
            button.enabled = false;
        } else {
            button.enabled = true;
        }
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score:%ld", (long)self.game.score];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger chooseButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chooseButtonIndex];
    [self updateUI];
/*    if ([sender.currentTitle length]){
        UIImage *cardImage = [UIImage imageNamed: @"cardback"];
        [sender setBackgroundImage:cardImage forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        PlayingCard * card = (PlayingCard *)[self.deck drawRandomCard];
        if (card == nil) {
            NSLog(@"Trying to Flip, But No More Cards in Deck");
            sender.enabled = false;
            return;
        }
        [sender setBackgroundImage:[UIImage imageNamed: @"cardfront"]
                          forState:UIControlStateNormal];
        [sender setTitle:card.contents forState:UIControlStateNormal];
//        [sender setTitle: @"A♣︎" forState: UIControlStateNormal];
    }*/
    self.flipCount++;
}
- (IBAction)restart:(UIButton *)sender {
    [self newGame];
    [self updateUI];
}

- (void) setFlipCount:(NSUInteger)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat: @"Flips: %lu", (unsigned long)self.flipCount];
    NSLog(@"Flipcount = %lu, in [%s]", self.flipCount, __func__);
}

@end
