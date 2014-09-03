//
//  PROptionCollectionViewCell.m
//  NHS Prase
//
//  Created by Josh Campion on 01/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PROptionCollectionViewCell.h"

@implementation PROptionCollectionViewCell


-(void)setOptionTitle:(NSString *)title image:(UIImage *)image andSecondImage:(UIImage *) image2
{
    optionTitleLabel.text = title;
    optionImageView.image = image;
    secondOptionImageView.image = image2;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.layer.borderColor = self.tintColor.CGColor;
    self.layer.borderWidth = 2.0;
    
    if (self.selected) {
        optionTitleLabel.textColor = [UIColor whiteColor];
        optionImageView.tintColor = [UIColor whiteColor];
        secondOptionImageView.tintColor = [UIColor whiteColor];
        
        self.contentView.backgroundColor = self.tintColor;
    } else {
        optionTitleLabel.textColor = self.tintColor;
        optionImageView.tintColor = self.imageTintColor;
        secondOptionImageView.tintColor = self.imageTintColor;
        
        self.contentView.backgroundColor = [UIColor clearColor];
    }
}

-(void)setImageTintColor:(UIColor *)imageTintColor
{
    _imageTintColor = imageTintColor;
    
    optionImageView.tintColor = imageTintColor;
    secondOptionImageView.tintColor = imageTintColor;
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    [self layoutSubviews];
}

@end
