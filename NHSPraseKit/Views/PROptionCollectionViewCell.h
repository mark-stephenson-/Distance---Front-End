//
//  PROptionCollectionViewCell.h
//  NHS Prase
//
//  Created by Josh Campion on 01/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface PROptionCollectionViewCell : UICollectionViewCell
{
    IBOutlet UILabel *optionTitleLabel;
    IBOutlet UIImageView *optionImageView;
    IBOutlet UIImageView *secondOptionImageView;
}

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *labelHeightConstraint;

-(void)setOptionTitle:(NSString *)title image:(UIImage *)image andSecondImage:(UIImage *) image2;
@property (nonatomic, strong) UIColor *imageTintColor;

@end
