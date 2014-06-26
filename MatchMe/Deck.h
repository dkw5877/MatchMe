//
//  Deck.h
//  HitMe
//
//  Created by user on 2/17/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PlayingCard;

@interface Deck : NSObject

-(NSUInteger)numberOfCardInDeck;
-(void)addCardWithRank:(NSString*)rank suit:(NSString*)suit color:(UIColor*)color;
-(PlayingCard *)showNextCard;
-(PlayingCard *)dealNextCard;
-(void)shuffleDeck;

@end
