//
//  PlayingCardCell.m
//  MatchMe
//
//  Created by user on 6/17/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

#import "PlayingCardCell.h"

@interface PlayingCardCell()
@property (weak, nonatomic) IBOutlet UILabel *playingCardLabel;
@end

@implementation PlayingCardCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.cornerRadius = self.frame.size.width/16;
    [self customizeLabel];
    [self configureBackOfCard];
}


/*
 * Customize the playing card labels text
 */
- (void)customizeLabel
{
    self.playingCardLabel.attributedText = [[NSAttributedString alloc]initWithString:[self labelContentString] attributes:[self labelAttributes]];
}


/*
 * Utility method to return the content of the label
 * @return NSString content of the label
 */
- (NSString*)labelContentString
{
    return self.playingCardLabel.text;
}

/*
 * Utility method to set the attributes of the label
 * @return NSDictionary label attributes
 */
- (NSDictionary*)labelAttributes
{
//    return @{NSFontAttributeName:[UIFont boldSystemFontOfSize:24.0],
//             NSForegroundColorAttributeName:self.playingCardLabel.textColor,
//             NSTextEffectAttributeName:NSTextEffectLetterpressStyle};
    
    //place a gold boarder around the label text, leave the text color unchanged (red or black)
    return @{NSStrokeColorAttributeName:[self goldColor],
                 NSForegroundColorAttributeName:self.playingCardLabel.textColor,
                 NSStrokeWidthAttributeName:@(-5),
                 NSFontAttributeName:[UIFont boldSystemFontOfSize:20]};
}


/*
 * Display an image on the background view of the cell
 */
- (void)configureBackOfCard
{
    UIImage* stanfordImage = [UIImage imageNamed:@"stanford"];
    UIImageView* backOfCard = [[UIImageView alloc]initWithImage:stanfordImage];
    self.backgroundView = backOfCard;
}

/*
 * 
 */
 - (void)didReceiveTap
{
    [UIView animateWithDuration:.15 animations:[self flipHalfway] completion:^(BOOL finished) {
        [self reverseCard];
        [self animateFlipTheRestOfTheWay];
    }];
}

/*
 * Flip the image halfway be scaling the x-axis to 100th the original size
 * @return returns an animation block
 */
- (void(^)(void))flipHalfway
{
    return ^{
        self.transform = CGAffineTransformMakeScale(0.01,1);
        self.center = CGPointMake(self.center.x + self.frame.size.width/2,
                                  self.center.y);
    };

}


/*
 * Flip the image from the scaled 100th size to original size
 * @return returns an animation block
 */
- (void(^)(void))flipTheRestOfTheWay
{
    return ^{
        self.transform = CGAffineTransformIdentity;
    };
}


- (void)animateFlipTheRestOfTheWay
{
    [UIView animateWithDuration:.15 animations:[self flipTheRestOfTheWay]];
}

/*
 * Reverse the appearance of the card by hiding/unhiding the label and background image
 */
- (void)reverseCard
{
    self.playingCardLabel.hidden = !self.playingCardLabel.hidden;
    self.backgroundView.hidden = !self.backgroundView.hidden;
}

/*
 * Returns a rectangle that has an even margin all the way around it
 * @param CGRect representing the rectangle that is the border of each playing card
 * @return CGRect rectangle that has an even margin all the way around it
 */
- (CGRect)innerRectForRect:(CGRect)rect
{
    CGFloat margin = rect.size.width/15;
    return CGRectMake(margin, margin, rect.size.width - 2 * margin, rect.size.height - 2 * margin);
}

/*
 * returns a UIColor that looks like the color gold
 * @return UIColor gold
 */
- (UIColor*)goldColor
{
    return [UIColor colorWithRed:1.0 green:0.8 blue:0.0 alpha:1.0];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //create a bezier path
    UIBezierPath* bezierPath = [UIBezierPath bezierPathWithRoundedRect:[self innerRectForRect:rect] cornerRadius:3];
    
    //set the line width
    bezierPath.lineWidth = 2;
    
    //set the line color to gold
    [[self goldColor]setStroke];
    
    //draw the line
    [bezierPath stroke];
}


@end
