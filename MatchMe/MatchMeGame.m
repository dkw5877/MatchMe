//
//  MatchMeGame.m
//  MatchMe
//
//  Created by user on 6/23/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

#import "MatchMeGame.h"
#import "HitMeGame_private.h"
#import "Deck.h"
#import "Constants.h"

typedef enum MatchMePairMatchState:NSUInteger
{
    NotReadyToMatch,
    ReadyToMatch,
    TwoCardMatch,
    TwoCardDoMotMatch
    
} MatchMePairMatchState;

@interface MatchMeGame ()

@property (nonatomic)NSInteger pairs;
@property (nonatomic)NSString* rankToMatch;
@property (nonatomic)MatchMePairMatchState matchState;

@end

@implementation MatchMeGame


- (instancetype)initWithPairs:(NSInteger)pairs
{
    if(self = [super init])
    {
        _pairs = pairs;
        
        //register for notification of playing card changes
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playingCardDidGetTurnedFaceUp:) name:PlayingCardDidBecomeFaceUpNotification object:nil];
        
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playingCardDidCompleteAnimatingToFaceUp:) name:PlayingCardCellDidFinishFlippingCardNotification object:nil];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithPairs:0];
}


- (void)playingCardDidGetTurnedFaceUp:(NSNotification*)notification
{
    NSLog(@"notification: %@", notification);
}


- (void)playingCardDidCompleteAnimatingToFaceUp:(NSNotification*)notification
{
    
}


- (NSArray*)ranksForMatchMeGame
{
    NSMutableArray* ranksForMatchMeGame = [self.validRanks mutableCopy];
    
    while (ranksForMatchMeGame.count > self.pairs)
    {
        int randomRank = arc4random() % ranksForMatchMeGame.count;
        [ranksForMatchMeGame removeObjectAtIndex:randomRank];
    }
    
    return ranksForMatchMeGame;
}

- (NSArray*)suitsForRank
{
    NSMutableArray* suitsForRank = [self.validSuits mutableCopy];
    
    while (suitsForRank.count > 2)
    {
        int randomSuit = arc4random() % suitsForRank.count;
        [suitsForRank removeObjectAtIndex:randomSuit];
    }
    
    return suitsForRank;
}


- (void)fillDeck
{
    self.deck = [[Deck alloc]init];
    
    [[self ranksForMatchMeGame] enumerateObjectsUsingBlock:^(NSString *rank, NSUInteger indexRank, BOOL *stopRank) {
        
        [[self suitsForRank]enumerateObjectsUsingBlock:^(NSString* suit, NSUInteger indexSuit, BOOL *stopSuit) {
            
            [self.deck addCardWithRank:rank suit:suit color:self.colorForSuits[suit]];
        }];
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PlayingCardDidBecomeFaceUpNotification object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:PlayingCardCellDidFinishFlippingCardNotification object:nil];
}






@end
