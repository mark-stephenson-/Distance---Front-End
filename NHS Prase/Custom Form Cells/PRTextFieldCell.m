//
//  PRTextFieldCell.m
//  NHS Prase
//
//  Created by Josh Campion on 27/02/2015.
//  Copyright (c) 2015 The Distance. All rights reserved.
//

#import "PRTextFieldCell.h"

#import "PRTheme.h"

@implementation PRTextFieldCell

-(void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.textField.accessoryImage != nil) {
        self.textField.accessoryImage = nil;
        [self layoutSubviews];
    }
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.numbersOnly) {
        
        NSString *proposedString = nil;
        if (textField.text != nil) {
            proposedString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        } else {
            proposedString = string;
        }
        
        
        BOOL invalid = [proposedString integerValue] > 120;
        
        if (invalid) {
            self.textField.textColor = [[PRTheme sharedTheme] negativeColor];
            self.textField.borderColor = [[PRTheme sharedTheme] negativeColor];
            self.textField.borderWidth = 2.0;
        } else {
            self.textField.textColor = [UIColor darkTextColor];
            self.textField.borderColor = [[TDTextField appearance] borderColor];
            self.textField.borderWidth = [[TDTextField appearance] borderWidth];
        }
    }
    
    return [super textField:textField shouldChangeCharactersInRange:range replacementString:string];
}

@end
