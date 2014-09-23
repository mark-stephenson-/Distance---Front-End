//
//  PRDateSelectCell.m
//  NHS Prase
//
//  Created by Josh Campion on 29/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRDateSelectCell.h"

#import "PRInputAccessoryView.h"
#import "PRTheme.h"
#import "PRButton.h"

@implementation PRDateSelectCell


-(id)value
{
    return selectedDate;
}

-(void)setValue:(id)value
{
    if ([value isKindOfClass:[NSString class]]) {
        selectedDate = [self.formatter dateFromString:value];
    }
    
    if ([value isKindOfClass:[NSDate class]]) {
        selectedDate = (NSDate *) value;
    }
    
    if (value == nil) {
        // This should only be called externally. Setting to nil should clear the text.
        dayField.text = @"";
        monthField.text = @"";
        yearField.text = @"";
    }
    
    [self applyValueToFields];
}

-(void)applyValueToFields
{
    if (selectedDate == nil) {
        return;
    }
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:selectedDate];
    
    [dayField setText:[NSString stringWithFormat:@"%02ld",comps.day]];
    [monthField setText:[NSString stringWithFormat:@"%02ld",comps.month]];
    [yearField setText:[NSString stringWithFormat:@"%04ld", comps.year]];
}

-(void)applyFieldsToValue
{
    if ([dayField.text isNonNullString]) {
        [dayField setText:[NSString stringWithFormat:@"%02d", dayField.text.intValue]];
    }
    
    if ([monthField.text isNonNullString]) {
        [monthField setText:[NSString stringWithFormat:@"%02d", monthField.text.intValue]];
    }
    
    if ([yearField.text isNonNullString]) {
        [yearField setText:[NSString stringWithFormat:@"%04d",  yearField.text.intValue]];
    }
    
    // validate the dates
    if (yearField.text.intValue < 1864) {
        yearField.text = nil;
    }
    
    if (monthField.text.intValue > 12 ) {
        monthField.text = nil;
    }
    
    if ([monthField.text isNonNullString]) {
        
        int dayLimit = 31;
        
        switch (monthField.text.intValue) {
            case 2:
                dayLimit = 29;
                break;
            case 4:
            case 6:
            case 9:
            case 11:
                dayLimit = 30;
            default:
                break;
        }
        
        if (dayField.text.intValue > dayLimit) {
            dayField.text = nil;
        }
        
    } else {
        if (dayField.text.intValue > 31) {
            dayField.text = nil;
        }
    }
    
    if (![dayField.text isNonNullString] || ![monthField.text isNonNullString] || ![yearField.text isNonNullString]) {
        selectedDate = nil;
        [self.formViewController cellValueChanged:self];
        return;
    }
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.day = [dayField.text integerValue];
    comps.month = [monthField.text integerValue];
    comps.year = [yearField.text integerValue];
    comps.hour = 12; // set the time to be midday to ensure BST / GMT doesn't change the date component
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [calendar dateFromComponents:comps];
    
    selectedDate = date;
    [self.formViewController cellValueChanged:self];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *proposedChange = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    // don't allow field to be too long
    if (proposedChange.length > ((textField == yearField) ? 4 : 2)) {
        return NO;
    } else {
        return [super textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
}

@end
