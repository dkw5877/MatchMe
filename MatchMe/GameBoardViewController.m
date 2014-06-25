//
//  GameBoardViewController.m
//  MatchMe
//
//  Created by user on 6/17/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

#import "GameBoardViewController.h"
#import "MatchMeGame.h"
#import "PlayingCardController.h"

@interface GameBoardViewController ()

@property (nonatomic)MatchMeGame* game;
@property (nonatomic)NSArray* playingCardControllers;

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
    [self dealCards];
    
}


- (void)setupGame
{
    self.game = [[MatchMeGame alloc]initWithPairs:[self numberOfPairs]];
    [self.game fillAndShuffleDeck];
}

/*
 * override the getter method to create and fill the array
 */
- (NSArray*)dealCards
{
    NSMutableArray* tempControllers = [[NSMutableArray alloc]initWithCapacity:[self numberOfCards]];
    
    for (int i = 0; i < [self numberOfCards]; i++)
    {
        [tempControllers addObject:[[PlayingCardController alloc]initWithPlayingCard:[self.game nextCard]]];
    }
    
    self.playingCardControllers = tempControllers;
    return _playingCardControllers;
}


- (NSInteger)numberOfCards
{
    return 2 * [self numberOfPairs];
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
    UICollectionViewCell* playingCardCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PlayingCardCell" forIndexPath:indexPath];
    
    PlayingCardController* controllerForCell = self.playingCardControllers[indexPath.item];
    [controllerForCell connectToCell:playingCardCell];
    return playingCardCell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PlayingCardController* selectedController = self.playingCardControllers[indexPath.item];
    [selectedController didTapCell];
}

@end
