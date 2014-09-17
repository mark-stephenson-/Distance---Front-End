//
//  PRDateSelectCell.h
//  NHS Prase
//
//  Created by Josh Campion on 29/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <TDFormKit/TDFormKit.h>
#import <TheDistanceKit/TheDistanceKit.h>

@class PRInputAccessoryView;

@interface PRDateSelectCell : TDCell <TDInputAccessoryDelegate, UITextFieldDelegate>
{
    PRInputAccessoryView *inputView;
    IBOutlet UITextField *dayField;
    IBOutlet UITextField *monthField;
    IBOutlet UITextField *yearField;
    
    NSDate *selectedDate;
}

@property (nonatomic, weak) NSDateFormatter *formatter;


@end
