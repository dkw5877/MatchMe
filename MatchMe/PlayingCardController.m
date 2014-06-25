//
//  PlayingCardController.m
//  MatchMe
//
//  Created by user on 6/23/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

#import "PlayingCardController.h"
#import "PlayingCard.h"
#import "PlayingCardCell.h"

@interface PlayingCardController ()< PlayingCardCellDataSource >

@property (nonatomic)PlayingCard* playingCard;
@property (nonatomic)PlayingCardCell* cell;

@end


@implementation PlayingCardController

- (instancetype)initWithPlayingCard:(PlayingCard*)playingCard
{
    self = [super init];
    
    if(self)
    {
        self.playingCard =  playingCard;
    }
    
    return self;
}

- (instancetype)init
{
    return [self initWithPlayingCard:nil];
}

/*
 * When the cell is tapped send the message to the playing card to show/hide
 * the face of the card depending on current status (face up/down)
 */
- (void)didTapCell
{
    if (self.playingCard.isFaceUp)
    {
        [self.playingCard hideCardFace];
    }
    else
    {
        [self.playingCard showCardFace];
    }
}

/*
 * Sets the data source for the cell and refreshes the cell's view
 * @param UICollectionViewCell
 * @return void
 */
- (void)connectToCell:(UICollectionViewCell*)cell
{
    if ([cell isKindOfClass:[PlayingCardCell class]])
    {
        self.cell = (PlayingCardCell*)cell;
        self.cell.dataSource = self;
        [self.cell refreshView];
        [self.playingCard addObserver:self.cell forKeyPath:@"isFaceUp" options:NSKeyValueObservingOptionNew context:NULL];
    }
}

/*
 * Return a string containg the rank and suit of the playing card
 * @param PlayingCardCell
 * @return NSString
 */
- (NSString*)contentStringForPlayingCardCell:(PlayingCardCell*)playingCardCell
{
    return [NSString stringWithFormat:@"%@ %@",self.playingCard.rank, self.playingCard.suit];
}

/*
 * Return the color for the playing card
 * @param PlayingCardCell
 * @return UIColor
 */
- (UIColor*)colorForPlayingCardCell:(PlayingCardCell*)playingCardCell
{
    return self.playingCard.color;
}

/*
 * Return the image view to be used for the back of the playing card
 * @param PlayingCardCell
 * @return UIImageView
 */
- (UIImageView*)imageViewForBackOfPlayingCardDell:(PlayingCardCell*)playingCardCell
{
    UIImage *backOfCardImage = [UIImage imageNamed:@"stanford"];
    return [[UIImageView alloc]initWithImage:backOfCardImage];
}

@end
