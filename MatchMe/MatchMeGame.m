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
    TwoCardsMatch,
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

    //get the rank from the card
    NSString* rank = notification.userInfo[@"rank"];
    
    //check if rank to match is not yet set
    if (!self.rankToMatch)
    {
        self.rankToMatch = rank; //set rank to match
        self.matchState =  ReadyToMatch; //set state as ready to match
    }
    else
    {
        //check if rank matches, set matchState accordingly
        if ([self.rankToMatch isEqualToString:rank])
        {
            self.matchState = TwoCardsMatch;  //cards match
        }
        else
        {
            self.matchState = TwoCardDoMotMatch; //cards do not match
        }
        
        self.rankToMatch = nil;
    }
}


- (void)playingCardDidCompleteAnimatingToFaceUp:(NSNotification*)notification
{
    //if cards match send match noticication
    if (self.matchState == TwoCardsMatch)
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:MatchMeGameDidIndentifyMatchingCardsNotification object:self];
        
    }//if cards match send nonmatch noticication
    else if (self.matchState == TwoCardDoMotMatch)
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:MatchMeGameDidIndentifyNonmatchingCardsNotification object:self];
    }
    
    self.matchState = NotReadyToMatch;
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
