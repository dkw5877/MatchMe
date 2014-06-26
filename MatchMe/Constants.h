//
//  Constants.h
//  MatchMe
//
//  Created by user on 6/26/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

extern NSString* const PlayingCardDidBecomeFaceUpNotification;
extern NSString* const PlayingCardCellDidFinishFlippingCardNotification;
extern NSString* const MatchMeGameDidIndentifyMatchingCardsNotification;
extern NSString* const MatchMeGameDidIndentifyNonmatchingCardsNotification;

@end
