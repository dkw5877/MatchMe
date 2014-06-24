//
//  PlayingCardCell.h
//  MatchMe
//
//  Created by user on 6/17/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlayingCardCellDataSource;

@interface PlayingCardCell : UICollectionViewCell

@property (nonatomic,weak)id<PlayingCardCellDataSource> dataSource;
- (void)refreshView;

@end

@protocol PlayingCardCellDataSource < NSObject >

- (NSString*)contentStringForPlayingCardCell:(PlayingCardCell*)playingCardCell;
- (UIColor*)colorForPlayingCardCell:(PlayingCardCell*)playingCardCell;
- (UIImageView*)imageViewForBackOfPlayingCardDell:(PlayingCardCell*)playingCardCell;


@end
