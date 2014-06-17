//
//  PlayingCard.h
//  HitMe
//
//  Created by user on 2/17/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayingCard : NSObject

@property(nonatomic,readonly,strong)NSString *rank;
@property(nonatomic,readonly,strong)NSString *suit;
@property(nonatomic,readonly,strong)UIColor *color;

-(instancetype)initWithRank:(NSString*)rank suit:(NSString*)suit color:(UIColor *)color;

@end
