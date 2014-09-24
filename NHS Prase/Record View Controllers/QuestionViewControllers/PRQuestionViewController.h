//
//  PRQuestionViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 29/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRViewController.h"

#import "PRNoteViewController.h"
#import "PRInputAccessoryView.h"

@class PRQuestion;

@interface PRQuestionViewController : PRViewController <PRNoteDelegate, TDInputAccessoryDelegate>
{
    IBOutlet UILabel *headerLabel;
    IBOutlet UILabel *promptLabel;
    IBOutlet UILabel *titleLabel;
    IBOutlet UIView *pirtView;
    IBOutletCollection(PRButton) NSArray *pirtButtons;
}

@property (nonatomic, strong) PRQuestion *question;
@property (nonatomic, assign) NSInteger questionIndex;

@property (nonatomic, assign) BOOL shouldHidePIRTView;

-(IBAction)addNote:(id)sender;
-(IBAction)addSomethingGood:(id)sender;
-(IBAction)addConcern:(id)sender;


@end
