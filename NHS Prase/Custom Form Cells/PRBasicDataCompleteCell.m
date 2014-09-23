//
//  PRBasicDataCompleteCell.m
//  NHS Prase
//
//  Created by Josh Campion on 18/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRBasicDataCompleteCell.h"

#import "PRTheme.h"

@implementation PRBasicDataCompleteCell

-(void)setValue:(id)value
{
    if ([value isKindOfClass:[NSNumber class]]) {
        [super setValue:value];
        
        NSNumber *complete = (NSNumber *) value;
        if (complete.boolValue) {
            summaryLabel.text = TDLocalizedStringWithDefaultValue(@"summary.basic-data.complete", nil, nil, @"Complete", @"Label to show that the basic data has been completed.");
            summaryLabel.textColor = [[PRTheme sharedTheme] positiveColor];
            
            self.button.hidden = YES;
        } else {
            summaryLabel.text = TDLocalizedStringWithDefaultValue(@"summary.basic-data.incomplete", nil, nil, @"Incomplete", @"Label to show that the basic data has not been completed.");
            summaryLabel.textColor = [[PRTheme sharedTheme] negativeColor];
            
            self.button.hidden = NO;
        }
    }
}

@end
