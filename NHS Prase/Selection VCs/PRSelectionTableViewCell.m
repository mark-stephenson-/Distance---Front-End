//
//  PRSelectionTableViewCell.m
//  NHS Prase
//
//  Created by Josh Campion on 15/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRSelectionTableViewCell.h"

@implementation PRSelectionTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    selectionIndicator.tintColor = [UIColor whiteColor];
    
    // Configure the view for the selected state
    if (selected) {
        self.contentView.backgroundColor = self.tintColor;
        self.textLabelTD.textColor = [UIColor whiteColor];
        
    } else {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabelTD.textColor = [UIColor darkTextColor];
    }
    
    [self setNeedsUpdateConstraints];
    [self setNeedsLayout];
    [self invalidateIntrinsicContentSize];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabelTD.preferredMaxLayoutWidth = self.textLabelTD.frame.size.width;
    
//    NSLog(@"Text Label: %@ [%@]", self.textLabelTD.text, NSStringFromCGSize(self.textLabelTD.intrinsicContentSize));
    
    //[self layoutIfNeeded];
}

/*
-(void)updateConstraints
{
    [self.contentView removeConstraints:hConstraints];
    
    NSDictionary *vDict = @{@"label": self.textLabelTD, @"image": selectionIndicator};
    
    if (self.selected) {
        
        hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|-(hBuffer)-[label]-(10)-[image]-(hBuffer)-|"
                                                               options:NSLayoutFormatAlignAllCenterY
                                                               metrics:@{@"hBuffer": @50}
                                                                 views:vDict];

    } else {
        hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|-(hBuffer)-[label]-(10)-[image(==0)]-(sBuffer)-|"
                                                                                 options:NSLayoutFormatAlignAllCenterY
                                                               metrics:@{@"hBuffer": @50, @"sBuffer": @40}
                                                                                   views:vDict];
    }
    
    [self.contentView addConstraints:hConstraints];
    
    [super updateConstraints];
}
*/
-(CGSize)sizeThatFits:(CGSize)size
{
    return [super sizeThatFits:size];
}

-(CGSize)intrinsicContentSize
{
    return [super intrinsicContentSize];
}

@end
