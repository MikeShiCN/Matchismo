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
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeControl;

@property (strong, nonatomic) PlayingCardDeck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (nonatomic) BOOL isInGame;
@end

@implementation ViewController

- (CardMatchingGame *)game {
    if (!_game) {
        [self newGame];
//        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
//                                                  usingDeck:[self createDeck]];
    
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

- (GameMode) getGameModeByIndex: (NSUInteger) index {
    if (index == 0){
        return twoCardGame;
    } else {
        return threeCardGame;
    }
}

- (void)newGame {
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                              usingDeck:[self createDeck]];
    self.isInGame = NO;
    _game.mode = [self getGameModeByIndex:self.gameModeControl.selectedSegmentIndex] ;
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

    if (self.isInGame) {
        self.gameModeControl.enabled = NO;
    } else {
        self.gameModeControl.enabled = YES;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score:%ld", (long)self.game.score];
    self.status.text = self.game.status;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger chooseButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chooseButtonIndex];
    self.isInGame = YES;
    [self updateUI];


}
- (IBAction)restart:(UIButton *)sender {
    [self newGame];
    [self updateUI];
}
- (IBAction)touchGameModeSegment:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0){
        self.game.mode = twoCardGame;
    } else {
        self.game.mode = threeCardGame;
    }
    NSLog(@"GameMode = %u", self.game.mode);
}


@end
