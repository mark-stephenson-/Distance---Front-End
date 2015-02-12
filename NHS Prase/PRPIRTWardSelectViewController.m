//
//  PRPIRTWardSelectViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 03/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRPIRTWardSelectViewController.h"

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
    if (willAppear && currentWardSegment.selectedSegmentIndex == 0) {
       
        self.selectedTrust = self.record.ward.hospital.trust;
        self.selectedHospital = self.record.ward.hospital;
        self.selectedWard = self.record.ward;
        
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
