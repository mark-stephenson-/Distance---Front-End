//
//  PRPIRTWardSelectViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 03/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRWardSelectViewController.h"

@interface PRPIRTWardSelectViewController : PRWardSelectViewController
{
    IBOutlet UISegmentedControl *currentWardSegment;
}

-(IBAction)segmentChanged:(id)sender;

@end
