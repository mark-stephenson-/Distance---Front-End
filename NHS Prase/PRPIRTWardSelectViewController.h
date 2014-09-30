//
//  PRPIRTWardSelectViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 03/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRWardSelectViewController.h"

@class PRRecord;
@class PRWard;

/*!
 * @class PRPIRTWardSelectViewController
 * @discussion A PIRT concern can be applied to a ward which is not the same as that of the current record. This extends its superclass with a 'this ward' segment which overrides any previous choices with those entered as the record was created. Setting this ward to yes should prevent the user from changing the ward fields.
 */
@interface PRPIRTWardSelectViewController : PRWardSelectViewController
{
    BOOL hasAppeared;
    IBOutlet UISegmentedControl *currentWardSegment;
}

@property (nonatomic, strong) PRRecord *record;

-(IBAction)segmentChanged:(id)sender;

@end
