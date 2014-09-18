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
    _vBuffer = _vBuffer == 0 ? 10 : _vBuffer;
    _hBuffer = _hBuffer == 0 ? 20 : _hBuffer;
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
    
    //self.titleLabel.backgroundColor = [UIColor redColor];
    //self.imageView.backgroundColor = [UIColor blueColor];
    
    self.layer.borderWidth = self.borderWidth;
    self.layer.cornerRadius = self.cornerRadius;
    self.contentEdgeInsets = UIEdgeInsetsMake(self.vBuffer, self.hBuffer, self.vBuffer, self.hBuffer);
    
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    // adjust the title insets for the labelButton buffer variable if an image exists for the current state
    if ([self imageForState:self.state]) {
        UIEdgeInsets cTitle = self.titleEdgeInsets;
        if (self.imageAlignment == kPRButtonImageAlignmentLeft) {
            
            cTitle.left = self.labelButtonBuffer;
            
        } else if (self.imageAlignment == kPRButtonImageAlignmentRight) {
            
            cTitle.left = 0;
            cTitle.right = self.labelButtonBuffer;
            
        } else if (self.imageAlignment == kPRButtonImageAlignmentTop) {
            
            cTitle.left = 0;
            cTitle.right = 0;
            
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.titleLabel.preferredMaxLayoutWidth = [self titleRectForContentRect:[self contentRectForBounds:self.bounds]].size.width;
            CGSize intrinsicTitleSize = [self.titleLabel intrinsicContentSize];
            
            if (intrinsicTitleSize.width > self.titleLabel.frame.size.width || intrinsicTitleSize.height > self.titleLabel.frame.size.height) {
                // causes size calculations to take too long
                //[self invalidateIntrinsicContentSize];
                //[self setNeedsLayout];
            }
        }
        
        self.titleEdgeInsets = cTitle;
    }
    
    // colour configuration
    
    if (self.state == UIControlStateDisabled) {
        // use the title colour as light grey my be used elsewhere and thus number be visible on the background.
        UIColor *disabledColour = [self titleColorForState:UIControlStateDisabled];
        
        self.layer.borderColor = disabledColour.CGColor;
        self.tintColor = disabledColour;
        self.imageView.tintColor = disabledColour;
    } else {
        self.layer.borderColor = self.imageTint ? self.imageTint.CGColor : [self titleColorForState:UIControlStateNormal].CGColor;
        self.tintColor = self.imageTint ? self.imageTint : [self titleColorForState:UIControlStateNormal];
        self.imageView.tintColor = self.imageTint ? self.imageTint : [self titleColorForState:UIControlStateNormal];
        
    }
    
    
    [self layoutIfNeeded];
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:state];
}

-(CGSize)intrinsicContentSize
{
    CGSize imgSize = [self imageForState:UIControlStateNormal].size;
    
    CGSize labelSize = [self.titleLabel intrinsicContentSize];
    
    UIEdgeInsets contentInsets = self.contentEdgeInsets;
    UIEdgeInsets imgInsets = self.imageEdgeInsets;
    UIEdgeInsets titleInsets = self.titleEdgeInsets;
    
    CGFloat width = 0.0;
    CGFloat height = 0.0;
    
    if (self.imageAlignment == kPRButtonImageAlignmentTop) {
        
        width = MAX(imgSize.width + imgInsets.left + imgInsets.right, labelSize.width + titleInsets.left + titleInsets.right);
        width += contentInsets.left + contentInsets.right;
        
        height = imgSize.height + labelSize.height;
        height += contentInsets.top + contentInsets.bottom;
        height += imgInsets.top + imgInsets.bottom;
        height += titleInsets.top + titleInsets.bottom;
        
    } else {
        width = imgSize.width + labelSize.width;
        width += contentInsets.left + contentInsets.right;
        width += imgInsets.left + imgInsets.right;
        width += titleInsets.left + titleInsets.right;
        
        height = MAX(imgSize.height + imgInsets.top + imgInsets.bottom, labelSize.height + titleInsets.top + titleInsets.bottom);
        height += contentInsets.top + contentInsets.bottom;
    }
    
    
    return CGSizeMake(width, height);
}

#pragma mark - Alignment Methods


-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGRect titleRect = [super titleRectForContentRect:contentRect];
    
    if (self.imageAlignment == kPRButtonImageAlignmentRight) {
        // This creates a control left alignment
        titleRect.origin.x = CGRectGetMinX(contentRect) + self.titleEdgeInsets.left;
    } else if (self.imageAlignment == kPRButtonImageAlignmentTop) {
        CGRect imgRect = [self imageRectForContentRect:contentRect];
        
        titleRect.size.width = contentRect.size.width -= self.titleEdgeInsets.left + self.titleEdgeInsets.right;
        titleRect.size.height = contentRect.size.height -= imgRect.size.height + self.titleEdgeInsets.top + self.titleEdgeInsets.bottom + self.imageEdgeInsets.top + self.imageEdgeInsets.bottom;
        titleRect.origin.x = CGRectGetMidX(contentRect) - titleRect.size.width / 2.0;
        titleRect.origin.y = CGRectGetMaxY(imgRect) + self.imageEdgeInsets.bottom + self.titleEdgeInsets.top;
    }
    
//    NSLog(@"----");
//    NSLog(@"%@", [self titleForState:UIControlStateNormal]);
//    NSLog(@"Content: %@ [%@]", NSStringFromCGRect(contentRect), NSStringFromUIEdgeInsets(self.contentEdgeInsets));
//    NSLog(@"Title: %@ [%@]", NSStringFromCGRect(titleRect), NSStringFromUIEdgeInsets(self.titleEdgeInsets));
//    NSLog(@"----");
    
    return titleRect;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGRect imgRect = [super imageRectForContentRect:contentRect];
    
    if (self.imageAlignment == kPRButtonImageAlignmentRight) {
        // This creates a control left alignment
        CGRect titleRect = [self titleRectForContentRect:contentRect];
        imgRect.origin.x = CGRectGetMaxX(titleRect) + self.titleEdgeInsets.right + self.imageEdgeInsets.left;
    } else if (self.imageAlignment == kPRButtonImageAlignmentTop) {
        // centers the image at the top of the button
        imgRect.size = [[self imageForState:self.state] size];
        imgRect.origin.x = CGRectGetMidX(contentRect) - imgRect.size.width / 2.0;
        imgRect.origin.y = CGRectGetMinY(contentRect) + self.imageEdgeInsets.top;
    }
//    
//    NSLog(@"----");
//    NSLog(@"%@", [self titleForState:UIControlStateNormal]);
//    NSLog(@"Content: %@ [%@]", NSStringFromCGRect(contentRect), NSStringFromUIEdgeInsets(self.contentEdgeInsets));
//    NSLog(@"Image: %@ [%@]", NSStringFromCGRect(imgRect), NSStringFromUIEdgeInsets(self.imageEdgeInsets));
//    NSLog(@"Self: %@", NSStringFromCGRect(self.frame));
//    NSLog(@"----");
    
    return imgRect;
}

-(CGSize)contentDifference
{
    CGRect contentRect = [self contentRectForBounds:self.bounds];
    CGRect titleRect = [super titleRectForContentRect:contentRect];
    CGRect imageRect = [super imageRectForContentRect:contentRect];
    
    CGFloat wDiff = contentRect.size.width - (titleRect.size.width + imageRect.size.width);
    CGFloat hDiff = contentRect.size.height - (titleRect.size.height + imageRect.size.height);
    
    return CGSizeMake(wDiff, hDiff);
}

@end
