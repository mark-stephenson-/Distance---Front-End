//
//  PRPIRTViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 01/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRSegmentTabViewController.h"

#import "PRNoteViewController.h"
#import "PRInputAccessoryView.h"

@class PRRecord;

@interface PRPIRTViewController : PRSegmentTabViewController <PRNoteDelegate, TDInputAccessoryDelegate>
{
    PRInputAccessoryView *noteVCToolbar;
}

@property (nonatomic, strong) PRRecord *record;

-(IBAction)cancelConcern:(id) sender;

@end
