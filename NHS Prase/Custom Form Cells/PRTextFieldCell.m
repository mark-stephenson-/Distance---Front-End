//
//  PRTextFieldCell.m
//  NHS Prase
//
//  Created by Josh Campion on 27/02/2015.
//  Copyright (c) 2015 The Distance. All rights reserved.
//

#import "PRTextFieldCell.h"

@implementation PRTextFieldCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.textField.accessoryImage != nil) {
        self.textField.accessoryImage = nil;
        [self layoutSubviews];
    }
}

@end
