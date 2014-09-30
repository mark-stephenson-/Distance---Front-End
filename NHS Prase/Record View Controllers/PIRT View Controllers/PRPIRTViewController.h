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
@class PRConcern;

@class PRPIRTViewController;
@class PRPIRTWardSelectViewController;
@class PRNoteViewController;
@class PRPIRTQuestionsViewController;

@protocol PRPIRTDelegate <NSObject>

-(void)pirtViewControllerDidFinish:(PRPIRTViewController *) pirtVC withConcern:(PRConcern *) concern;
-(void)pirtViewControllerDidCancel:(PRPIRTViewController *)pirtVC;

@end


@interface PRPIRTViewController : PRSegmentTabViewController <PRNoteDelegate, TDInputAccessoryDelegate>
{
    PRPIRTWardSelectViewController *wardSelectVC;
    PRNoteViewController *whatViewController;
    PRNoteViewController *whyViewController;
    PRNoteViewController *preventViewController;
    PRPIRTQuestionsViewController *questionsVC;
    
    PRInputAccessoryView *noteVCToolbar;
}

@property (nonatomic, strong) PRRecord *record;
@property (nonatomic, weak) id<PRPIRTDelegate> pirtDelegate;

-(IBAction)cancelConcern:(id) sender;

@end
