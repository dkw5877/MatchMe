//
//  PlayingCard.m
//  HitMe
//
//  Created by user on 2/17/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard


-(instancetype)init
{
    //make the default initializer call initWithRank and set values to nil
    return [self initWithRank:nil suit:nil color:nil];
}


/**
 *Create a playing card with rank, suit, and color
 *@param NSString rank of card
 *@param NSString suit of card
 *@param UIColor color of card
 *@return instancetype instance of playing card
 */
-(instancetype)initWithRank:(NSString*)rank suit:(NSString*)suit color:(UIColor *)color
{
    
    self = [super init];
    
    if(self)
    {
        _rank = rank;
        _suit = suit;
        _color = color;
    }
    return self;
}

@end
