//
//  MatchMeGame.h
//  MatchMe
//
//  Created by user on 6/23/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

#import "HitMeGame.h"

@interface MatchMeGame : HitMeGame

/**
 @discussion The designated initializer.
 @param pairs The number of pairs for this game. This number should be no greater than 13.
*/
- (instancetype)initWithPairs:(NSInteger)pairs;

@end
