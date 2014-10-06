//
//  PRTimeSelectCell.m
//  NHS Prase
//
//  Created by Josh Campion on 23/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRTimeSelectCell.h"

@implementation PRTimeSelectCell

-(id)value
{
    return @(interval);
}

-(void)setValue:(id)value
{
    if ([value isKindOfClass:[NSNumber class]]) {
        interval = ((NSNumber *)value).integerValue;
        [self applyValueToFields];
    }
}

-(void)applyFieldsToValue
{
    NSInteger hours = hourField.text.integerValue;
    NSInteger minutes = minuteField.text.integerValue;
    
    interval = 60 * minutes + 3600 * hours;
    [self.formViewController cellValueChanged:self];
}

-(void)applyValueToFields
{
    int hours = floorf(interval / 3600.0);
    int minutes = ceilf((interval - hours * 3600) / 60.0);
    
    hourField.text = [NSString stringWithFormat:@"%d", hours];
    minuteField.text = [NSString stringWithFormat:@"%d", minutes];
    [self.formViewController cellValueChanged:self];
}

#pragma mark - Increment / Decrement Methods

-(void)increment:(id)sender
{
    NSInteger newMins = minuteField.text.integerValue + 1;
    NSInteger newHours = hourField.text.integerValue;
    
    if (newMins > 0 || newHours > 0) {
        decrementButton.enabled = YES;
    }
    
    if (newMins == 60) {
        newMins = 0;
        newHours++;
    }
    
    minuteField.text = [@(newMins) stringValue];
    hourField.text = [@(newHours) stringValue];
    
    [self applyFieldsToValue];
}

-(void)decrement:(id)sender
{
    NSInteger newMins = minuteField.text.integerValue - 1;
    NSInteger newHours = hourField.text.integerValue;
    
    if (newMins == 0 && newHours == 0) {
        decrementButton.enabled = NO;
    }
    
    if (newMins == -1) {
        newMins = 59;
        newHours--;
    }
    
    minuteField.text = [@(newMins) stringValue];
    hourField.text = [@(newHours) stringValue];
    
    [self applyFieldsToValue];
}


@end
