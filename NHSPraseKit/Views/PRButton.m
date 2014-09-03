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
    self.tintColor = nil;
    self.imageView.tintColor = self.imageTint ? self.imageTint : [self titleColorForState:UIControlStateNormal];
    
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    if (self.frame.size.width < self.intrinsicContentSize.width) {
        self.titleLabel.numberOfLines = 0;
    
        [self layoutIfNeeded];
    } else {
        //self.titleLabel.numberOfLines = 1;
        
        //[self layoutIfNeeded];
    }
}

-(CGSize)intrinsicContentSize
{
    CGSize imgSize = [self.imageView intrinsicContentSize];
    CGSize labelSize = [self.titleLabel intrinsicContentSize];
    
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
