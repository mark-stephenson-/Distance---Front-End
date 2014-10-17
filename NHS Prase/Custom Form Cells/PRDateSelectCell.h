//
//  PRDateSelectCell.h
//  NHS Prase
//
//  Created by Josh Campion on 29/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRMultiTextFieldCell.h"

/// Value is either a date if all fields are valid, an NSArray with 3 objects object (NSNumbers or NSNull) if multiple fields are invalid, or nil if no text has been entered in any fields.
@interface PRDateSelectCell : PRMultiTextFieldCell
{
    IBOutlet TDTextField *dayField;
    IBOutlet TDTextField *monthField;
    IBOutlet TDTextField *yearField;
    
    NSDate *selectedDate;
    NSArray *partialDate;
    
    BOOL invalidDay;
    BOOL invalidMonth;
    BOOL invalidYear;
}

@property (nonatomic, weak) NSDateFormatter *formatter;

@end
