//
//  PRTabCell.m
//  NHS Prase
//
//  Created by Josh Campion on 12/03/2015.
//  Copyright (c) 2015 The Distance. All rights reserved.
//

#import "PRTabCell.h"

#import "PRTheme.h"

@implementation PRTabCell

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // configure the colours correctly
    self.contentView.backgroundColor = self.selected ? [[PRTheme sharedTheme] mainColor] :[UIColor whiteColor];
    self.textLabelTD.textColor = self.selected ? [UIColor whiteColor] : [[PRTheme sharedTheme] mainColor];
    
}

@end
