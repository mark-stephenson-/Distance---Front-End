//
//  PROptionCollectionViewCell.m
//  NHS Prase
//
//  Created by Josh Campion on 01/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PROptionCollectionViewCell.h"

@implementation PROptionCollectionViewCell


-(void)prepareForInterfaceBuilder
{
    [super prepareForInterfaceBuilder];
    
    self.contentView.layer.borderColor = [UIColor grayColor].CGColor;
    self.contentView.layer.borderWidth = 1.0;
    [self setOptionTitle:@"Strongly Agree" andImage:nil];
}

-(void)setOptionTitle:(NSString *)title andImage:(UIImage *)image
{
    optionTitleLabel.text = title;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.contentView.layer.borderColor = [UIColor grayColor].CGColor;
    self.contentView.layer.borderWidth = 1.0;
    
    if (self.selected) {
        optionTitleLabel.textColor = [UIColor whiteColor];
        optionImageView.tintColor = [UIColor whiteColor];
        
        self.contentView.backgroundColor = self.tintColor;
    } else {
        optionTitleLabel.textColor = self.tintColor;
        optionImageView.tintColor = nil;
        
        self.contentView.backgroundColor = [UIColor clearColor];
    }
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    [self layoutSubviews];
}

@end
