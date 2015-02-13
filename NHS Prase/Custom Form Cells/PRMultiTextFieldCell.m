//
//  PRMultiTextFieldCell.m
//  NHS Prase
//
//  Created by Josh Campion on 23/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRMultiTextFieldCell.h"
#import "PRInputAccessoryView.h"

#import <TheDistanceKit/TheDistanceKit_API.h>
#import "PRTheme.h"
#import "PRViewController.h"

@implementation PRMultiTextFieldCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    // adjust the field insets
    UIEdgeInsets fieldInsets = [[TDTextField appearance] textInsets];
    fieldInsets.left = 6;
    fieldInsets.right = 6;
    
    for (TDTextField *tf in textFields) {
        tf.textInsets = fieldInsets;
        tf.accessoryImage = nil;
    }
}

// override computed property to return the correct cell
-(id<TDInputAccessoryView>)fieldInputAccessoryView
{
    if (inputView == nil) {
        inputView = [[PRInputAccessoryView alloc] initWithFrame:CGRectMake(0, 0, 0, 60.0)];
        inputView.navigationDelegate = self;
    }
    
    return inputView;
}

#pragma mark - TextField Delegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *proposedChange = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
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

#pragma mark - Navigtaion Methods

-(void)configureKeyboardAccessoryView
{
    [super configureKeyboardAccessoryView];
    
    if (self.activeComponent == [textFields lastObject]) {
        inputView.nextButton.TDLocalizedStringKey = @"button.done";
        [inputView.nextButton setImage:[UIImage imageNamed:@"tick"] forState:UIControlStateNormal];
        [inputView.nextButton setBackgroundColor:[[PRTheme sharedTheme] positiveColor]];
    } else {
        inputView.nextButton.TDLocalizedStringKey = PRLocalisationKeyNext;
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
    if (self.activeComponent == [textFields lastObject]) {
        [self inputAccessoryRequestsDone:inputAccessoryView];
    } else {
        [super inputAccessoryRequestsNext:inputAccessoryView];
    }
}

@end
