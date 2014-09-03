//
//  PRPIRTWardSelectViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 03/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRPIRTWardSelectViewController.h"

@implementation PRPIRTWardSelectViewController

-(void)refreshViews
{
    if (currentWardSegment.selectedSegmentIndex == 0) {
        
        self.selectedTrust = [[NSUserDefaults standardUserDefaults] valueForKey:@"trust"];
        self.selectedHospital = [[NSUserDefaults standardUserDefaults] valueForKey:@"hospital"];
        self.selectedWard = [[NSUserDefaults standardUserDefaults] valueForKey:@"ward"];
        
        [super refreshViews];
        
        trustField.enabled = NO;
        hospitalField.enabled = NO;
        wardField.enabled = NO;
        
    } else {
        [super refreshViews];
    }
}

-(void)segmentChanged:(id)sender
{
    [self refreshViews];
}

@end
