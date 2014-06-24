//
//  GameBoardViewController.m
//  MatchMe
//
//  Created by user on 6/17/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

#import "GameBoardViewController.h"
#import "PlayingCardCell.h"
#import "MatchMeGame.h"

@interface GameBoardViewController ()

@property (nonatomic)MatchMeGame* game;

@end

@implementation GameBoardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupGame];
    
}


- (void)setupGame
{
    self.game = [[MatchMeGame alloc]initWithPairs:[self numberOfPairs]];
    [self.game fillAndShuffleDeck];
}

- (NSInteger)numberOfPairs
{
    return 6;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2 * [self numberOfPairs];
}


- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PlayingCardCell* playingCardCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PlayingCardCell" forIndexPath:indexPath];
    return playingCardCell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PlayingCardCell* selectedCell = (PlayingCardCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [selectedCell didReceiveTap];
}

@end
