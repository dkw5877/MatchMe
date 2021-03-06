//
//  HitMeGame.m
//  HitMe
//
//  Created by user on 2/17/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

#import "HitMeGame.h"
#import "Deck.h"
#import "HitMeGame_private.h"

@implementation HitMeGame

-(id)init
{
    self = [super init];
    
    if(self)
    {
        _deck = [[Deck alloc]init];
    }
    
    return self;
}

//getter for the validRanks, uses lazy instantiation
-(NSArray*)validRanks
{
    if(!_validRanks)
    {
     
         _validRanks =  @[@"A", @"2", @"3", @"4", @"5", @"6", @"7",
                           @"8", @"9", @"10", @"J", @"Q", @"K"];
    }
    
    return _validRanks;
}

//getter for the validSuits, uses lazy instantiation
-(NSArray *)validSuits
{
    if(!_validSuits)
    {
         _validSuits = @[@"♣︎", @"♠︎", @"♥︎", @"♦︎"];
    }
    
    return _validSuits;
}


//getter for the colorForSuits, uses lazy instantiation
-(NSDictionary *)colorForSuits
{
    if (!_colorForSuits)
    {
        _colorForSuits = @{@"♣︎":[UIColor blackColor],
                           @"♠︎":[UIColor blackColor],
                           @"♥︎":[UIColor redColor],
                           @"♦︎":[UIColor redColor]};
    }
    
    return _colorForSuits;
}


/**
 * Returns true is the deck has another card false otherwise
 *@param void
 *@return BOOL
 */
-(BOOL)hasNextCard
{
    return ([self.deck showNextCard] != nil);
}

/**
 * Returns the next card from the deck of cards
 *@param void
 *@return PlayingCard
 */
-(PlayingCard *)nextCard
{
    return[self.deck dealNextCard];
}

/**
 * Create the deck and then shuffle the deck of cards using arc4random
 *@param void
 *@return void
 */
-(void)fillAndShuffleDeck
{
    [self fillDeck];
    [self shuffleDeck];
}

/**
 *Fill the deck of cards with all ranks and suits using fast enumeration
 *@param void
 *@return void
 */
-(void)fillDeck
{
    for (NSString *rank in self.validRanks) {
        for (NSString *suit in self.validSuits) {
            [self.deck addCardWithRank:rank
                                  suit:suit
                                 color:self.colorForSuits[suit]];
        }
    }

}


/**
 *Shuffle the deck of cards using the Deck object method
 *@param void
 *@return void
 */
-(void)shuffleDeck
{
    [self.deck shuffleDeck];
}


@end
