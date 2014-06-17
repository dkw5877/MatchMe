//
//  Deck.m
//  HitMe
//
//  Created by user on 2/17/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

#import "Deck.h"


@interface Deck()

///Mutable array respresenting a deck of cards
@property(nonatomic)NSMutableArray *cards;

@end


@implementation Deck


-(NSMutableArray *)cards
{
    //use lazy instantiation to create the deck
    if(!_cards)
    {
        _cards = [[NSMutableArray alloc]initWithCapacity:100];
    }
    
    return _cards;
}

/**
 *Add a card to the deck of cards
 *@param PlayingCard the card to add to the deck
 *@return void
 */
- (void)addCard:(PlayingCard *)card
{
    [self.cards addObject:card];
}


/**
 *Show the next card in the deck
 *@param void
 *@return PlayingCard the next card in the deck
 */
- (PlayingCard *)showNextCard
{
    return[self.cards firstObject];
}


/**
 *Deal the next card in the deck
 *@param void
 *@return PlayingCard
 */
- (PlayingCard *)dealNextCard
{
    PlayingCard *cardToDeal = [self.cards firstObject];
    
    //if there was a card in the deck, remove it from the deck
    if(cardToDeal)
    {
        [self.cards removeObjectAtIndex:0];
    }
    
    return cardToDeal;
}


/**
 *Shuffle the deck of cards using arc4random
 *@param void
 *@return void
 */
-(void)shuffleDeck
{
    
    //enumerate the array using a block
    [self.cards enumerateObjectsUsingBlock:^(PlayingCard *card,
                                             NSUInteger index,
                                             BOOL *stop) {
        
        //shuffle the cards by exchanging the card at index with
        //a random card as determined by arc4random mod the size of the array
        [self.cards exchangeObjectAtIndex:index
                        withObjectAtIndex:arc4random()%[self.cards count]];
    }];
}

/**
 *
 *@param void
 *@return NSUInteger the number of cards in the deck
 */
- (NSUInteger)numberOfCardInDeck
{
    return [self.cards count];
}


@end
