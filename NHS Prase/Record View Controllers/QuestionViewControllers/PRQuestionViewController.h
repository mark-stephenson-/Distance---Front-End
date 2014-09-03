//
//  PRQuestionViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 29/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PRNoteViewController.h"
#import "PRInputAccessoryView.h"

@class PRQuestion;

@interface PRQuestionViewController : UIViewController <PRNoteDelegate, PRInputAccessoryDelegate>
{
    IBOutlet UILabel *titleLabel;
    IBOutlet UIView *pirtView;
    
}

@property (nonatomic, strong) PRQuestion *question;
@property (nonatomic, assign) NSInteger questionIndex;

@property (nonatomic, assign) BOOL shouldHidePIRTView;

-(IBAction)addNote:(id)sender;
-(IBAction)addSomethingGood:(id)sender;
-(IBAction)addConcern:(id)sender;


@end
