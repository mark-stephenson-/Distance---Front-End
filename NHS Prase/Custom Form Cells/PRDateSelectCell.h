//
//  PRDateSelectCell.h
//  NHS Prase
//
//  Created by Josh Campion on 29/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRMultiTextFieldCell.h"

@interface PRDateSelectCell : PRMultiTextFieldCell
{
    IBOutlet TDTextField *dayField;
    IBOutlet TDTextField *monthField;
    IBOutlet TDTextField *yearField;
    
    NSDate *selectedDate;
}

@property (nonatomic, weak) NSDateFormatter *formatter;

@end
