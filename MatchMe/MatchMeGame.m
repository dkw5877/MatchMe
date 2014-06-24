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
#import "PlayingCard.h"

@interface MatchMeGame ()

@property (nonatomic)NSInteger pairs;

@end

@implementation MatchMeGame


- (instancetype)initWithPairs:(NSInteger)pairs
{
    if(self = [super init])
    {
        _pairs = pairs;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithPairs:0];
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
            
            [self.deck addCard:[[PlayingCard alloc]initWithRank:rank suit:suit color:self.colorForSuits[suit]]];
            
        }];
        
    }];
    
}

@end
