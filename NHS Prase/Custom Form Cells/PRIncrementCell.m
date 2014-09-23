//
//  PRIncrementCell.m
//  NHS Prase
//
//  Created by Josh Campion on 16/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRIncrementCell.h"

@implementation PRIncrementCell

+(NSMutableDictionary *)cellInfoWithTitle:(NSString *)title value:(id)value andKey:(id)key
{
    if (value == nil) {
        value = @0;
    }
    
    NSMutableDictionary *info = [super cellInfoWithTitle:title value:value andKey:key];
    
    return info;
}

-(id)value
{
    return currentValue;
}

-(void)setValue:(id)value
{
    if ([value isKindOfClass:[NSNumber class]]) {
        currentValue = value;
    }
    
    if ([value isKindOfClass:[NSString class]]) {
        currentValue = @([(NSString *)value intValue]);
    }
    
    if (value == nil) {
        currentValue = @0;
    }
    
    [super setValue:currentValue];
    
    [self refreshViews];
}

-(void)refreshViews
{
    numberField.text = [currentValue stringValue];
    
    minusButton.enabled = ![currentValue isEqualToNumber:@0];
}

-(void)increment:(id)sender
{
    self.value = @(currentValue.integerValue + 1);
    [self.formViewController cellValueChanged:self];
}

-(void)decrement:(id)sender
{
    self.value = @(currentValue.integerValue - 1);
    [self.formViewController cellValueChanged:self];
}

@end
