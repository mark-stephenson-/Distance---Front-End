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
    
    // adjust the field insets
    UIEdgeInsets fieldInsets = [[TDTextField appearance] textInsets];
    fieldInsets.left = 6;
    fieldInsets.right = 6;
    
    dayField.textInsets = fieldInsets;
    monthField.textInsets = fieldInsets;
    yearField.textInsets = fieldInsets;
    
    self.keyboardAccessoryView = inputView;
    self.components = @[dayField, monthField, yearField];
}

-(void)setFormViewController:(TDFormViewController *)formViewController
{
    [super setFormViewController:formViewController];
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
    
    [self setValue:date];
    [self.formViewController cellValueChanged:self];
}

#pragma mark - TextField Delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [super textFieldDidBeginEditing:textField];
    
    // only set the scroll container when one of this cell's fields becomes active otherwiuse another cell in this tableview could pick up the keyboard notifications causing incorrect animations.
    self.scrollContainer = self.formViewController.tableView;
    
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
    [super textFieldDidEndEditing:textField];
    
    // clear the scroll container to prevent incorrect responses to any other cells' keyboard notifications in this tableview
    self.scrollContainer = nil;
    
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
