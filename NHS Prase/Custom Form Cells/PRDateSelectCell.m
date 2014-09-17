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

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    inputView = [[PRInputAccessoryView alloc] initWithFrame:CGRectMake(0, 0, 0, 60.0)];
    inputView.navigationDelegate = self;
    
    self.scrollContainer = self.formViewController.tableView;
    self.keyboardAccessoryView = inputView;
    self.components = @[dayField, monthField, yearField];
}

-(BOOL)select
{
    if (self.activeComponent == nil) {
        [dayField becomeFirstResponder];
    } else {
        [self.activeComponent resignFirstResponder];
    }
    
    return YES;
}

-(void)done
{
    [inputView.navigationDelegate inputAccessoryRequestsDone:inputView];
    
    [super done];
}

#pragma mark - Date Methods

-(void)setValue:(id)value
{
    if ([value isKindOfClass:[NSString class]]) {
        selectedDate = [self.formatter dateFromString:value];
        if (selectedDate) {
            [super setValue:value];
        }
    }
    
    if ([value isKindOfClass:[NSDate class]]) {
        selectedDate = (NSDate *) value;
        [super setValue:[self.formatter stringFromDate:selectedDate]];
    }
    
    if (value == nil) {
        [super setValue:nil];
    }
    
    [self applyDateToFields];
}

-(void)applyDateToFields
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

-(void)applyFieldsAsDate
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
    
    
    if (![dayField.text isNonNullString] || ![monthField.text isNonNullString] || ![yearField.text isNonNullString]) {
        selectedDate = nil;
        self.value = nil;
        return;
    }
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.day = [dayField.text integerValue];
    comps.month = [monthField.text integerValue];
    comps.year = [yearField.text integerValue];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [calendar dateFromComponents:comps];
    
    [self setValue:date];
}

#pragma mark - TextField Delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [super textFieldDidBeginEditing:textField];
    
    [textField selectAll:self];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *proposedChange = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    // don't allow field to be too long
    if (proposedChange.length > ((textField == yearField) ? 4 : 2)) {
        return NO;
    }
    
    // only allow digits 0-9
    BOOL allDigit = YES;
    for (int c = 0; c < proposedChange.length && allDigit; c++) {
        char thisC = [proposedChange characterAtIndex:c];
        if (!(thisC >= '0' && thisC <= '9')) {
            allDigit = NO;
        }
    }
    
    if (!allDigit) {
        return NO;
    }
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.formViewController textFieldDidEndEditing:textField];
    
    [self applyFieldsAsDate];
}


#pragma mark - Navigtaion Methods

-(void)configureKeyboardAccessoryView
{
    [super configureKeyboardAccessoryView];
    
    if (self.activeComponent == yearField) {
        inputView.nextButton.TDLocalizedStringKey = @"button.done";
        [inputView.nextButton setImage:[UIImage imageNamed:@"tick"] forState:UIControlStateNormal];
        [inputView.nextButton setBackgroundColor:[[PRTheme sharedTheme] positiveColor]];
    } else {
        inputView.nextButton.TDLocalizedStringKey = @"button.next";
        [inputView.nextButton setImage:[UIImage imageNamed:@"next_arrow"] forState:UIControlStateNormal];
        [inputView.nextButton setBackgroundColor:[[PRTheme sharedTheme] neutralColor]];
    }
    
    [self.formViewController applyThemeToView:inputView];
}

-(BOOL)inputAccessoryCanGoToNext:(id<TDInputAccessoryView>)inputAccessoryView
{
    return YES;
}

-(void)inputAccessoryRequestsNext:(id<TDInputAccessoryView>)inputAccessoryView
{
    if (self.activeComponent == yearField) {
        [self inputAccessoryRequestsDone:inputAccessoryView];
    } else {
        [super inputAccessoryRequestsNext:inputAccessoryView];
    }
}

@end
