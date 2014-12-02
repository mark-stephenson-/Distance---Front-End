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
#import "PRPIRTViewController.h"

@class PRQuestion;
@class TDButton;

@interface PRQuestionViewController : PRViewController <PRNoteDelegate, PRPIRTDelegate, TDInputAccessoryDelegate>
{
    IBOutlet UILabel *headerLabel;
    IBOutlet UILabel *promptLabel;
    IBOutlet UILabel *titleLabel;
    IBOutlet UIView *pirtView;
    IBOutletCollection(TDButton) NSArray *pirtButtons;
    
    IBOutlet TDButton *concernButton;
    IBOutlet TDButton *goodButton;
    IBOutlet TDButton *noteButton;
    
    BOOL validConcern;
    BOOL validNote;
    BOOL validGoodNote;
}

@property (nonatomic, strong) PRQuestion *question;
@property (nonatomic, assign) NSInteger questionIndex;

@property (nonatomic, assign) BOOL shouldHidePIRTView;

-(IBAction)addNote:(id)sender;
-(IBAction)addSomethingGood:(id)sender;
-(IBAction)addConcern:(id)sender;

-(PRInputAccessoryView *)accessoryView;
-(void)refreshPIRTViews;

@end
