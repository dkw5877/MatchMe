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
#import "Constants.h"

@interface PlayingCardController ()< PlayingCardCellDataSource >

@property (nonatomic)PlayingCard* playingCard;
@property (nonatomic)PlayingCardCell* cell;
@property (nonatomic)id didMatchToken;
@property (nonatomic)id didNotMatchToken;

@end


@implementation PlayingCardController

- (instancetype)initWithPlayingCard:(PlayingCard*)playingCard
{
    self = [super init];
    
    if(self)
    {
        self.playingCard =  playingCard;
        [self registerForDidIndentifyMatchingCardsNotification];
        [self registerForDidIndentifyNonmatchingCardsNotification];
    }
    
    return self;
}

- (instancetype)init
{
    return [self initWithPlayingCard:nil];
}

/*
 *
 */
- (void)registerForDidIndentifyMatchingCardsNotification
{
    //register for notification for using block API
    self.didMatchToken = [[NSNotificationCenter defaultCenter]addObserverForName:MatchMeGameDidIndentifyMatchingCardsNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        if ([self.playingCard isFaceUp])
        {
            //fade the card out
            [UIView animateWithDuration:1.0 animations:^{
                self.cell.alpha = 0;
            }];
        }
    }];
}

/*
 *
 */
- (void)registerForDidIndentifyNonmatchingCardsNotification
{
    self.didNotMatchToken = [[NSNotificationCenter defaultCenter]addObserverForName:MatchMeGameDidIndentifyNonmatchingCardsNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        if ([self.playingCard isFaceUp])
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.playingCard hideCardFace];
            });
        }
    }];
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:MatchMeGameDidIndentifyMatchingCardsNotification];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:MatchMeGameDidIndentifyNonmatchingCardsNotification];
}

@end
