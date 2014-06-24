//
//  HitMeGame_private.h
//  MatchMe
//
//  Created by user on 6/23/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

#import "HitMeGame.h"

@class Deck;

@interface HitMeGame ()

@property(nonatomic)NSArray *validRanks;
@property(nonatomic)NSArray *validSuits;
@property(nonatomic)NSDictionary *colorForSuits;
@property(nonatomic)Deck *deck;

@end
