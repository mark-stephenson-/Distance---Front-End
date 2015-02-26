//
//  PRSelectionTableViewCell.m
//  NHS Prase
//
//  Created by Josh Campion on 15/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRSelectionTableViewCell.h"
#import "PRTheme.h"

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
        self.detailTextLabelTD.textColor = [UIColor whiteColor];
    } else {
        self.contentView.backgroundColor = [self.detailTextLabelTD.text isNonNullString] ? [[[PRTheme sharedTheme] neutralColor] colorWithAlphaComponent:0.3] : [UIColor clearColor];
        self.textLabelTD.textColor = [UIColor darkTextColor];
        self.detailTextLabelTD.textColor = [UIColor whiteColor];
    }
    
    [self setNeedsUpdateConstraints];
    [self setNeedsLayout];
    [self invalidateIntrinsicContentSize];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabelTD.preferredMaxLayoutWidth = self.textLabelTD.frame.size.width;
    self.detailTextLabelTD.preferredMaxLayoutWidth = self.textLabelTD.frame.size.width;
}

@end
