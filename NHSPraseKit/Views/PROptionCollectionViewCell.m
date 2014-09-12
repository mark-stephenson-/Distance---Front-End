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
    optionImageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    secondOptionImageView.image = [image2 imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (borderLayer == nil) {
        borderLayer = [CAShapeLayer layer];
        [self.layer addSublayer:borderLayer];
    }
    
    for (NSLayoutConstraint *vConstr in vBufferConstraints) {
        vConstr.constant = self.vBuffer;
    }
    
    CGRect borderFrame = CGRectMake(OPTIONS_CELL_BORDER_WIDTH / 2.0, OPTIONS_CELL_BORDER_WIDTH / 2.0, self.frame.size.width - OPTIONS_CELL_BORDER_WIDTH, self.frame.size.height - OPTIONS_CELL_BORDER_WIDTH);
    borderLayer.path = [UIBezierPath bezierPathWithRect:borderFrame].CGPath;
    borderLayer.lineWidth = OPTIONS_CELL_BORDER_WIDTH;
    borderLayer.strokeColor = self.tintColor.CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    
    self.layer.masksToBounds = NO;
    self.contentView.layer.masksToBounds = NO;
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
    
    [self layoutIfNeeded];
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

-(CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize constrainedToWidth:(CGFloat)width
{
    CGFloat imageHeight = 80.0;
    CGFloat buffer = 8.0;
    
    NSLayoutConstraint *widthConstr = [NSLayoutConstraint constraintWithItem:optionTitleLabel
                                                                   attribute:NSLayoutAttributeWidth
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:0.0
                                                                    constant:width - 2.0 *buffer];
    [optionTitleLabel addConstraint:widthConstr];
    optionTitleLabel.preferredMaxLayoutWidth = widthConstr.constant;
    
    CGSize fittingSize = [optionTitleLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    fittingSize.width += 2.0 * buffer;
    fittingSize.height += imageHeight;
    fittingSize.height += 3.0 * self.vBuffer;
    
    [optionTitleLabel removeConstraint:widthConstr];
    
    return fittingSize;
}

@end
