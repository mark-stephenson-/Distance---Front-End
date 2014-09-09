//
//  PRButton.m
//  NHS Prase
//
//  Created by Josh Campion on 02/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRButton.h"

@implementation PRButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setDefaults];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setDefaults];
    }
    return self;
}

-(void)setDefaults
{
    _vBuffer = 10;
    _hBuffer = 20;
    _labelButtonBuffer = 20;
    _cornerRadius = 5.0;
    _borderWidth = 2.0;
    
    [self setImage:[self imageForState:UIControlStateNormal] forState:UIControlStateNormal];
}

-(void)prepareForInterfaceBuilder
{
    [super prepareForInterfaceBuilder];
    [self setDefaults];
    [self layoutSubviews];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.layer.borderWidth = self.borderWidth;
    self.layer.borderColor = self.imageTint ? self.imageTint.CGColor : [self titleColorForState:UIControlStateNormal].CGColor;
    self.layer.cornerRadius = self.cornerRadius;
    self.contentEdgeInsets = UIEdgeInsetsMake(self.vBuffer, self.hBuffer, self.vBuffer, self.hBuffer);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, self.labelButtonBuffer, 0, 0);
    self.tintColor = self.imageTint ? self.imageTint : [self titleColorForState:UIControlStateNormal];
    self.imageView.tintColor = self.imageTint ? self.imageTint : [self titleColorForState:UIControlStateNormal];
    
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    [self layoutIfNeeded];
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:state];
}

-(CGSize)intrinsicContentSize
{
    CGSize imgSize = [self imageForState:UIControlStateNormal].size;
    NSString *title = [self titleForState:UIControlStateNormal];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = title;
#warning JRC: Requires font set here, cannot use self. propertes as becomes cyclic.
    CGSize labelSize = [titleLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    labelSize.width += 5.0;
    
    UIEdgeInsets contentInsets = self.contentEdgeInsets;
    UIEdgeInsets imgInsets = self.imageEdgeInsets;
    UIEdgeInsets titleInsets = self.titleEdgeInsets;
    
    CGFloat width = imgSize.width + labelSize.width;
    width += contentInsets.left + contentInsets.right;
    width += imgInsets.left + imgInsets.right;
    width += titleInsets.left + titleInsets.right;
    
    CGFloat height = MAX(imgSize.height, labelSize.height);
    height += contentInsets.top + contentInsets.bottom;
    height += imgInsets.top + imgInsets.bottom;
    height += titleInsets.top + titleInsets.bottom;
    
    return CGSizeMake(width, height);
}

@end
