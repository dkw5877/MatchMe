//
//  GameBoardViewController.m
//  MatchMe
//
//  Created by user on 6/17/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

#import "GameBoardViewController.h"
#import "PlayingCardCell.h"

@interface GameBoardViewController ()


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

@end
