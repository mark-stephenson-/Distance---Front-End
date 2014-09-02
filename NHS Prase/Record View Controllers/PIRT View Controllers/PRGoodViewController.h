//
//  PRGoodViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 01/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRNoteViewController.h"

#import <TheDistanceKit/TheDistanceKit.h>

@class TDTextField;

@interface PRGoodViewController : PRNoteViewController <TDSelectionViewControllerDelegate>
{
    IBOutlet UISegmentedControl *thisWardControl;
    IBOutlet TDTextField *wardSelectionField;
}

@property (nonatomic, strong) NSString *thisWard;
@property (nonatomic, strong) NSString *ward;

-(IBAction)segmentChanged:(id)sender;

@end
