//
//  PRIncrementCell.h
//  NHS Prase
//
//  Created by Josh Campion on 16/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <TheDistanceKit/TheDistanceKit_API.h>

@interface PRIncrementCell : TDCell
{
    IBOutlet TDTextField *numberField;
    IBOutlet UIButton *minusButton;
    IBOutlet UIButton *plusButton;
    
    NSNumber *currentValue;
}

-(IBAction)increment:(id)sender;
-(IBAction)decrement:(id)sender;

@end
