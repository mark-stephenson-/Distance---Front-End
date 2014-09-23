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
    
    NSTimeInterval interval;
}

@end
