//
//  PlayingCardController.h
//  MatchMe
//
//  Created by user on 6/23/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PlayingCard;

@interface PlayingCardController : NSObject

- (instancetype)initWithPlayingCard:(PlayingCard*)playingCard;
- (void)connectToCell:(UICollectionViewCell*)cell;
- (void)didTapCell;

@end
