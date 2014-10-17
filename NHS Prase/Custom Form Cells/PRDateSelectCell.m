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
    if (selectedDate != nil) {
        return selectedDate;
    } else if (partialDate != nil) {
        return partialDate;
    } else {
        return nil;
    }
}

-(void)setValue:(id)value
{
    if ([value isKindOfClass:[NSString class]]) {
        selectedDate = [self.formatter dateFromString:value];
    }
    
    if ([value isKindOfClass:[NSDate class]]) {
        selectedDate = (NSDate *) value;
    }
    
    if ([value isKindOfClass:[NSArray class]]) {
        NSArray *vals = (NSArray *) value;
        
        if (vals.count == 3) {
            partialDate = vals;
        }
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
    // clear the current text
    dayField.text = @"";
    monthField.text = @"";
    yearField.text = @"";
    
    if (selectedDate == nil) {
        
        if (partialDate != nil) {
            if (partialDate[0] != [NSNull null]) {
                dayField.text = [NSString stringWithFormat:@"%d", [partialDate[0] intValue]];
            }
            
            if (partialDate[1] != [NSNull null]) {
                monthField.text = [NSString stringWithFormat:@"%d", [partialDate[1] intValue]];
            }
            
            if (partialDate[2] != [NSNull null]) {
                yearField.text = [NSString stringWithFormat:@"%d", [partialDate[2] intValue]];
            }
        }
    
        [self validateDate];
        [self configureValidFields];
        
        return;
    }
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:selectedDate];
    
    [dayField setText:[NSString stringWithFormat:@"%02ld", (long) comps.day]];
    [monthField setText:[NSString stringWithFormat:@"%02ld", (long) comps.month]];
    [yearField setText:[NSString stringWithFormat:@"%04ld", (long) comps.year]];
}

-(void)applyFieldsToValue
{
    [self validateDate];

    [self configureValidFields];
    
    // set the internal date ivars
    
    BOOL noDateEntered = ![dayField.text isNonNullString] && ![monthField.text isNonNullString] && ![yearField.text isNonNullString];
    
    if (noDateEntered) {
        partialDate = nil;
        selectedDate = nil;
    } else if (invalidDay || invalidMonth || invalidYear) {
        
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:3];
        
        if ([dayField.text isNonNullString]) {
            [array addObject:@(dayField.text.integerValue)];
        } else {
            [array addObject:[NSNull null]];
        }
        
        if ([monthField.text isNonNullString]) {
            [array addObject:@(monthField.text.integerValue)];
        } else {
            [array addObject:[NSNull null]];
        }
        
        if ([yearField.text isNonNullString]) {
            [array addObject:@(yearField.text.integerValue)];
        } else {
            [array addObject:[NSNull null]];
        }
        
        selectedDate = nil;
        partialDate = [NSArray arrayWithArray:array];
        
    } else {
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        comps.day = [dayField.text integerValue];
        comps.month = [monthField.text integerValue];
        comps.year = [yearField.text integerValue];
        comps.hour = 12; // set the time to be midday to ensure BST / GMT doesn't change the date component
        NSDate *date = [calendar dateFromComponents:comps];
        
        selectedDate = date;
        partialDate = nil;
    }
    
    [self.formViewController cellValueChanged:self];
}

-(void)configureField:(TDTextField *)textField toInvalid:(BOOL) invalid
{
        if (invalid) {
            textField.textColor = [[PRTheme sharedTheme] negativeColor];
            textField.borderColor = [[PRTheme sharedTheme] negativeColor];
            textField.borderWidth = 2.0;
        } else {
            textField.textColor = [UIColor darkTextColor];
            textField.borderColor = [[TDTextField appearance] borderColor];
            textField.borderWidth = [[TDTextField appearance] borderWidth];
        }
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

-(void)validateDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *todayComps = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
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
    invalidYear = (yearField.text.intValue < 1864) || (yearField.text.intValue > todayComps.year);
    invalidMonth = (monthField.text.intValue > 12) || (monthField.text.intValue < 1) || (yearField.text.intValue == todayComps.year && monthField.text.intValue > todayComps.month);
    invalidDay = NO;
    if (!invalidMonth) {
        
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
            invalidDay = YES;
        }
        
    } else {
        if (dayField.text.intValue > 31) {
            invalidDay = YES;
        }
    }
    
    if (!invalidDay) {
        if (yearField.text.intValue == todayComps.year && monthField.text.intValue == todayComps.month && dayField.text.intValue > todayComps.day) {
            invalidDay = YES;
        }
    }
}

/// visuals adjust the text fields based on the invalid* ivars. If there is no text entered the fields are configured as normal
-(void)configureValidFields
{
    if ([yearField.text isNonNullString]) {
        [self configureField:yearField toInvalid:invalidYear];
    } else {
        [self configureField:yearField toInvalid:NO];
    }
    
    if ([monthField.text isNonNullString]) {
        [self configureField:monthField toInvalid:invalidMonth];
    } else {
        [self configureField:monthField toInvalid:NO];
    }
    
    if ([dayField.text isNonNullString]) {
        [self configureField:dayField toInvalid:invalidDay];
    } else {
        [self configureField:dayField toInvalid:NO];
    }
}

@end
