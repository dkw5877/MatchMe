//
//  HitMeGame.h
//  HitMe
//
//  Created by user on 2/17/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PlayingCard;

@interface HitMeGame : NSObject

-(BOOL)hasNextCard;
-(PlayingCard *)nextCard;
-(void)fillAndShuffleDeck;

@end
