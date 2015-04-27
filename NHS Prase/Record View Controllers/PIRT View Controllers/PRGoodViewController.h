//
//  PRGoodViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 01/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRNoteViewController.h"

#import <TheDistanceKit/TheDistanceKit_API.h>

@class TDTextField;
@class PRRecord;
@class PRWard;

@interface PRGoodViewController : PRNoteViewController <TDSelectionViewControllerDelegate>
{
    IBOutlet UISegmentedControl *thisWardControl;
    IBOutlet TDTextField *wardSelectionField;
}

@property (nonatomic, strong) PRRecord *record;
@property (nonatomic, strong) PRWard *selectedWard;

-(IBAction)segmentChanged:(id)sender;

@end
