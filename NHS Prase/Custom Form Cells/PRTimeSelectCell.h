//
//  PRTimeSelectCell.h
//  NHS Prase
//
//  Created by Josh Campion on 23/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRMultiTextFieldCell.h"

@interface PRTimeSelectCell : PRMultiTextFieldCell
{
    IBOutlet TDTextField *hourField;
    IBOutlet TDTextField *minuteField;
    
    IBOutlet UIButton *decrementButton;
    IBOutlet UIButton *incrementButton;
    
    NSTimeInterval interval;
}

-(IBAction)increment:(id)sender;
-(IBAction)decrement:(id)sender;

@end
