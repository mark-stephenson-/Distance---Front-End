//
//  PRPIRTViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 01/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRSegmentTabViewController.h"

#import "PRNoteViewController.h"

@interface PRPIRTViewController : PRSegmentTabViewController <PRNoteDelegate>
{
    UIToolbar *noteVCToolbar;
}

-(IBAction)cancelConcern:(id) sender;

@end
