//
//  PRPIRTWardSelectViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 03/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRPIRTWardSelectViewController.h"

#import <MagicalRecord/MagicalRecord.h>

#import "PRRecord.h"

#import "PRWard.h"
#import "PRHospital.h"
#import "PRTrust.h"

@implementation PRPIRTWardSelectViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BOOL noWardSelected = self.selectedWard == nil && self.selectedHospital == nil && self.selectedTrust == nil;
    
    if (noWardSelected || self.selectedWard == self.record.ward) {
        
        self.selectedTrust = self.record.ward.hospital.trust;
        self.selectedHospital = self.record.ward.hospital;
        self.selectedWard = self.record.ward;
        
        currentWardSegment.selectedSegmentIndex = 0;
    } else {
        currentWardSegment.selectedSegmentIndex = 1;
    }
    
    [self refreshViews];
}

-(void)refreshViews
{
    if ((!hasAppeared && self.selectedWard == self.record.ward) || (hasAppeared && currentWardSegment.selectedSegmentIndex == 0)) {
       
        self.selectedTrust = self.record.ward.hospital.trust;
        self.selectedHospital = self.record.ward.hospital;
        self.selectedWard = self.record.ward;
        
        [super refreshViews];
        
        hospitalField.enabled = NO;
        wardField.enabled = NO;
        otherWardField.enabled = NO;
        
    } else {
        
        [super refreshViews];
    }
}

-(void)segmentChanged:(id)sender
{
    if (currentWardSegment.selectedSegmentIndex == 1) {
        // don't overwrite the current ward, instead load a new custom selection
        if (self.selectedWard.id.integerValue < -1) {
            PRWard *blankWard = [self blankCustomWard];
            self.selectedWard = blankWard;
        }
    }
    
    [self refreshViews];
}

@end
