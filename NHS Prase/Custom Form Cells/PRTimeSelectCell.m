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
    NSInteger hours = floorf(interval / 3600.0);
    NSInteger minutes = ceilf((interval - hours * 3600) / 60.0);
    
    hourField.text = [NSString stringWithFormat:@"%ld", hours];
    minuteField.text = [NSString stringWithFormat:@"%ld", minutes];
    [self.formViewController cellValueChanged:self];
}


@end
