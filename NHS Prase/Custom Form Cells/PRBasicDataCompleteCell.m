//
//  PRBasicDataCompleteCell.m
//  NHS Prase
//
//  Created by Josh Campion on 18/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRBasicDataCompleteCell.h"

#import <TheDistanceKit/TheDistanceKit.h>
#import "PRTheme.h"

@implementation PRBasicDataCompleteCell

-(void)setValue:(id)value
{
    if ([value isKindOfClass:[NSNumber class]]) {
        [super setValue:value];
        
        TDButton *prButton = (TDButton *) self.button;
        
        NSNumber *complete = (NSNumber *) value;
        if (complete.boolValue) {
            summaryLabel.text = TDLocalizedStringWithDefaultValue(@"summary.basic-data.complete", nil, nil, @"Complete", @"Label to show that the basic data has been completed.");
            summaryLabel.textColor = [[PRTheme sharedTheme] positiveColor];
            
            prButton.imageTint = prButton.tintColor = [[PRTheme sharedTheme] positiveColor];
            [prButton setTitleColor:[[PRTheme sharedTheme] positiveColor] forState:UIControlStateNormal];
            
        } else {
            
            summaryLabel.text = TDLocalizedStringWithDefaultValue(@"summary.basic-data.incomplete", nil, nil, @"Incomplete", @"Label to show that the basic data has not been completed.");
            summaryLabel.textColor = [[PRTheme sharedTheme] negativeColor];
            
            prButton.imageTint = prButton.tintColor = [[PRTheme sharedTheme] negativeColor];
            [prButton setTitleColor:[[PRTheme sharedTheme] negativeColor] forState:UIControlStateNormal];
        }
    }
}

@end
